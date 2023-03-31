import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hao_chatgpt/main.dart';
import 'package:hao_chatgpt/src/db/hao_database.dart';
import 'package:hao_chatgpt/src/app_config.dart';
import 'package:hao_chatgpt/src/screens/chat/no_key_view.dart';
import 'package:hao_chatgpt/src/screens/chat_turbo/chat_turbo_content.dart';
import 'package:hao_chatgpt/src/screens/chat_turbo/chat_turbo_menu.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../l10n/generated/l10n.dart';
import '../app_manager.dart';
import '../app_router.dart';
import '../app_shortcuts.dart';
import '../constants.dart';
import '../extensions.dart';
import '../network/entity/dio_error_entity.dart';
import '../network/entity/openai/chat_entity.dart';
import '../network/entity/openai/chat_message_entity.dart';
import '../network/entity/openai/chat_query_entity.dart';
import '../network/openai_service.dart';
import 'chat_turbo/chat_turbo_system.dart';
import 'package:drift/drift.dart' as drift;

class ChatTurbo extends ConsumerStatefulWidget {
  final int? chatId;
  const ChatTurbo({this.chatId, Key? key}) : super(key: key);

  @override
  ConsumerState<ChatTurbo> createState() => _ChatTurboState();
}

class _ChatTurboState extends ConsumerState<ChatTurbo> {
  bool _drawerIsOpened = false;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _promptTextController = TextEditingController();
  final List<Message> _messages = [];
  bool _isLoading = false;
  int? _chatId;
  DioErrorEntity? _errorEntity;

  @override
  void initState() {
    super.initState();
    _chatId = widget.chatId;
    if(_chatId != null) {
      Future(() async {
        var statement = haoDatabase.select(haoDatabase.messages);
        statement.where((tbl) => tbl.chatId.equals(_chatId!));
        final List<Message> messages = await statement.get();
        _messages.addAll(messages);
        if(mounted) {
          setState(() {
          });
        }
      });
    }
  }

  Future<void> _request() async {
    if(_isLoading) return;
    int? adjustedTokens;
    if(_errorEntity?.code == 'context_length_exceeded') {
      adjustedTokens = _errorEntity!.adjustedTokens;
    }
    setState(() {
      _isLoading = true;
      _errorEntity = null;
    });
    try {
      if(context.mounted) {
        String systemPrompt = _getSystemPrompt();
        String inputMsg = _promptTextController.text.trim();
        if(inputMsg.isNotBlank) {
          _chatId ??= await _saveChatToDatabase(inputMsg, systemPrompt);
          await _saveInputMsgToDatabase(inputMsg);
          _promptTextController.text = '';
          if(mounted) {
            setState(() {
            });
            Future.delayed(const Duration(milliseconds: 100), () {
              _scrollToEnd();
            });
          }
        }
        List<ChatMessageEntity> queryMessages = [
          ChatMessageEntity(role: ChatRole.system, content: systemPrompt),
          ..._messages.map((e) => ChatMessageEntity(role: e.role, content: e.content)).toList()
        ];
        ChatQueryEntity queryEntity = appConfig.gpt35TurboSettings ?? ChatQueryEntity(messages: [],);
        queryEntity.messages = queryMessages;
        queryEntity.maxTokens = adjustedTokens ?? queryEntity.maxTokens;

        ChatEntity chatEntity = await openaiService.getChatCompletions(queryEntity);
        if(chatEntity.choices != null && chatEntity.choices!.isNotEmpty && chatEntity.choices!.first.message != null) {
          _chatId ??= await _saveChatToDatabase(chatEntity.choices!.first.message!.content, systemPrompt);
          await _saveMessageToDatabase(chatEntity);
        }
      }
    } on DioError catch (e) {
      _errorEntity = e.toDioErrorEntity;
    } on Exception catch (e) {
      _errorEntity = e.toDioErrorEntity;
    } finally {
      if(mounted) {
        setState(() {
          _isLoading = false;
        });
        Future.delayed(const Duration(milliseconds: 100), () {
          _scrollToEnd();
        });
      }
    }
    return;
  }

  Future<int> _saveChatToDatabase(String title, String systemPrompt) async {
    int chatId = await haoDatabase.into(haoDatabase.chats).insert(ChatsCompanion.insert(
      title: title.trim(),
      system: systemPrompt,
      isFavorite: false,
      chatDateTime: DateTime.now(),
    ));
    return chatId;
  }

  Future<void> _saveInputMsgToDatabase(String inputMsg) async {
    int messageId = await haoDatabase.into(haoDatabase.messages).insert(MessagesCompanion.insert(
      chatId: _chatId!,
      role: ChatRole.user,
      content: inputMsg,
      isResponse: false,
      isFavorite: false,
      msgDateTime: DateTime.now(),
    ));
    await _appendMessage(messageId);
    return;
  }

  Future<void> _saveMessageToDatabase(ChatEntity chatEntity) async {
    int messageId = await haoDatabase.into(haoDatabase.messages).insert(MessagesCompanion.insert(
      chatId: _chatId!,
      role: chatEntity.choices!.first.message!.role,
      content: chatEntity.choices!.first.message!.content,
      isResponse: true,
      promptTokens: drift.Value(chatEntity.usage?.promptTokens),
      completionTokens: drift.Value(chatEntity.usage?.completionTokens),
      totalTokens: drift.Value(chatEntity.usage?.totalTokens),
      finishReason: drift.Value(chatEntity.choices!.first.finishReason),
      isFavorite: false,
      msgDateTime: DateTime.fromMillisecondsSinceEpoch(chatEntity.created * 1000),
    ));
    await _appendMessage(messageId);
  }

  Future<void> _appendMessage(int messageId) async {
    var query = haoDatabase.select(haoDatabase.messages)..where((tbl) => tbl.id.equals(messageId));
    var message = await query.getSingleOrNull();
    if(message != null) {
      _messages.add(message);
    }
  }

  void _scrollToEnd() {
    Future.delayed(const Duration(milliseconds: 50), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
      );
    });
  }

  void _onDrawerChanged(bool isEndDrawer, bool isOpened) async {
    setState(() {
      _drawerIsOpened = isOpened;
    });
    if(isOpened) {
      FocusManager.instance.primaryFocus?.unfocus();
    } else {
      if(isEndDrawer) {
        if(_chatId != null) {
          var statement = haoDatabase.select(haoDatabase.chats);
          statement.where((tbl) => tbl.id.equals(_chatId!));
          var chatsTable = await statement.getSingleOrNull();
          if(chatsTable != null && chatsTable.system != _getSystemPrompt()) {
            var updateStatement = haoDatabase.update(haoDatabase.chats);
            updateStatement.where((tbl) => tbl.id.equals(_chatId!));
            updateStatement.write(ChatsCompanion(system: drift.Value(_getSystemPrompt())));
          }
        }
      }
    }
  }
  
  String _getSystemPrompt() {
    String systemPrompt = ref.read(systemPromptProvider);
    if(systemPrompt.trim().isEmpty) {
      systemPrompt = S.of(context).defaultSystemPrompt;
    }
    return systemPrompt;
  }

  Map<Type, Action<Intent>> _getShortcutsActions() {
    if(Platform.isAndroid || Platform.isIOS) {
      return {};
    } else {
      return {
        SendIntent: SendAction(_request),
        NewLineIntent: NewLineAction(_promptTextController)
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: _drawerIsOpened ? {} : getShortcutsIntents(),
      child: Actions(
        dispatcher: LoggingActionDispatcher(),
        actions: _getShortcutsActions(),
        child: Scaffold(
          drawer: SafeArea(child: ChatTurboMenu(
            chatId: _chatId,
            onClickChat: (int? chatId) {
              context.pushReplacement('/${AppUri.chatTurbo}?id=$chatId');
            },
          )),
          onDrawerChanged: (isOpened) => _onDrawerChanged(false, isOpened),
          endDrawer: const SafeArea(child: ChatTurboSystem()),
          onEndDrawerChanged: (isOpened) => _onDrawerChanged(true, isOpened),
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
                      controller: _scrollController,
                      slivers: <Widget>[
                        _buildSliverAppBar(context),
                        _buildSystemPrompt(),
                        if(appManager.openaiApiKey != null) _buildSliverList(),
                        SliverToBoxAdapter(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: _buildUnderList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if(appManager.openaiApiKey == null) ...[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: NoKeyView(onFinished: () {
                        setState(() {});
                      },),
                    ),
                    const Expanded(child: SizedBox(),),
                  ] else _buildInputView(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: isDesktop(),
      snap: true,
      floating: true,
      title: Text(S.of(context).gpt35turbo),
      actions: [
        IconButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            context.push('/${AppUri.settingsGpt35Turbo}');
          },
          icon: const Icon(Icons.dashboard_customize),
        ),
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.edit_note),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ),
      ],
    );
  }

  SliverToBoxAdapter _buildSystemPrompt() {
    return SliverToBoxAdapter(
      child: Builder(builder: (context) => TextButton(
        onPressed: () => Scaffold.of(context).openEndDrawer(),
        child: RichText(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            style: Theme.of(context).textTheme.bodySmall,
            children: <TextSpan>[
              TextSpan(text: '${S.of(context).systemPrompt}: ', style: const TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ref.watch(systemPromptProvider).isNotEmpty ? ref.read(systemPromptProvider) : S.of(context).defaultSystemPrompt,),
            ],
          ),
        ),
      ),
      ),
    );
  }

  SliverList _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return ChatTurboContent(message: _messages[index]);
      },
        childCount: _messages.length,
      ),
    );
  }

  Widget _buildUnderList() {
    if(_isLoading) {
      return LoadingAnimationWidget.flickr(
        leftDotColor: const Color(0xFF2196F3),
        rightDotColor: const Color(0xFFF44336),
        size: 24,
      );
    } else {
      if(_errorEntity != null) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SelectableText(
                _errorEntity?.message ?? _errorEntity?.error ?? 'ERROR!',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
                selectionControls: Platform.isIOS ? myCupertinoTextSelectionControls : null,
              ),
            ),
            OutlinedButton(
              onPressed: () => _request(),
              child: Text(S.of(context).retry, style: const TextStyle(fontSize: 12),),
            ),
          ],
        );
      } else {
        if(_messages.isNotEmpty && _messages.last.finishReason == FinishReason.length) {
          return FilledButton.tonal(
            onPressed: () => _request(),
            child: Text(S.of(context).resume, style: const TextStyle(fontSize: 12),),
          );
        }
      }
    }
    return const SizedBox();
  }

  Widget _buildInputView(BuildContext context) {
    String? getSendButtonTooltip() {
      LogicalKeySet? keySet = appConfig.shortcutsSend;
      if(keySet == null) {
        return null;
      } else {
        for(String key in getShortcutsKeys().keys) {
          if(getShortcutsKeys()[key] == keySet) {
            return key;
          }
        }
        return null;
      }
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _promptTextController,
              maxLines: 5,
              minLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: S.of(context).prompt,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8,),
              ),
            ),
          ),
          IconButton(
            iconSize: 32,
            onPressed: _isLoading ? null : () => _request(),
            icon: Icon(Icons.send, color: _isLoading ? Colors.grey : Colors.blueAccent,),
            tooltip: getSendButtonTooltip(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _promptTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
