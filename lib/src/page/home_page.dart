import 'package:flutter/material.dart';

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
              onPressed: () {

              },
              child: Text('${S.of(context).openAI} ${S.of(context).chatGPT}'),
            ),
            OutlinedButton(
              onPressed: () {

              },
              child: Text(S.of(context).settings),
            ),
          ],
        ),
      ),
    );
  }
}
