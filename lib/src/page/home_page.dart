import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/generated/l10n.dart';
import '../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(flex: 2, child: Container()),
            Text(S.of(context).haoChat, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(height: 16,),
            const ImageIcon(AssetImage('assets/images/openai.png'), size: 48,),
            const SizedBox(height: 32,),
            Expanded(flex: 3, child: Container()),
            ListTile(
              leading: const Icon(Icons.chat),
              title: Text(S.of(context).chatGPT),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                context.go('/chat_page');
              },
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Theme.of(context).primaryColorLight.withOpacity(0.5),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(S.of(context).settings),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                context.go('/settings');
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
              onTap: () {
                context.push('/webview?title=ChatGPT&url=${Constants.aboutChatGPTUrl}');
              },
            ),
            Expanded(flex: 3, child: Container()),
          ],
        ),
      ),
    );
  }
}
