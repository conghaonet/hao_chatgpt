import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hao_chatgpt/src/screens/chat.dart';
import 'package:hao_chatgpt/src/screens/chat_turbo.dart';
import 'package:hao_chatgpt/src/screens/settings/settings_apikey.dart';
import 'package:hao_chatgpt/src/screens/settings/settings_gpt3.dart';
import 'package:hao_chatgpt/src/screens/home.dart';
import 'package:hao_chatgpt/src/screens/settings.dart';

import 'screens/settings/settings_gpt35turbo.dart';
import 'screens/webview.dart';

class AppUri {
  static const root = '/';
  static const chat = 'chat';
  static const chatTurbo = 'chat-turbo';
  static const settings = 'settings';
  static const settingsGpt3 = 'settings/gpt3';
  static const settingsGpt35Turbo = 'settings/gpt35turbo';
  static const settingsApikey = 'settings/apikey';
  static const webview = 'webview';
}

class AppRouter {
  AppRouter._internal();
  static final AppRouter _appRouter = AppRouter._internal();
  factory AppRouter() => _appRouter;

  /// The route configuration.
  final GoRouter _goRouter = GoRouter(
    restorationScopeId: 'go_router',
    initialLocation: AppUri.root,
    routes: <RouteBase>[
      GoRoute(
        path: AppUri.root,
        builder: (BuildContext context, GoRouterState state) =>
            const HomePage(),
        routes: <RouteBase>[
          GoRoute(
            path: AppUri.settings,
            builder: (BuildContext context, GoRouterState state) =>
                const SettingsPage(),
            routes: <RouteBase>[
              GoRoute(
                path: AppUri.settingsGpt3.replaceFirst('${AppUri.settings}/', ''),
                builder: (BuildContext context, GoRouterState state) =>
                const CustomizeGpt3Page(),
              ),
              GoRoute(
                path: AppUri.settingsGpt35Turbo.replaceFirst('${AppUri.settings}/', ''),
                builder: (BuildContext context, GoRouterState state) =>
                const SettingsGpt35Turbo(),
              ),
              GoRoute(
                path: AppUri.settingsApikey.replaceFirst('${AppUri.settings}/', ''),
                builder: (BuildContext context, GoRouterState state) =>
                    const SettingsApikeyPage(),
              ),
            ],
          ),
          GoRoute(
            path: AppUri.chat,
            builder: (BuildContext context, GoRouterState state) =>
                ChatPage(chatId: int.tryParse(state.queryParams['id'] ?? ''),),
          ),
          GoRoute(
            path: AppUri.chatTurbo,
            builder: (BuildContext context, GoRouterState state) =>
                ChatTurbo(chatId: int.tryParse(state.queryParams['id'] ?? ''),),
          ),
          GoRoute(
            path: AppUri.webview,
            builder: (BuildContext context, GoRouterState state) => WebviewPage(
              url: state.queryParams['url'],
              title: state.queryParams['title'],
            ),
          ),
        ],
      ),
    ],
  );

  GoRouter get goRouter => _goRouter;
}
