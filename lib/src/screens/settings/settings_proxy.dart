import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hao_chatgpt/main.dart';
import 'package:hao_chatgpt/src/constants.dart';
import 'package:hao_chatgpt/src/extensions.dart';
import 'package:hao_chatgpt/src/app_config.dart';

import '../../../l10n/generated/l10n.dart';

class SettingsProxy extends ConsumerStatefulWidget {
  const SettingsProxy({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsProxy> createState() => _SettingsProxyState();
}

class _SettingsProxyState extends ConsumerState<SettingsProxy> {
  final _hostnameController = TextEditingController();
  final _portNumberController = TextEditingController();
  final GlobalKey _formKey  = GlobalKey<FormState>();
  bool _enableProxy = false;

  @override
  void initState() {
    super.initState();
    String? value = appConfig.httpProxy;
    if(value.isNotBlank) {
      List<String> args = value!.split(Constants.splitTag);
      if(args.length == 3) {
        _enableProxy = args[0] == true.toString();
        _hostnameController.text = args[1];
        _portNumberController.text = args[2];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).httpProxy),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(S.of(context).enableProxy),
                const SizedBox(width: 8,),
                Checkbox(
                  value: _enableProxy,
                  onChanged: (value) {
                    _enableProxy = value!;
                    setState(() {

                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12,),
            TextFormField(
              enabled: _enableProxy,
              controller: _hostnameController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: S.of(context).hostName,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              validator: (v) {
                return _enableProxy && (v == null || v.trim().isEmpty) ? '' : null;
              },
            ),
            const SizedBox(height: 20,),
            TextFormField(
              enabled: _enableProxy,
              controller: _portNumberController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: S.of(context).portNumber,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              validator: (v) {
                return _enableProxy && (v == null || v.trim().isEmpty) ? '' : null;
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter(RegExp("[0-9]"), allow: true,),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if((_formKey.currentState as FormState).validate()) {
              await appConfig.setHttpProxy(_enableProxy, _hostnameController.text, int.tryParse(_portNumberController.text));
              ref.read(proxyProvider.notifier).state = appConfig.httpProxy;
              setState(() {
                context.pop();
              });
            }
          },
          child: Text(S.of(context).confirm),
        ),
        TextButton(
          onPressed: () => context.pop(),
          child: Text(S.of(context).cancel),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _hostnameController.dispose();
    _portNumberController.dispose();
    super.dispose();
  }
}
