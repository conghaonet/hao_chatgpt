import 'package:hao_chatgpt/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';

class  SettingsPage extends StatelessWidget {
  const  SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          ],
        ),
      ),
    );
  }
}
