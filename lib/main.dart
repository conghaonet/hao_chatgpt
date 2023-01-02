import 'dart:io';
import 'dart:ui';

import 'package:hao_chatgpt/src/app_manager.dart';
import 'package:hao_chatgpt/src/my_colors.dart';
import 'package:hao_chatgpt/src/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hao_chatgpt/src/preferences_manager.dart';

import 'l10n/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appManager.init();
  runApp(const ProviderScope(child: MyApp()));

  // This callback is called every time the system brightness changes.
  // SingletonFlutterWindow window = WidgetsBinding.instance.window;
  // window.onPlatformBrightnessChanged = () {
  //   print('BrightnessChanged = '+window.platformBrightness.toString());
  // };
}

final StateProvider<ThemeMode> themeProvider = StateProvider((ref) => appPref.themeMode);
final StateProvider<Locale?> localeProvider = StateProvider((ref) => appPref.locale);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (Platform.isAndroid) {
      Brightness brightness = WidgetsBinding.instance.window.platformBrightness;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: brightness == Brightness.dark ? Colors.black : Colors.white,
      ));
    }
    return MaterialApp(
      title: 'HaoChatGPT',
      locale: ref.watch(localeProvider),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('zh', ''),
      ],
      themeMode: ref.watch(themeProvider),
      theme: ThemeData.light(useMaterial3: true,).copyWith(
        extensions: <ThemeExtension<dynamic>>[MyColors.light],
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        extensions: <ThemeExtension<dynamic>>[MyColors.dark],
      ),
      home: const HomePage(),
    );
  }
}
