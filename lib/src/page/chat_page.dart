import 'dart:io';
import 'package:hao_chatgpt/src/app_manager.dart';
import 'package:hao_chatgpt/src/extensions.dart';
import 'package:hao_chatgpt/src/my_colors.dart';
import 'package:hao_chatgpt/src/network/entity/dio_error_entity.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:hao_chatgpt/src/preferences_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../l10n/generated/l10n.dart';
import '../constants.dart';
import '../network/entity/api_key_entity.dart';
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
  final _gpt3FocusNode = FocusNode();
  final _inputPromptNode = FocusNode();
  bool _isRequesting = false;
  final List<ListItem> _data = [];
  String _inputMessage = '';
  String _apiKeyValue = '';

  Future<void> _sendPrompt(PromptItem promptItem) async {
    CompletionsQueryEntity queryEntity =
        appPref.gpt3GenerationSettings ?? CompletionsQueryEntity.generation();
    logger.i(queryEntity.toJson());
    queryEntity.prompt = promptItem.appendedPrompt;
    try {
      CompletionsEntity entity =
          await openaiService.getCompletions(queryEntity);
      logger.i(entity.toJson());
      if (entity.choices != null && entity.choices!.isNotEmpty) {
        _data.add(CompletionItem(
          promptItem: promptItem,
          text: entity.choices!.first.text!,
        ));
      }
    } on DioError catch (e) {
      _data.add(ErrorItem(e.toEioErrorEntity));
    } on Exception catch (e) {
      _data.add(ErrorItem(e.toEioErrorEntity));
    } finally {
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
      newPrompt = '${item.promptItem.appendedPrompt}${item.text}\n\n';
    } else if (item is PromptItem) {
      newPrompt = item.appendedPrompt;
    }
    return '$newPrompt$_inputMessage\n\n';
  }

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
              FocusScope.of(context).requestFocus(_gpt3FocusNode);
              context.push('/settings/gpt3');
            },
            icon: const Icon(Icons.dashboard_customize),
          ),
        ],
      ),
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
                    child: _buildNoKeyView(),
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

  Widget _buildNoKeyView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(S.of(context).haoChatIsPoweredByOpenAI, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        const SizedBox(height: 16,),
        Text(S.of(context).storeAPIkeyNotice, style: const TextStyle(fontSize: 12,),),
        const SizedBox(height: 16,),
        TextField(
          maxLines: 1,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: S.of(context).enterYourOpenAiApiKey,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          onChanged: (value) {
            if((value.isNotBlank && !_apiKeyValue.isNotBlank) || (!value.isNotBlank && _apiKeyValue.isNotBlank)) {
              setState(() {
                _apiKeyValue = value;
              });
            } else {
              _apiKeyValue = value;
            }
          },
        ),
        const SizedBox(height: 8,),
        Row(
          children: [
            Expanded(child: Container(),),
            Expanded(
              child: ElevatedButton(
                onPressed: _apiKeyValue.isNotBlank ? () async {
                  if(_apiKeyValue.isNotBlank) {
                    ApiKeyEntity entity =
                    ApiKeyEntity(_apiKeyValue.trim(), DateTime.now());
                    appPref.addApiKey(entity).then((_) {
                      setState(() {
                      });
                      Future.delayed(const Duration(milliseconds: 100), () {
                        FocusScope.of(context).requestFocus(_inputPromptNode);
                      });
                    });
                  }
                } : null,
                child: Text(S.of(context).done),
              ),
            ),
            Expanded(child: Container(),),
          ],
        ),
        Row(
          children: [
            Text('1. ${S.of(context).navigateTo}', style: const TextStyle(fontSize: 12,),),
            TextButton(
              onPressed: () {
                openWebView(context: context, url: Constants.openAiApiKeysUrl, isExternal: true,);
              },
              child: const Text('OpenAI API Key', style: TextStyle(fontSize: 12,),),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('2. ${S.of(context).logInAndClick}', style: const TextStyle(fontSize: 12,),),
        ),
      ],
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
    final myColors = Theme.of(context).extension<MyColors>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: myColors?.completionBackgroundColor,
      child: SelectableText((_data[index] as CompletionItem).text),
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
            (_data[index] as ErrorItem).error.message ??
                (_data[index] as ErrorItem).error.error ??
                'ERROR!',
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
            focusNode: _inputPromptNode,
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
    _gpt3FocusNode.dispose();
    _inputPromptNode.dispose();
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
