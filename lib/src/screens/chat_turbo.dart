import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hao_chatgpt/main.dart';
import 'package:hao_chatgpt/src/screens/chat_turbo/chat_turbo_menu.dart';

import '../../l10n/generated/l10n.dart';
import '../extensions.dart';
import 'chat_turbo/chat_turbo_system.dart';

class ChatTurbo extends ConsumerStatefulWidget {
  const ChatTurbo({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatTurbo> createState() => _ChatTurboState();
}

class _ChatTurboState extends ConsumerState<ChatTurbo> {
  final TextEditingController _promptTextController = TextEditingController();

  void _onDrawerChanged(bool isEndDrawer, bool isOpened) {
    if(isOpened) {
      FocusManager.instance.primaryFocus?.unfocus();
    } else {
      debugPrint(ref.read(chatTurboSystemProvider));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(child: ChatTurboMenu()),
      onDrawerChanged: (bool isOpened) => _onDrawerChanged(false, isOpened),
      endDrawer: SafeArea(child: ChatTurboSystem()),
      onEndDrawerChanged: (bool isOpened) => _onDrawerChanged(true, isOpened),
      body: WillPopScope(
        onWillPop: () async {
          await androidBackToHome();
          return false;
        },
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: isDesktop(),
                      snap: true,
                      floating: true,
                      title: Text(S.of(context).gpt35turbo),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                        return Container(
                          height: 100.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Center(
                            child: Text('$index', style: TextStyle(fontSize: 32, color: index.isEven ? Colors.red : Colors.blue),),
                          ),
                        );
                      },
                        childCount: 20,
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _promptTextController,
                        maxLines: 5,
                        minLines: 1,
                        decoration: InputDecoration(
                          hintText: S.of(context).chatTurboSystemHint,
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: Text('发送'),
                      onPressed: () {

                      },
                    ),
                  ]
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _promptTextController.dispose();
    super.dispose();
  }
}
