import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hao_chatgpt/src/app_router.dart';

import '../../../l10n/generated/l10n.dart';
import '../../db/hao_database.dart';
import '../../screens/chat_turbo/chat_turbo_menu.dart';

typedef OnClickChat = void Function(int? titleId);

/// see [ChatTurboMenu]
@Deprecated('Use ChatTurboMenu instead')
class ChatDrawer extends StatefulWidget {
  final OnClickChat? onClickChat;
  final int? chatId;
  const ChatDrawer({this.chatId, this.onClickChat, Key? key}) : super(key: key);

  @override
  State<ChatDrawer> createState() => _ChatDrawerState();
}

class _ChatDrawerState extends State<ChatDrawer> {
  final List<ChatTitle> _chats = [];
  final int _rowsOfPage = 20;
  int _pageNo = 0;
  bool _isSelectAll = false;
  EditMode _editMode = EditMode.normal;
  final List<int> _checkedIds = [];


  @override
  void initState() {
    super.initState();
    _loadChatTitles();
  }

  void _loadChatTitles({bool isLoadMore = false}) async {
    var statement = haoDatabase.select(haoDatabase.chatTitles);
    if(isLoadMore && _chats.isNotEmpty) {
      statement.where((tbl) => tbl.id.isSmallerThanValue(_chats.last.id));
    }
    statement.limit(_rowsOfPage);
    statement.orderBy([(t) => drift.OrderingTerm(mode: drift.OrderingMode.desc, expression: t.id)]);
    final titles = await statement.get();
    if(mounted) {
      setState(() {
        if(!isLoadMore) {
          _chats.clear();
          _pageNo = 0;
        }
        if(titles.isNotEmpty) {
          ++_pageNo;
          _chats.addAll(titles);
        }
      });
    }
  }

  Future<void> _deleteChats() async {
    try {
      await haoDatabase.batch((batch) {
        String chatTitleExp = '';
        String conversationExp = '';
        if(_isSelectAll) {
          if(widget.chatId == null && _checkedIds.isEmpty) {
            batch.deleteAll(haoDatabase.conversations);
            batch.deleteAll(haoDatabase.chatTitles);
          } else {
            List<int> ids = _checkedIds;
            if(widget.chatId != null) {
              ids.add(widget.chatId!);
            }
            for(int i=0; i<ids.length; i++) {
              if(i > 0) {
                chatTitleExp += ' and ';
                conversationExp += ' and ';
              }
              chatTitleExp += '${haoDatabase.chatTitles.id.name} != ${ids[i]}';
              conversationExp += '${haoDatabase.conversations.titleId.name} != ${ids[i]}';
            }
          }
        } else {
          for(int i=0; i<_checkedIds.length; i++) {
            if(i > 0) {
              chatTitleExp += ' or ';
              conversationExp += ' or ';
            }
            chatTitleExp += '${haoDatabase.chatTitles.id.name} = ${_checkedIds[i]}';
            conversationExp += '${haoDatabase.conversations.titleId.name} = ${_checkedIds[i]}';
          }
        }
        if(chatTitleExp.isNotEmpty && conversationExp.isNotEmpty) {
          batch.deleteWhere(haoDatabase.conversations, (tbl) => drift.CustomExpression(conversationExp));
          batch.deleteWhere(haoDatabase.chatTitles, (tbl) => drift.CustomExpression(chatTitleExp));
        }
      });
    } catch(e) {
      debugPrint(e.toString());
    } finally {
      _editMode = EditMode.normal;
      _isSelectAll = false;
      _checkedIds.clear();
      _loadChatTitles();
    }

  }

  bool _canDelete() {
    if(_chats.isEmpty) {
      return false;
    } else {
      if(_chats.length == 1 && _chats.first.id == widget.chatId) {
        return false;
      } else {
        if(_isSelectAll) {
          return true;
        } else {
          if(_checkedIds.isEmpty) {
            return false;
          } else {
            return true;
          }
        }
      }
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
                    if(index + 1 == _chats.length && _chats.length == _pageNo* _rowsOfPage) {
                      Future.delayed(const Duration(milliseconds: 200), () {
                        _loadChatTitles(isLoadMore: true);
                      });
                    }
                    return _buildChatTitle(_chats[index]);
                  },
                  itemCount: _chats.length,
                ),
              ),
              _buildDeleteButtons(),
              const Divider(height: 1,),
              _buildDeleteMenu(),
              ListTile(
                leading: const Icon(Icons.home),
                title: Text(S.of(context).home),
                onTap: () {
                  context.pop();
                  context.go(AppUri.root);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text(S.of(context).settings),
                onTap: () {
                  context.pop();
                  context.push('/${AppUri.settings}');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatTitle(ChatTitle chatTitle) {
    bool isChecked(int id) {
      if(_isSelectAll) {
        return !_checkedIds.contains(id);
      } else {
        return _checkedIds.contains(id);
      }
    }
    return _editMode != EditMode.normal && widget.chatId != chatTitle.id ? CheckboxListTile(
      value: isChecked(chatTitle.id),
      onChanged: (value) {
        setState(() {
          if(value == true) {
            if(_isSelectAll) {
              _checkedIds.remove(chatTitle.id);
            } else {
              _checkedIds.add(chatTitle.id);
            }
          } else {
            if(_isSelectAll) {
              _checkedIds.add(chatTitle.id);
            } else {
              _checkedIds.remove(chatTitle.id);
            }
          }
        });
      },
      title: Text(chatTitle.title, maxLines: 1, overflow: TextOverflow.ellipsis,),
    ) : ListTile(
      horizontalTitleGap: 0.0,
      leading: const Icon(Icons.chat_outlined),
      title: Text(chatTitle.title, maxLines: 1, overflow: TextOverflow.ellipsis,),
      onTap: () {
        context.pop();
        if(widget.onClickChat != null) {
          widget.onClickChat!(chatTitle.id);
        }
      },
    );
  }

  Widget _buildDeleteMenu() {
    if(_chats.isEmpty || (_chats.length == 1 && _chats.first.id == widget.chatId)) {
      return Container();
    } else {
      if(_editMode == EditMode.normal) {
        return ListTile(
          leading: const Icon(Icons.delete),
          title: Text(S.of(context).deleteConversations),
          onTap: () {
            setState(() {
              _editMode = EditMode.delete;
            });
          },
        );
      } else {
        return ListTile(
          leading: const Icon(Icons.undo),
          title: Text(S.of(context).cancel),
          onTap: () {
            setState(() {
              _editMode = EditMode.normal;
              _isSelectAll = false;
              _checkedIds.clear();
            });
          },
        );
      }
    }
  }
  Widget _buildDeleteButtons() {
    switch(_editMode) {
      case EditMode.delete:
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _checkedIds.clear();
                    _isSelectAll = true;
                  });

                },
                icon: const Icon(Icons.select_all),
                label: Text(S.of(context).selectAll),
              ),
              OutlinedButton.icon(
                onPressed: !_canDelete() ? null : () {
                  setState(() {
                    _editMode = EditMode.confirm;
                  });
                },
                icon: const Icon(Icons.delete),
                label: Text(S.of(context).delete),
              ),
            ],
          ),
        );
      case EditMode.confirm:
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: OutlinedButton.icon(
            icon: const Icon(Icons.done),
            label: Text(S.of(context).confirmDelete),
            onPressed: () {
              setState(() {
                _editMode = EditMode.doing;
                _deleteChats();
              });
            },
          ),
        );
      case EditMode.doing:
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: const CircularProgressIndicator(),
        );
      default:
        return Container();
    }
  }
}

enum EditMode {
  normal, delete, confirm, doing,
}
