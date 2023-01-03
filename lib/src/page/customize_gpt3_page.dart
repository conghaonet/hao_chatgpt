import 'package:flutter/material.dart';

import '../../l10n/generated/l10n.dart';
import '../constants.dart';

class CustomizeGpt3Page extends StatefulWidget {
  const CustomizeGpt3Page({Key? key}) : super(key: key);

  @override
  State<CustomizeGpt3Page> createState() => _CustomizeGpt3PageState();
}

class _CustomizeGpt3PageState extends State<CustomizeGpt3Page> {
  String _selectedModel = Constants.gpt3Models.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).gpt3),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Text(S.of(context).model),
                DropdownButton(
                  value: _selectedModel,
                  items: Constants.gpt3Models.map((e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedModel = value!;
                    });
                    debugPrint(value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
