import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../l10n/generated/l10n.dart';
import '../../constants.dart';
import '../../db/hao_database.dart';
import '../../extensions.dart';

class ChatTurboContent extends StatelessWidget {
  const ChatTurboContent({required this.message, Key? key}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              border: Border.all(color: Colors.transparent),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8),),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: message.role == ChatRole.user ? _buildUserHeader(context) : _buildAssistantHeader(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SelectableText(
              message.content,
              selectionControls: Platform.isIOS ? myCupertinoTextSelectionControls : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserHeader(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.account_circle),
        const Expanded(child: SizedBox()),
        Text(formatDateTime(message.msgDateTime)),
        const SizedBox(width: 4,),
        _buildCopyButton(context),
      ],
    );
  }

  Widget _buildAssistantHeader(BuildContext context) {
    String tokens = message.completionTokens?.toString() ?? '';
    if(message.totalTokens != null) {
      tokens += '/${message.totalTokens}';
    }
    return Row(
      children: [
        const ImageIcon(AssetImage('assets/images/openai.png'),),
        const SizedBox(width: 4,),
        Text(tokens.isNotEmpty ? 'Tokens: $tokens' : ''),
        const Expanded(child: SizedBox()),
        Text(formatDateTime(message.msgDateTime)),
        const SizedBox(width: 4,),
        _buildCopyButton(context),
      ],
    );
  }


  Widget _buildCopyButton(BuildContext context) {
    return GestureDetector(
      child: const Icon(Icons.copy),
      onTap: () {
        Clipboard.setData(ClipboardData(text: message.content));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(S.of(context).copied),
          duration: const Duration(milliseconds: 1000),
          action: SnackBarAction(
            label: 'ok',
            onPressed: () {},
          ),
        ));
      },
    );
  }

}
