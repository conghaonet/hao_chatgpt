import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hao_chatgpt/main.dart';
import 'package:hao_chatgpt/src/network/entity/openai/chat_role.dart';
import 'package:hao_chatgpt/src/screens/chat_turbo/chat_turbo_menu.dart';

import '../../l10n/generated/l10n.dart';
import '../extensions.dart';
import '../network/entity/openai/chat_entity.dart';
import '../network/entity/openai/chat_message_entity.dart';
import '../network/entity/openai/chat_query_entity.dart';
import '../network/openai_service.dart';
import 'chat_turbo/chat_turbo_system.dart';

class ChatTurbo extends ConsumerStatefulWidget {
  const ChatTurbo({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatTurbo> createState() => _ChatTurboState();
}

class _ChatTurboState extends ConsumerState<ChatTurbo> {
  final TextEditingController _promptTextController = TextEditingController();
  final List<ChatMessageEntity> messages = [];
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _request() async {
    if(_promptTextController.text.isNotBlank) {
      var promptMsg = ChatMessageEntity(role: ChatRole.user.name, content: _promptTextController.text);
      messages.add(promptMsg);
    }
    String system = ref.read(chatTurboSystemProvider);
    if(system.trim().isEmpty) {
      system = S.of(context).chatTurboSystemHint;
    }

    List<ChatMessageEntity> queryMessages = [ChatMessageEntity(role: ChatRole.system.name, content: system), ...messages];

    ChatQueryEntity queryEntity = ChatQueryEntity(messages: queryMessages,);
    ChatEntity chatEntity = await openaiService.getGpt35Turbo(queryEntity);
    if(chatEntity.choices != null && chatEntity.choices!.isNotEmpty && chatEntity.choices!.first.message != null) {
      messages.add(chatEntity.choices!.first.message!);
      if(mounted) {
        setState(() {

        });
      }
    }
    print(chatEntity.toJson());

    return;
  }

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
      drawer: const SafeArea(child: ChatTurboMenu()),
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
                  slivers: <Widget>[
                    _buildSliverAppBar(context),
                    _buildSliverList(),
                  ],
                ),
              ),
              _buildInputView(context),
            ],
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
    );
  }

  SliverList _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Text(messages[index].toJson().toString(),),
        );
      },
        childCount: messages.length,
      ),
    );
  }

  Widget _buildInputView(BuildContext context) {
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16,),
              ),
            ),
          ),
          FilledButton(
            onPressed: _isLoading ? null : () async {
              await _request();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(S.of(context).submit),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _promptTextController.dispose();
    super.dispose();
  }
}
