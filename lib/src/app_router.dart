import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hao_chatgpt/src/page/chat_page.dart';
import 'package:hao_chatgpt/src/page/settings_apikey_page.dart';
import 'package:hao_chatgpt/src/page/settings_gpt3_page.dart';
import 'package:hao_chatgpt/src/page/home_page.dart';
import 'package:hao_chatgpt/src/page/settings_page.dart';

import 'page/webview_page.dart';

class AppRouter {
  AppRouter._internal();
  static final AppRouter _appRouter = AppRouter._internal();
  factory AppRouter() => _appRouter;

  /// The route configuration.
  final GoRouter _goRouter = GoRouter(
    restorationScopeId: 'go_router',
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const HomePage(),
        routes: <RouteBase>[
          GoRoute(
            path: 'settings',
            builder: (BuildContext context, GoRouterState state) =>
                const SettingsPage(),
            routes: <RouteBase>[
              GoRoute(
                path: 'gpt3',
                builder: (BuildContext context, GoRouterState state) =>
                    const CustomizeGpt3Page(),
              ),
              GoRoute(
                path: 'apikey',
                builder: (BuildContext context, GoRouterState state) =>
                    const SettingsApikeyPage(),
              ),
            ],
          ),
          GoRoute(
            path: 'chat_page',
            builder: (BuildContext context, GoRouterState state) =>
                ChatPage(chatTitleId: int.tryParse(state.queryParams['id'] ?? ''),),
          ),
          GoRoute(
            path: 'webview',
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
