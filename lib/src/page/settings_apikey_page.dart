import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../l10n/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class SettingsApikeyPage extends StatefulWidget {
  const SettingsApikeyPage({Key? key}) : super(key: key);

  @override
  State<SettingsApikeyPage> createState() => _SettingsApikeyPageState();
}

class _SettingsApikeyPageState extends State<SettingsApikeyPage> {
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API keys'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return AlertDialog(
                    title: const Text('API key'),
                    content: TextField(
                      controller: _controller,
                      autofocus: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {

                        },
                        child: Text(S.of(context).confirm),
                      ),
                      TextButton(
                        onPressed: () => ctx.pop(),
                        child: Text(S.of(context).cancel),
                      ),
                    ],
                  );
                },

              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(

          ),
        ],
      ),
    );
  }
}
