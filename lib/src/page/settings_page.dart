import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hao_chatgpt/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hao_chatgpt/main.dart';
import 'package:hao_chatgpt/src/extensions.dart';
import 'package:hao_chatgpt/src/preferences_manager.dart';

class  SettingsPage extends ConsumerStatefulWidget {
  const  SettingsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildThemeSetting(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeSetting(BuildContext context) {
    String themeName = S.of(context).systemDefault;
    if(ref.watch(themeProvider) == ThemeMode.dark) {
      themeName = S.of(context).dark;
    } else if(ref.watch(themeProvider) == ThemeMode.light) {
      themeName = S.of(context).light;
    }

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.brightness_4),
            title: Text(S.of(context).theme),
            subtitle: Text(themeName),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return AlertDialog(
                    title: Text(S.of(ctx).chooseTheme),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RadioListTile(
                          title: Text(S.of(ctx).light),
                          value: ThemeMode.light,
                          groupValue: appPref.themeMode,
                          onChanged: (value) {
                            appPref.setThemeMode(ThemeMode.light);
                            ref.read(themeProvider.notifier).state = ThemeMode.light;
                            setSystemNavigationBarColor(ThemeMode.light);
                            ctx.pop();
                          },
                        ),
                        RadioListTile(
                          title: Text(S.of(ctx).dark),
                          value: ThemeMode.dark,
                          groupValue: appPref.themeMode,
                          onChanged: (value) {
                            appPref.setThemeMode(ThemeMode.dark);
                            ref.read(themeProvider.notifier).state = ThemeMode.dark;
                            setSystemNavigationBarColor(ThemeMode.dark);
                            ctx.pop();
                          },
                        ),
                        RadioListTile(
                          title: Text(S.of(ctx).systemDefault),
                          value: ThemeMode.system,
                          groupValue: appPref.themeMode,
                          onChanged: (value) {
                            appPref.setThemeMode(ThemeMode.system);
                            ref.read(themeProvider.notifier).state = ThemeMode.system;
                            setSystemNavigationBarColor(ThemeMode.system);
                            ctx.pop();
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => ctx.pop(),
                        child: Text(S.of(context).cancel),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
