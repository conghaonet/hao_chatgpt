import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hao_chatgpt/main.dart';
import 'package:hao_chatgpt/src/extensions.dart';

import '../../../l10n/generated/l10n.dart';
import '../../db/hao_database.dart';

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
    Future(() {
      if(S.of(context).defaultSystemPrompt == ref.read(systemPromptProvider)) {
        _systemTextController.text = '';
        if(mounted) {
          setState(() {

          });
        }
      }
    });
  }

  Future<int> _saveSystemPrompt() async {
    int id = await haoDatabase.into(haoDatabase.systemPrompts).insert(SystemPromptsCompanion.insert(
      prompt: _systemTextController.text.trim(),
      createDateTime: DateTime.now(),
    ));
    return id;
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(S.of(context).systemPrompt, style: const TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        IconButton(
                          onPressed: _saveSystemPrompt,
                          isSelected: true,
                          selectedIcon: const Icon(Icons.star, color: Colors.yellow,),
                          icon: const Icon(Icons.star_border),
                        ),
                      ],
                    ),
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
                          ref.read(systemPromptProvider.notifier).state = value.trim();
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
