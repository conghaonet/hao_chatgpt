import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/generated/l10n.dart';
import '../../db/hao_database.dart';

typedef OnClickChat = void Function(int? titleId);
class ChatDrawer extends StatefulWidget {
  final OnClickChat? onClickChat;
  const ChatDrawer({this.onClickChat, Key? key}) : super(key: key);

  @override
  State<ChatDrawer> createState() => _ChatDrawerState();
}

class _ChatDrawerState extends State<ChatDrawer> {
  final List<ChatTitle> _titles = [];

  @override
  void initState() {
    super.initState();
    Future(() async {
      var statement = haoDatabase.select(haoDatabase.chatTitles);
      statement.limit(20);
      statement.orderBy([(t) => drift.OrderingTerm(mode: drift.OrderingMode.desc, expression: t.id)]);
      final titles = await statement.get();
      _titles.addAll(titles);
      if(mounted) {
        setState(() {
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ListTile(
                horizontalTitleGap: 0.0,
                leading: const Icon(Icons.add),
                title: Text(S.of(context).newChat),
                onTap: () {
                  context.pop();
                  if(widget.onClickChat != null) {
                    widget.onClickChat!(null);
                  }
                },
              ),
              const Divider(height: 1,),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return _buildChatTitle(_titles[index]);
                  },
                  itemCount: _titles.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatTitle(ChatTitle chatTitle) {
    return ListTile(
      horizontalTitleGap: 0.0,
      leading: const Icon(Icons.chat_bubble_outline),
      title: Text(chatTitle.title, maxLines: 1, overflow: TextOverflow.ellipsis,),
      onTap: () {
        context.pop();
        if(widget.onClickChat != null) {
          widget.onClickChat!(chatTitle.id);
        }
      },
    );
  }
}
