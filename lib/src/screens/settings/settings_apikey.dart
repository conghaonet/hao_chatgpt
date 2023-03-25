import 'package:flutter/material.dart';
import 'package:hao_chatgpt/src/app_manager.dart';
import 'package:hao_chatgpt/src/extensions.dart';
import 'package:hao_chatgpt/src/app_config.dart';

import '../../../l10n/generated/l10n.dart';

import '../../network/entity/api_key_entity.dart';

class SettingsApikeyPage extends StatefulWidget {
  const SettingsApikeyPage({Key? key}) : super(key: key);

  @override
  State<SettingsApikeyPage> createState() => _SettingsApikeyPageState();
}

class _SettingsApikeyPageState extends State<SettingsApikeyPage> {
  List<ApiKeyEntity> keys = [];

  @override
  void initState() {
    super.initState();
    keys.addAll(appConfig.apiKeys);
  }

  void _refreshApiKeys() {
    setState(() {
      keys.clear();
      keys.addAll(appConfig.apiKeys);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API keys'),
        actions: [
          IconButton(
            onPressed: () async {
              bool? result = await _showAddApiDialog(context);
              if (result == true) {
                _refreshApiKeys();
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: keys.length + (appManager.innerApiKey.isNotBlank ? 1 : 0),
        separatorBuilder: (context, index) {
          return const Divider(
            height: 2,
            thickness: 2,
          );
        },
        itemBuilder: (context, index) {
          if (index < keys.length) {
            return Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    value: keys[index].key,
                    groupValue: appManager.openaiApiKey,
                    onChanged: (value) async {
                      await appConfig.setApiKey(value);
                      _refreshApiKeys();
                    },
                    title: Text(getMaskedApiKey(keys[index].key)),
                    subtitle: Text(
                        S.of(context).createdDate(keys[index].createdTime)),
                  ),
                ),
                IconButton(
                  onPressed: appManager.openaiApiKey == keys[index].key
                      ? null
                      : () async {
                          bool? result = await _showRemoveApiDialog(
                              context, keys[index].key);
                          if (result == true) {
                            _refreshApiKeys();
                          }
                        },
                  icon: const Icon(Icons.delete_forever),
                ),
              ],
            );
          } else {
            return RadioListTile(
              value: appManager.innerApiKey!,
              groupValue: appManager.openaiApiKey,
              onChanged: (value) async {
                await appConfig.setApiKey(null);
                _refreshApiKeys();
              },
              title: Text(
                getMaskedApiKey(appManager.innerApiKey!),
              ),
              subtitle: Text('${S.of(context).default_} API key'),
            );
          }
        },
      ),
    );
  }

  Future<bool?> _showRemoveApiDialog(BuildContext context, String keyValue) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(
            '${S.of(ctx).remove} API key',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: Text(keyValue.length > 8
              ? '${keyValue.substring(0, 4)}...${keyValue.substring(keyValue.length - 4, keyValue.length)}'
              : keyValue),
          actions: [
            TextButton(
              onPressed: () async {
                await appConfig
                    .removeApiKey(keyValue)
                    .then((_) => Navigator.of(ctx).pop(true));
              },
              child: Text(S.of(ctx).remove),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(S.of(ctx).cancel),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showAddApiDialog(BuildContext context) {
    String? keyValue;
    return showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text(
            'API key',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
            ),
            onChanged: (value) {
              keyValue = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (keyValue.isNotBlank) {
                  keyValue = keyValue!.trim();
                  try {
                    // duplicate API key
                    appConfig.apiKeys
                        .firstWhere((element) => element.key == keyValue);
                    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                      content: Text(S.of(ctx).duplicateApiKey),
                    ));
                    Navigator.of(ctx).pop(false);
                  } catch (e) {
                    if (keyValue == appManager.innerApiKey) {
                      // duplicate API key
                      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                        content: Text(S.of(ctx).duplicateApiKey),
                      ));
                      Navigator.of(ctx).pop(false);
                    } else {
                      ApiKeyEntity entity =
                          ApiKeyEntity(keyValue!, DateTime.now());
                      await appConfig
                          .addApiKey(entity)
                          .then((_) => Navigator.of(ctx).pop(true));
                    }
                  }
                }
              },
              child: Text(S.of(ctx).confirm),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(S.of(ctx).cancel),
            ),
          ],
        );
      },
    );
  }
}
