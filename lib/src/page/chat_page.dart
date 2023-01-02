import 'package:hao_chatgpt/src/extensions.dart';
import 'package:hao_chatgpt/src/my_colors.dart';
import 'package:hao_chatgpt/src/network/entity/dio_error_entity.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../network/entity/openai/completions_entity.dart';
import '../network/entity/openai/completions_query_entity.dart';
import '../network/openai_service.dart';

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

  @override
  void initState() {
    super.initState();
  }

  Future<void> _sendPrompt(PromptItem promptItem) async {
    var query = CompletionsQueryEntity.generation(
      prompt: promptItem.appendedPrompt,
      maxTokens: 1000,
    );
    try {
      CompletionsEntity entity = await openaiService.getCompletions(query);
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
    var item = _data.lastWhere((element) => element is CompletionItem || element is PromptItem,
      orElse: () => ErrorItem(DioErrorEntity()),
    );
    String newPrompt = '';
    if(item is CompletionItem) {
      newPrompt = '${item.promptItem.appendedPrompt}${item.text}\n\n';
    } else if(item is PromptItem) {
      newPrompt = item.appendedPrompt;
    }
    return '$newPrompt$_inputMessage\n\n';
  }

  bool _isEnabledSendButton() {
    return _inputMessage.isNotBlank && !_isRequesting;
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
        title: const Text('Hello'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _listController,
              itemCount: (_data.isNotEmpty && _data.last is PromptItem) ? _data.length + 1 : _data.length,
              itemBuilder: (context, index) {
                if(index >= _data.length) {
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
                    return Container(
                      color: myColors?.promptBackgroundColor,
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
                              )),
                        ],
                      ),
                    );
                  } else if (_data[index] is CompletionItem) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      color: myColors?.completionBackgroundColor,
                      child: SelectableText((_data[index] as CompletionItem).text),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      color: myColors?.completionBackgroundColor,
                      child: Column(
                        children: [
                          Text(
                            'Error',
                            style: TextStyle(color: Theme.of(context).colorScheme.error, fontWeight: FontWeight.bold),
                          ),
                          SelectableText(
                            (_data[index] as ErrorItem).error.message ?? 'ERROR!',
                            style: TextStyle(color: Theme.of(context).colorScheme.error),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
            ),
          ),
          _buildPromptInput(),
        ],
      ),
    );
  }

  Row _buildPromptInput() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextField(
            controller: _msgController,
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
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Message',
              contentPadding: EdgeInsets.only(left: 16.0),
            ),
          ),
        ),
        IconButton(
          onPressed: !_isEnabledSendButton()
              ? null
              : () {
                  setState(() {
                    _isRequesting = true;
                    _inputMessage = _msgController.text;
                    var promptItem = PromptItem(inputMessage: _inputMessage, appendedPrompt: _appendPrompt());
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
