import 'dart:io';
import 'package:drift/drift.dart' as drift;
import 'package:hao_chatgpt/src/app_manager.dart';
import 'package:hao_chatgpt/src/db/hao_database.dart';
import 'package:hao_chatgpt/src/extensions.dart';
import 'package:hao_chatgpt/src/my_colors.dart';
import 'package:hao_chatgpt/src/network/entity/dio_error_entity.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:hao_chatgpt/src/page/chat/chat_drawer.dart';
import 'package:hao_chatgpt/src/page/chat/no_key_view.dart';
import 'package:hao_chatgpt/src/preferences_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../l10n/generated/l10n.dart';
import '../network/entity/openai/completions_entity.dart';
import '../network/entity/openai/completions_query_entity.dart';
import '../network/openai_service.dart';

import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Logger logger = Logger();
  final ScrollController _listController = ScrollController();
  final TextEditingController _msgController = TextEditingController();
  bool _isRequesting = false;
  final List<ListItem> _data = [];
  String _inputMessage = '';
  
  /// id of [ChatTitles]
  int? _dbTitleId;

  Future<void> _sendPrompt(PromptItem promptItem) async {
    CompletionItem? completionItem;
    ErrorItem? errorItem;
    final chatDate = DateTime.now();
    _dbTitleId ??= await haoDatabase.into(haoDatabase.chatTitles).insert(ChatTitlesCompanion.insert(
        title: promptItem.inputMessage,
        chatDate: chatDate,
        isFavorite: const drift.Value(false)
    ));
    CompletionsQueryEntity queryEntity =
        appPref.gpt3GenerationSettings ?? CompletionsQueryEntity.generation();
    queryEntity.prompt = promptItem.appendedPrompt;
    try {
      CompletionsEntity entity =
          await openaiService.getCompletions(queryEntity);
      if (entity.choices != null && entity.choices!.isNotEmpty) {
        completionItem = CompletionItem(
          promptItem: promptItem,
          text: entity.choices!.first.text!,
        );

      }
    } on DioError catch (e) {
      errorItem = ErrorItem(e.toDioErrorEntity);
    } on Exception catch (e) {
      errorItem = ErrorItem(e.toDioErrorEntity);
    } finally {
      _data.add(completionItem ?? errorItem!);
      if(_dbTitleId != null) {
        String? text = completionItem?.text;
        if(errorItem != null) {
          text = _getErrorItemMessage(errorItem);
        }
        await haoDatabase.into(haoDatabase.conversations).insert(ConversationsCompanion.insert(
          titleId: _dbTitleId!,
          inputMessage: promptItem.inputMessage,
          prompt: promptItem.appendedPrompt,
          completion: drift.Value(text),
          isError: drift.Value(errorItem != null),
          promptDate: chatDate,
        ));
      }
      if (mounted) {
        setState(() {
          _inputMessage = _msgController.text;
          _isRequesting = false;
        });
        _scrollToEnd();
      }
    }
  }

  String _appendPrompt() {
    var item = _data.lastWhere(
      (element) => element is CompletionItem || element is PromptItem,
      orElse: () => ErrorItem(DioErrorEntity()),
    );
    String newPrompt = '';
    if (item is CompletionItem) {
      if(item.text.startsWith('\n') || item.text.startsWith('\r\n')) {
        newPrompt = '${item.promptItem.appendedPrompt}${item.text}';
      } else if(item.text.isNotEmpty) {
        newPrompt = '${item.promptItem.appendedPrompt}\n${item.text}';
      } else {
        newPrompt = item.promptItem.appendedPrompt;
      }
    } else if (item is PromptItem) {
      newPrompt = item.appendedPrompt;
    }
    if(newPrompt.endsWith('\n')) {
      return '$newPrompt$_inputMessage';
    } else if(newPrompt.isNotEmpty) {
      return '$newPrompt\n$_inputMessage';
    } else {
      return _inputMessage;
    }
  }

  String _getErrorItemMessage(ErrorItem errorItem) => errorItem.error.message ?? errorItem.error.error ?? 'ERROR!';

  bool _isEnabledSendButton() {
    return appManager.openaiApiKey != null && _inputMessage.isNotBlank && !_isRequesting;
  }

  void _scrollToEnd() {
    Future.delayed(const Duration(milliseconds: 50), () {
      _listController.animateTo(
        _listController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>();
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).chatGPT),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              context.push('/settings/gpt3');
            },
            icon: const Icon(Icons.dashboard_customize),
          ),
        ],
      ),
      drawer: ChatDrawer(onClickChat: (int? titleId) {
        if(titleId == null) {
          context.pushReplacement('/chat_page');
        }
      },),
      onDrawerChanged: (bool isOpened) {
        if(isOpened) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 1,
              color: Theme.of(context).primaryColorLight,
            ),
            Expanded(
              child: IndexedStack(
                index: appManager.openaiApiKey == null ? 0 : 1,
                children: [
                  Container(
                    alignment: Alignment.center,
                    color: myColors?.completionBackgroundColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: NoKeyView(onFinished: () {
                      setState(() {
                      });
                    },),
                  ),
                  ListView.builder(
                    controller: _listController,
                    itemCount: (_data.isNotEmpty && _data.last is PromptItem)
                        ? _data.length + 1
                        : _data.length,
                    itemBuilder: (context, index) {
                      if (index >= _data.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: LoadingAnimationWidget.flickr(
                            leftDotColor: const Color(0xFF2196F3),
                            rightDotColor: const Color(0xFFF44336),
                            size: 24,
                          ),
                        );
                      } else {
                        if (_data[index] is PromptItem) {
                          return _buildPromptItem(index);
                        } else if (_data[index] is CompletionItem) {
                          return _buildCompletionItem(index);
                        } else {
                          return _buildErrorItem(index);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Theme.of(context).primaryColorLight,
            ),
            _buildPromptInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildPromptItem(int index) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.account_circle),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: SelectableText(
              (_data[index] as PromptItem).inputMessage,
              selectionControls:
                  Platform.isIOS ? myCupertinoTextSelectionControls : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionItem(int index) {
    var regExp = RegExp(r'^\n+');
    final myColors = Theme.of(context).extension<MyColors>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: myColors?.completionBackgroundColor,
      child: SelectableText((_data[index] as CompletionItem).text.replaceAll(regExp, '')),
    );
  }

  Widget _buildErrorItem(int index) {
    final myColors = Theme.of(context).extension<MyColors>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: myColors?.completionBackgroundColor,
      child: Column(
        children: [
          Text(
            'Error',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontWeight: FontWeight.bold,
            ),
          ),
          SelectableText(
            _getErrorItemMessage(_data[index] as ErrorItem),
            style: TextStyle(color: Theme.of(context).colorScheme.error),
            selectionControls:
                Platform.isIOS ? myCupertinoTextSelectionControls : null,
          ),
        ],
      ),
    );
  }

  Widget _buildPromptInput() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextField(
            enabled: appManager.openaiApiKey != null,
            maxLines: 6,
            minLines: 1,
            autofocus: appManager.openaiApiKey != null,
            decoration: InputDecoration(
              hintText: S.of(context).prompt,
              contentPadding: const EdgeInsets.only(left: 16.0),
            ),
            controller: _msgController,
            selectionControls:
                Platform.isIOS ? myCupertinoTextSelectionControls : null,
            onChanged: (value) {
              if (value.isNotBlank) {
                if (!_isRequesting) {
                  if (!_isEnabledSendButton()) {
                    setState(() {
                      _inputMessage = value;
                    });
                  }
                }
              } else {
                if (!_isRequesting) {
                  if (_isEnabledSendButton()) {
                    setState(() {
                      _inputMessage = value;
                    });
                  }
                }
              }
            },
          ),
        ),
        IconButton(
          onPressed: !_isEnabledSendButton()
              ? null
              : () {
                  setState(() {
                    _isRequesting = true;
                    _inputMessage = _msgController.text.trim();
                    var promptItem = PromptItem(
                        inputMessage: _inputMessage,
                        appendedPrompt: _appendPrompt());
                    _data.add(promptItem);
                    _sendPrompt(promptItem);
                    _msgController.clear();
                  });
                  _scrollToEnd();
                },
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _msgController.dispose();
    _listController.dispose();
    super.dispose();
  }
}

abstract class ListItem {}

class PromptItem extends ListItem {
  // final String model;
  final String inputMessage;
  final String appendedPrompt;
  // final DateTime dateTime;
  // final double temperature;
  // final int maxTokens;

  PromptItem({
    // required this.model,
    required this.inputMessage,
    required this.appendedPrompt,
    // required this.dateTime,
    // required this.temperature,
    // required this.maxTokens
  });
}

class CompletionItem extends ListItem {
  final PromptItem promptItem;

  // final String object;
  // final DateTime dateTime;
  final String text;

  // final String finishReason;

  CompletionItem({
    required this.promptItem,
    // required this.object,
    // required this.dateTime,
    required this.text,
    // required this.finishReason
  });
}

class ErrorItem extends ListItem {
  final DioErrorEntity error;

  ErrorItem(this.error);
}
