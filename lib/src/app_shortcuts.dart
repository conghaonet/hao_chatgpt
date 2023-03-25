import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_config.dart';

Map<String, LogicalKeySet> getShortcutsKeys() {
  Map<String, LogicalKeySet> keyMap = {'Enter': LogicalKeySet(LogicalKeyboardKey.enter)};
  if(Platform.isWindows || Platform.isLinux || Platform.isFuchsia) {
    keyMap['Ctrl + Enter'] = LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.enter);
  } else if(Platform.isMacOS) {
    // \u2318 + Enter
    // ⌘ + Enter
    keyMap['⌘ + Enter'] = LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.enter);
  }
  return keyMap;
}

Map<LogicalKeySet, Intent> getShortcutsIntents() {
  if(Platform.isAndroid || Platform.isIOS) {
    return {};
  } else {
    List<LogicalKeySet> keySets = getShortcutsKeys().values.toList();
    keySets.remove(appConfig.shortcutsSend);
    return {
      appConfig.shortcutsSend!: const SendIntent(),
      keySets.first: const NewLineIntent(),
    };
  }
}

/// An ActionDispatcher that logs all the actions that it invokes.
class LoggingActionDispatcher extends ActionDispatcher {
  @override
  Object? invokeAction(
      covariant Action<Intent> action,
      covariant Intent intent, [
        BuildContext? context,
      ]) {
    debugPrint('Action invoked: $action($intent) from $context');
    super.invokeAction(action, intent, context);
    return null;
  }
}

class SendIntent extends Intent {
  const SendIntent();
}

class SendAction extends Action<SendIntent> {
  SendAction(this.callback);

  final VoidCallback callback;

  @override
  Object? invoke(covariant SendIntent intent) {
    callback();
    return null;
  }
}


class NewLineIntent extends Intent {
  const NewLineIntent();
}

class NewLineAction extends Action<NewLineIntent> {
  NewLineAction(this.controller);
  final TextEditingController controller;

  @override
  Object? invoke(covariant NewLineIntent intent) {
    String value = controller.text;
    int start = controller.selection.start;
    String newValue = value.replaceRange(controller.selection.start, controller.selection.end, '\n');
    controller.text = newValue;
    controller.selection = TextSelection.fromPosition(TextPosition(offset: start+1),);
    return null;
  }
}