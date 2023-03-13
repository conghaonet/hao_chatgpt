import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/generated/l10n.dart';
import '../../app_router.dart';
import '../../extensions.dart';

class ChatTurboMenu extends StatefulWidget {
  const ChatTurboMenu({Key? key}) : super(key: key);

  @override
  State<ChatTurboMenu> createState() => _ChatTurboMenuState();
}

class _ChatTurboMenuState extends State<ChatTurboMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: FractionallySizedBox(
        widthFactor: isDesktop() ? 0.4 : 0.7,
        child: Column(
          children: [
            Expanded(child: Container()),
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
