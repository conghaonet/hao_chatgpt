import 'dart:io';

import 'package:hao_chatgpt/src/app_manager.dart';
import 'package:hao_chatgpt/src/my_colors.dart';
import 'package:hao_chatgpt/src/page/settings_pagge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'l10n/generated/l10n.dart';
import 'src/page/chat_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
    ));
  }
  await appManager.init();
  runApp(const ProviderScope(child: MyApp()));
}

final StateProvider<ThemeMode> themeProvider = StateProvider((ref) => ThemeMode.system);
final StateProvider<Locale?> localeProvider = StateProvider((ref) => null);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      theme: ThemeData.light(
        useMaterial3: true,
      ).copyWith(extensions: <ThemeExtension<dynamic>>[MyColors.light]),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(extensions: <ThemeExtension<dynamic>>[MyColors.dark]),
      home: const ChatPage(),
    );
  }
}
