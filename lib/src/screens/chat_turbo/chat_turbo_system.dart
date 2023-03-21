import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hao_chatgpt/main.dart';
import 'package:hao_chatgpt/src/extensions.dart';

import '../../../l10n/generated/l10n.dart';

class ChatTurboSystem extends ConsumerStatefulWidget {
  const ChatTurboSystem({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatTurboSystem> createState() => _ChatTurboSystemState();
}

class _ChatTurboSystemState extends ConsumerState<ChatTurboSystem> {
  final TextEditingController _systemTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _systemTextController.text = ref.read(systemPromptProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: FractionallySizedBox(
        widthFactor: isDesktop() ? 0.4 : 0.7,
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).systemPrompt, style: const TextStyle(fontWeight: FontWeight.bold),),
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        maxLines: null,
                        minLines: null,
                        expands: true,
                        controller: _systemTextController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: S.of(context).defaultSystemPrompt,
                          contentPadding: const EdgeInsets.all(4),
                        ),
                        onChanged: (value) {
                          ref.read(systemPromptProvider.notifier).state = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _systemTextController.dispose();
    super.dispose();
  }
}
