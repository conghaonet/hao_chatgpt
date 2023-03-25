import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hao_chatgpt/main.dart';
import 'package:hao_chatgpt/src/extensions.dart';
import 'package:drift/drift.dart' as drift;
import 'package:hao_chatgpt/src/app_config.dart';

import '../../../l10n/generated/l10n.dart';
import '../../db/hao_database.dart';

class ChatTurboSystem extends ConsumerStatefulWidget {
  const ChatTurboSystem({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatTurboSystem> createState() => _ChatTurboSystemState();
}

class _ChatTurboSystemState extends ConsumerState<ChatTurboSystem> {
  final TextEditingController _systemTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<SystemPrompt> _systemPrompts = [];
  int _selectedPromptId = -1;

  @override
  void initState() {
    super.initState();
    _setPromptText(ref.read(systemPromptProvider));
    Future(() async {
      var statement = haoDatabase.select(haoDatabase.systemPrompts);
      statement.orderBy([(t) => drift.OrderingTerm(expression: t.id, mode: drift.OrderingMode.desc)]);
      statement.limit(appConfig.systemPromptLimit);
      var results = await statement.get();
      _systemPrompts.addAll(results);
      if(mounted) {
        if(S.of(context).defaultSystemPrompt == ref.read(systemPromptProvider)) {
          _systemTextController.text = '';
        }
        _checkSelectedPrompt();
        setState(() {
        });
      }
    });
  }

  void _setPromptText(String value) {
    _systemTextController.value = TextEditingValue(
      text: value,
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: value.length,
      )),
    );
  }

  void _checkSelectedPrompt() {
    _selectedPromptId = -1;
    final trimmedValue = _systemTextController.text.trim();
    if(trimmedValue.isNotEmpty) {
      for(SystemPrompt systemPrompt in _systemPrompts) {
        if(systemPrompt.prompt == trimmedValue) {
          _selectedPromptId = systemPrompt.id;
          break;
        }
      }
    }
  }

  Future _saveSystemPrompt() async {
    _scrollController.animateTo(0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceInOut,
    );
    _selectedPromptId = await haoDatabase.into(haoDatabase.systemPrompts).insert(SystemPromptsCompanion.insert(
      prompt: _systemTextController.text.trim(),
      createDateTime: DateTime.now(),
    ));
    final statement = haoDatabase.select(haoDatabase.systemPrompts);
    statement.where((tbl) => tbl.id.equals(_selectedPromptId));
    SystemPrompt newSystemPrompt = await statement.getSingle();
    _systemPrompts.insert(0, newSystemPrompt);
    if(_systemPrompts.length > appConfig.systemPromptLimit) {
      final lastPrompt = _systemPrompts.removeLast();
      (haoDatabase.delete(haoDatabase.systemPrompts)..where((tbl) => tbl.id.equals(lastPrompt.id))).go();
    }
    if(mounted) {
      setState(() {
      });
    }
  }
  Future _delSystemPrompt() async {
    _systemPrompts.removeWhere((element) => element.id == _selectedPromptId);
    (haoDatabase.delete(haoDatabase.systemPrompts)..where((tbl) => tbl.id.equals(_selectedPromptId))).go();
    _selectedPromptId = -1;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: FractionallySizedBox(
        widthFactor: isDesktop() ? 0.4 : 0.7,
        child: Listener(
          onPointerMove: (PointerMoveEvent event) {
            if(MediaQuery.of(context).viewInsets.bottom > 0) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputHeader(context),
                      Expanded(child: _buildInput(context)),
                    ],
                  ),
                ),
              ),
              Expanded(child: _buildListView(),),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Row(
              children: [
                Text(S.of(context).systemPrompt, style: const TextStyle(fontWeight: FontWeight.bold,),),
                Visibility(
                  visible: _systemTextController.text.isNotEmpty,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          _selectedPromptId = -1;
                          _systemTextController.clear();
                          ref.read(systemPromptProvider.notifier).state = '';
                        });
                      },
                      icon: const Icon(Icons.clear_all,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: _systemTextController.text.isNotEmpty,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: SizedBox(
            width: 36,
            height: 36,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: _selectedPromptId > 0 ? _delSystemPrompt : _saveSystemPrompt,
              isSelected: _selectedPromptId > 0,
              selectedIcon: const Icon(Icons.star, ),
              icon: const Icon(Icons.star_border,),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInput(BuildContext context) {
    return TextField(
      autofocus: true,
      maxLines: null,
      minLines: null,
      expands: true,
      controller: _systemTextController,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: S.of(context).defaultSystemPrompt,
        contentPadding: const EdgeInsets.all(4),
      ),
      onChanged: (value) {
        _checkSelectedPrompt();
        ref.read(systemPromptProvider.notifier).state = value.trim();
        setState(() {
        });
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _systemPrompts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _setPromptText(_systemPrompts[index].prompt);
            setState(() {
              _selectedPromptId = _systemPrompts[index].id;
              ref.read(systemPromptProvider.notifier).state = _systemPrompts[index].prompt;
            });
          },
          child: Card(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                _systemPrompts[index].prompt,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _systemTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
