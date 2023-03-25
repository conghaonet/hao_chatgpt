import 'package:flutter/material.dart';
import 'package:hao_chatgpt/src/extensions.dart';

import '../../../l10n/generated/l10n.dart';
import '../../constants.dart';
import '../../network/entity/api_key_entity.dart';
import '../../app_config.dart';

class NoKeyView extends StatefulWidget {
  final VoidCallback? onFinished;
  const NoKeyView({this.onFinished, Key? key}) : super(key: key);

  @override
  State<NoKeyView> createState() => _NoKeyViewState();
}

class _NoKeyViewState extends State<NoKeyView> {
  String _apiKeyValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(S.of(context).haoChatIsPoweredByOpenAI, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        const SizedBox(height: 16,),
        Text(S.of(context).storeAPIkeyNotice, style: const TextStyle(fontSize: 12,),),
        const SizedBox(height: 16,),
        TextField(
          maxLines: 1,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: S.of(context).enterYourOpenAiApiKey,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          onChanged: (value) {
            if((value.isNotBlank && !_apiKeyValue.isNotBlank) || (!value.isNotBlank && _apiKeyValue.isNotBlank)) {
              setState(() {
                _apiKeyValue = value;
              });
            } else {
              _apiKeyValue = value;
            }
          },
        ),
        const SizedBox(height: 8,),
        Row(
          children: [
            Expanded(child: Container(),),
            Expanded(
              child: ElevatedButton(
                onPressed: _apiKeyValue.isNotBlank ? () async {
                  if(_apiKeyValue.isNotBlank) {
                    ApiKeyEntity entity =
                    ApiKeyEntity(_apiKeyValue.trim(), DateTime.now());
                    appConfig.addApiKey(entity).then((_) {
                      if(widget.onFinished != null) {
                        widget.onFinished!();
                      }
                    });
                  }
                } : null,
                child: Text(S.of(context).done),
              ),
            ),
            Expanded(child: Container(),),
          ],
        ),
        Row(
          children: [
            Text('1. ${S.of(context).navigateTo}', style: const TextStyle(fontSize: 12,),),
            Expanded(
              child: TextButton(
                onPressed: () {
                  openWebView(context: context, url: Constants.openAiApiKeysUrl, isExternal: true,);
                },
                child: const Text(Constants.openAiApiKeysUrl, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12,),),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('2. ${S.of(context).logInAndClick}', style: const TextStyle(fontSize: 12,),),
        ),
      ],
    );
  }
}
