import 'package:flutter/material.dart';
import 'package:hao_chatgpt/src/screens/chat_turbo/chat_turbo_drawer.dart';

import '../../l10n/generated/l10n.dart';
import '../extensions.dart';

class ChatTurbo extends StatefulWidget {
  const ChatTurbo({Key? key}) : super(key: key);

  @override
  State<ChatTurbo> createState() => _ChatTurboState();
}

class _ChatTurboState extends State<ChatTurbo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).gpt35turbo),
      ),
      drawer: ChatTurboDrawer(),
      onDrawerChanged: (bool isOpened) {
        if(isOpened) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      body: WillPopScope(
        onWillPop: () async {
          await androidBackToHome();
          return false;
        },
        child: SafeArea(
          child: Column(

          ),
        ),
      ),
    );
  }
}
