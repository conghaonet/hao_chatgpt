import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hao_chatgpt/main.dart';

import '../../../l10n/generated/l10n.dart';
import '../../app_router.dart';
import '../../db/hao_database.dart';
import '../../extensions.dart';

typedef OnClickChat = void Function(int? titleId);
class ChatTurboMenu extends ConsumerStatefulWidget {
  final OnClickChat? onClickChat;
  final int? chatId;
  const ChatTurboMenu({this.chatId, this.onClickChat, Key? key}) : super(key: key);

  @override
  ConsumerState<ChatTurboMenu> createState() => _ChatTurboMenuState();
}

class _ChatTurboMenuState extends ConsumerState<ChatTurboMenu> {
  final List<Chat> _chats = [];
  final int _rowsOfPage = 20;
  int _pageNo = 0;
  bool _isSelectAll = false;
  EditMode _editMode = EditMode.normal;
  final List<int> _checkedIds = [];

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  void _loadChats({bool isLoadMore = false}) async {
    var statement = haoDatabase.select(haoDatabase.chats);
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
        String chatsExp = '';
        String messagesExp = '';
        if(_isSelectAll) {
          if(widget.chatId == null && _checkedIds.isEmpty) {
            batch.deleteAll(haoDatabase.messages);
            batch.deleteAll(haoDatabase.chats);
          } else {
            List<int> ids = _checkedIds;
            if(widget.chatId != null) {
              ids.add(widget.chatId!);
            }
            for(int i=0; i<ids.length; i++) {
              if(i > 0) {
                chatsExp += ' and ';
                messagesExp += ' and ';
              }
              chatsExp += '${haoDatabase.chats.id.name} != ${ids[i]}';
              messagesExp += '${haoDatabase.messages.chatId.name} != ${ids[i]}';
            }
          }
        } else {
          for(int i=0; i<_checkedIds.length; i++) {
            if(i > 0) {
              chatsExp += ' or ';
              messagesExp += ' or ';
            }
            chatsExp += '${haoDatabase.chats.id.name} = ${_checkedIds[i]}';
            messagesExp += '${haoDatabase.messages.chatId.name} = ${_checkedIds[i]}';
          }
        }
        if(chatsExp.isNotEmpty && messagesExp.isNotEmpty) {
          batch.deleteWhere(haoDatabase.messages, (tbl) => drift.CustomExpression(messagesExp));
          batch.deleteWhere(haoDatabase.chats, (tbl) => drift.CustomExpression(chatsExp));
        }
      });
    } catch(e) {
      debugPrint(e.toString());
    } finally {
      _editMode = EditMode.normal;
      _isSelectAll = false;
      _checkedIds.clear();
      _loadChats();
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
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: FractionallySizedBox(
        widthFactor: isDesktop() ? 0.4 : 0.7,
        child: Column(
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
                      _loadChats(isLoadMore: true);
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
    );
  }

  Widget _buildChatTitle(Chat chat) {
    bool isChecked(int id) {
      if(_isSelectAll) {
        return !_checkedIds.contains(id);
      } else {
        return _checkedIds.contains(id);
      }
    }
    return _editMode != EditMode.normal && widget.chatId != chat.id ? CheckboxListTile(
      value: isChecked(chat.id),
      onChanged: (value) {
        setState(() {
          if(value == true) {
            if(_isSelectAll) {
              _checkedIds.remove(chat.id);
            } else {
              _checkedIds.add(chat.id);
            }
          } else {
            if(_isSelectAll) {
              _checkedIds.add(chat.id);
            } else {
              _checkedIds.remove(chat.id);
            }
          }
        });
      },
      title: Text(chat.title, maxLines: 1, overflow: TextOverflow.ellipsis,),
    ) : ListTile(
      horizontalTitleGap: 0.0,
      leading: const Icon(Icons.chat_outlined),
      title: Text(chat.title, maxLines: 1, overflow: TextOverflow.ellipsis,),
      onTap: () {
        context.pop();
        if(widget.onClickChat != null) {
          ref.read(systemPromptProvider.notifier).state = chat.system;
          widget.onClickChat!(chat.id);
        }
      },
    );
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

}

enum EditMode {
  normal, delete, confirm, doing,
}