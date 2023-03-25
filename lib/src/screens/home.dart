import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hao_chatgpt/src/app_router.dart';
import 'package:hao_chatgpt/src/extensions.dart';

import '../../l10n/generated/l10n.dart';
import '../app_shortcuts.dart';
import '../constants.dart';
import '../app_config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

/*
  Map<LogicalKeySet, Intent> _getShortcuts() {
    if(Platform.isAndroid || Platform.isAndroid) {
      return {};
    } else {
      List<LogicalKeySet> keySets = getShortcutsKeys().values.toList();
      keySets.remove(appPref.shortcutsSend);
      return {
        appPref.shortcutsSend!: const SendIntent(),
        keySets.first: const NewLineIntent(),
      };
    }
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(flex: 2, child: Container()),
              Text(
                S.of(context).haoChat,
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              const ImageIcon(
                AssetImage('assets/images/openai.png'),
                size: 48,
              ),
              const SizedBox(
                height: 32,
              ),
              Expanded(flex: 3, child: Container()),
              ListTile(
                leading: const Icon(Icons.chat),
                title: Text(S.of(context).gpt35turbo),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  context.go('/${AppUri.chatTurbo}');
                },
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Theme.of(context).primaryColorLight.withOpacity(0.5),
              ),
/*
              ListTile(
                leading: const Icon(Icons.chat),
                title: Text('${S.of(context).chatGPT} (GPT-3)'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  context.go('/${AppUri.chat}');
                },
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Theme.of(context).primaryColorLight.withOpacity(0.5),
              ),
*/
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text(S.of(context).settings),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  context.go('/${AppUri.settings}');
                },
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Theme.of(context).primaryColorLight.withOpacity(0.5),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: Text('${S.of(context).openAI} ${S.of(context).chatGPT}'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () async {
                  await openWebView(
                      context: context,
                      url: Constants.aboutChatGPTUrl,
                      title: 'ChatGPT');
                },
              ),
              Expanded(flex: 3, child: Container()),
              TextButton(
                onPressed: () async {
                  openWebView(
                      context: context,
                      url: Constants.haoChatGitHubUrl,
                      title: 'hao_chatgpt');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    '${S.of(context).appDescription}\nPowered by Conghaonet',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10, color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
