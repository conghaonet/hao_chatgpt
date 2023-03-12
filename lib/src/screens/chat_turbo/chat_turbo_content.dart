import 'dart:io';

import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../db/hao_database.dart';
import '../../extensions.dart';

class ChatTurboContent extends StatelessWidget {
  const ChatTurboContent({required this.message, Key? key}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    switch(message.role) {
      case ChatRole.user:
        return _buildUserContent();
      case ChatRole.assistant:
        return _buildAssistantContent();
      default:
        return const SizedBox();
    }
  }

  Widget _buildUserContent() {
    return Card(
      child: Column(
        children: [
          Container(
            decoration: _getHeaderDecoration(),
            child: Row(
              children: [
                const Icon(Icons.account_circle),
                const Expanded(child: SizedBox()),
                Text(formatDateTime(message.msgDateTime)),
                const SizedBox(width: 4,),
                const Icon(Icons.copy),
              ],
            ),
          ),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildAssistantContent() {
    String tokens = message.completionTokens?.toString() ?? '';
    if(message.totalTokens != null) {
      tokens += '/${message.totalTokens}';
    }
    return Card(
      child: Column(
        children: [
          Container(
            decoration: _getHeaderDecoration(),
            child: Row(
              children: [
                const ImageIcon(AssetImage('assets/images/openai.png'),),
                const SizedBox(width: 4,),
                Text(tokens.isNotEmpty ? 'Tokens: $tokens' : ''),
                const Expanded(child: SizedBox()),
                Text(formatDateTime(message.msgDateTime)),
                const SizedBox(width: 4,),
                const Icon(Icons.copy),
              ],
            ),
          ),
          _buildContent(),
        ],
      ),
    );
  }

  BoxDecoration _getHeaderDecoration() {
    return BoxDecoration(
      color: Colors.grey.withOpacity(0.3),
      border: Border.all(color: Colors.transparent),
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8),),
    );
  }
  Widget _buildContent() {
    return SelectableText(
      message.content,
      selectionControls: Platform.isIOS ? myCupertinoTextSelectionControls : null,
    );
  }

}
