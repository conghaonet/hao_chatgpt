import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.chat),
                title: Text('${S.of(context).openAI} ${S.of(context).chatGPT}'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  context.go('/chat_page');
                },
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Theme.of(context).primaryColorLight,
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text(S.of(context).settings),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  context.go('/settings');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
