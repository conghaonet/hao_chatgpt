import 'package:flutter/material.dart';
import 'package:hao_chatgpt/src/extensions.dart';

import '../../../l10n/generated/l10n.dart';

class ChatTurboSystem extends StatefulWidget {
  const ChatTurboSystem({Key? key}) : super(key: key);

  @override
  State<ChatTurboSystem> createState() => _ChatTurboSystemState();
}

class _ChatTurboSystemState extends State<ChatTurboSystem> {
  final TextEditingController _systemTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: FractionallySizedBox(
        widthFactor: isDesktop() ? 0.4 : 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('SYSTEM'),
            TextField(
              maxLines: 12,
              minLines: 7,
              keyboardType: TextInputType.multiline,
              controller: _systemTextController,
              decoration: InputDecoration(
                hintText: S.of(context).chatTurboSystemHint,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
