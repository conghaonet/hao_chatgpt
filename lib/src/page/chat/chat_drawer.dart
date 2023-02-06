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
  final int _rowsOfPage = 20;
  int _pageNo = 0;


  @override
  void initState() {
    super.initState();
    _loadChatTitles();
  }

  void _loadChatTitles({bool isLoadMore = false}) async {
    var statement = haoDatabase.select(haoDatabase.chatTitles);
    if(isLoadMore && _titles.isNotEmpty) {
      statement.where((tbl) => tbl.id.isSmallerThanValue(_titles.last.id));
    }
    statement.limit(_rowsOfPage);
    statement.orderBy([(t) => drift.OrderingTerm(mode: drift.OrderingMode.desc, expression: t.id)]);
    final titles = await statement.get();
    if(mounted) {
      setState(() {
        if(!isLoadMore) {
          _titles.clear();
          _pageNo = 0;
        }
        if(titles.isNotEmpty) {
          ++_pageNo;
          _titles.addAll(titles);
        }
      });
    }
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
                    if(index + 1 == _titles.length && _titles.length == _pageNo* _rowsOfPage) {
                      Future.delayed(const Duration(milliseconds: 200), () {
                        _loadChatTitles(isLoadMore: true);
                      });
                    }
                    return _buildChatTitle(_titles[index]);
                  },
                  itemCount: _titles.length,
                ),
              ),
              const Divider(height: 1,),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text(S.of(context).settings),
                onTap: () {
                  context.pop();
                  context.push('/settings');
                },
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
