import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hao_chatgpt/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hao_chatgpt/main.dart';
import 'package:hao_chatgpt/src/app_manager.dart';
import 'package:hao_chatgpt/src/app_router.dart';
import 'package:hao_chatgpt/src/extensions.dart';
import 'package:hao_chatgpt/src/preferences_manager.dart';

import '../constants.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

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
              ListTile(
                leading: const Icon(Icons.key),
                title: const Text('API keys'),
                subtitle: appManager.openaiApiKey.isNotBlank
                    ? Text(getMaskedApiKey(appManager.openaiApiKey!))
                    : null,
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () => context.go('/${AppUri.settingsApikey}'),
              ),
              ListTile(
                leading: const Icon(Icons.data_object),
                title: Text('${S.of(context).chatGPT} ${S.of(context).gpt3}'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () => context.go('/${AppUri.settingsGpt3}'),
              ),
              if(getShortcuts().length > 1) _buildShortcuts(),
              _buildLanguageSetting(context),
              _buildThemeSetting(context),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildShortcuts() {
    return ListTile(
      leading: const Icon(Icons.shortcut),
      title: Text(S.of(context).shortcuts),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...getShortcuts().entries.map((e) {
            return RadioListTile<LogicalKeySet>(
              title: Text(S.of(context).sendWith(e.key)),
              value: e.value,
              groupValue: appPref.shortcutsSend,
              onChanged: (value) async {
                await appPref.setShortcutsSend(value);
                setState(() {
                });
              },
            );
          }).toList(),
        ],
      ),
    );
  }
  Widget _buildThemeSetting(BuildContext context) {
    String themeName = S.of(context).systemDefault;
    if (ref.watch(themeProvider) == ThemeMode.dark) {
      themeName = S.of(context).dark;
    } else if (ref.watch(themeProvider) == ThemeMode.light) {
      themeName = S.of(context).light;
    }
    Map<ThemeMode, String> themeModeMap = {
      ThemeMode.system: S.of(context).systemDefault,
      ThemeMode.light: S.of(context).light,
      ThemeMode.dark: S.of(context).dark,
    };
    return ListTile(
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
                  ...themeModeMap.entries.map((e) {
                    return RadioListTile<ThemeMode>(
                      title: Text(e.value),
                      value: e.key,
                      groupValue: appPref.themeMode,
                      onChanged: (value) {
                        appPref.setThemeMode(value!);
                        ref.read(themeProvider.notifier).state = value;
                        setSystemNavigationBarColor(value);
                        ctx.pop();
                      },
                    );
                  }).toList(),
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
    );
  }

  Widget _buildLanguageSetting(BuildContext context) {
    String getLanguageName() {
      String languageName = S.of(context).systemDefault;
      if (ref.watch(localeProvider) == Constants.enLocale) {
        languageName = S.of(context).langEnglish;
      } else if (ref.watch(localeProvider) == Constants.zhLocale) {
        languageName = S.of(context).langChinese;
      }
      return languageName;
    }

    const Locale undefinedLocale = Locale('und');
    Map<Locale, String> langMap = {
      undefinedLocale: S.of(context).systemDefault,
      Constants.enLocale: S.of(context).langEnglish,
      Constants.zhLocale: S.of(context).langChinese,
    };
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(S.of(context).language),
      subtitle: Text(getLanguageName()),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text(S.of(ctx).chooseLanguage),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...langMap.entries.map((e) {
                    return RadioListTile<Locale>(
                      title: Text(e.value),
                      value: e.key,
                      groupValue: appPref.locale ?? undefinedLocale,
                      onChanged: (value) {
                        Locale? convertedLocale =
                            (value == undefinedLocale) ? null : value;
                        appPref.setLocale(convertedLocale);
                        ref.read(localeProvider.notifier).state =
                            convertedLocale;
                        ctx.pop();
                      },
                    );
                  }).toList(),
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
    );
  }
}
