import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/generated/l10n.dart';
import '../../app_router.dart';

class ChatTurboDrawer extends StatefulWidget {
  const ChatTurboDrawer({Key? key}) : super(key: key);

  @override
  State<ChatTurboDrawer> createState() => _ChatTurboDrawerState();
}

class _ChatTurboDrawerState extends State<ChatTurboDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: Column(
          children: [
            Expanded(child: const Placeholder()),
            const Divider(height: 1,),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(S.of(context).home),
              onTap: () {
                context.pop();
                context.go(AppUri.root);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(S.of(context).settings),
              onTap: () {
                context.pop();
                context.push('/${AppUri.settings}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
