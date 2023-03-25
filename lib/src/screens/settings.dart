import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hao_chatgpt/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hao_chatgpt/main.dart';
import 'package:hao_chatgpt/src/app_manager.dart';
import 'package:hao_chatgpt/src/app_router.dart';
import 'package:hao_chatgpt/src/extensions.dart';
import 'package:hao_chatgpt/src/app_config.dart';
import 'package:hao_chatgpt/src/screens/settings/settings_proxy.dart';
import 'package:yaml/yaml.dart';

import '../app_shortcuts.dart';
import '../constants.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  String _appVersion = '';
  @override
  void initState() {
    super.initState();
    Future(() async {
      String str = await rootBundle.loadString('pubspec.yaml');
      var doc = loadYaml(str);
      if(mounted) {
        setState(() {
          _appVersion = doc['version'];
          _appVersion = _appVersion.split('+')[0];
        });
      }
    });
  }
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
                leading: const Icon(Icons.dashboard_customize),
                title: Text(S.of(context).gpt35turbo),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () => context.go('/${AppUri.settingsGpt35Turbo}'),
              ),
              _buildSystemPrompt(),
              if(getShortcutsKeys().length > 1) _buildShortcuts(),
              _buildProxySetting(context),
              _buildLanguageSetting(context),
              _buildThemeSetting(context),
              if(_appVersion.isNotEmpty)
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Version'),
                  subtitle: Text(_appVersion),
                  onTap: null,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSystemPrompt() {
    List<int> maxRecords = [Constants.systemPromptLimit, Constants.systemPromptLimit+10, Constants.systemPromptLimit+20];
    return ListTile(
      leading: const Icon(Icons.table_rows),
      title: Text(S.of(context).systemPromptRecords),
      trailing: DropdownButton<int>(
        value: appConfig.systemPromptLimit,
        items: maxRecords.map((e) {
          return DropdownMenuItem<int>(
            value: e,
            child: Text('$e'),
          );
        }).toList(growable: false),
        onChanged: (value) {
          setState(() {
            appConfig.setSystemPromptLimit(value);
          });
        },
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
          ...getShortcutsKeys().entries.map((e) {
            return RadioListTile<LogicalKeySet>(
              title: Text(S.of(context).sendWith(e.key)),
              value: e.value,
              groupValue: appConfig.shortcutsSend,
              onChanged: (value) async {
                await appConfig.setShortcutsSend(value);
                setState(() {
                });
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildProxySetting(BuildContext context) {
    String? value = ref.watch(proxyProvider);
    String proxyValue = '';
    if(value.isNotBlank) {
      List<String> args = value!.split(Constants.splitTag);
      if(args.length == 3) {
        bool enableProxy = args[0] == true.toString();
        String hostname = args[1];
        String portNumber = args[2];
        if(enableProxy && hostname.isNotEmpty && portNumber.isNotEmpty) {
          proxyValue = '$hostname:$portNumber';
        }
      }
    }
    return ListTile(
      leading: const Icon(Icons.swap_vert),
      title: Text(S.of(context).httpProxy),
      subtitle: proxyValue.isNotEmpty ? Text(proxyValue) : null,
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return const SettingsProxy();
          },
        );
      },
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
                      groupValue: appConfig.themeMode,
                      onChanged: (value) {
                        appConfig.setThemeMode(value!);
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
                      groupValue: appConfig.locale ?? undefinedLocale,
                      onChanged: (value) {
                        Locale? convertedLocale =
                            (value == undefinedLocale) ? null : value;
                        appConfig.setLocale(convertedLocale);
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
