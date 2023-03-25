import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hao_chatgpt/src/extensions.dart';

import '../../../l10n/generated/l10n.dart';
import '../../constants.dart';
import '../../network/entity/openai/completions_query_entity.dart';
import '../../app_config.dart';
import '../../screens/settings/settings_gpt35turbo.dart';

/// see [SettingsGpt35Turbo]
@Deprecated('Use SettingsGpt35Turbo instead')
class CustomizeGpt3Page extends StatefulWidget {
  const CustomizeGpt3Page({Key? key}) : super(key: key);

  @override
  State<CustomizeGpt3Page> createState() => _CustomizeGpt3PageState();
}

class _CustomizeGpt3PageState extends State<CustomizeGpt3Page> {
  late CompletionsQueryEntity _queryEntity;
  late String _selectedModel;
  final _maxLengthFocus = FocusNode();
  final _maxLengthController = TextEditingController();
  final _temperatureFocus = FocusNode();
  final _temperatureController = TextEditingController();
  final _topPFocus = FocusNode();
  final _topPController = TextEditingController();
  final _frequencyFocus = FocusNode();
  final _frequencyController = TextEditingController();
  final _presenceFocus = FocusNode();
  final _presenceController = TextEditingController();
  final _confirmButtonFocusNode = FocusNode();
  static const List<double> rangeZeroToOne = [0.0, 1.0];
  static const List<int> maxLengthRange = [1, 4096];
  static const List<double> rangeZeroToTwo = [0.0, 2.0];

  @override
  void initState() {
    super.initState();
    _queryEntity =
        appConfig.gpt3GenerationSettings ?? CompletionsQueryEntity.generation();
    _initValues();
    _initListener(
      controller: _maxLengthController,
      focusNode: _maxLengthFocus,
      defaultValue: _queryEntity.maxTokens,
      range: maxLengthRange,
    );
    _initListener(
      controller: _temperatureController,
      focusNode: _temperatureFocus,
      defaultValue: _queryEntity.temperature,
      range: rangeZeroToOne,
    );
    _initListener(
      controller: _topPController,
      focusNode: _topPFocus,
      defaultValue: _queryEntity.topP,
      range: rangeZeroToOne,
    );
    _initListener(
      controller: _frequencyController,
      focusNode: _frequencyFocus,
      defaultValue: _queryEntity.frequencyPenalty,
      range: rangeZeroToTwo,
    );
    _initListener(
      controller: _presenceController,
      focusNode: _presenceFocus,
      defaultValue: _queryEntity.presencePenalty,
      range: rangeZeroToTwo,
    );
  }

  void _initValues() {
    _selectedModel = _queryEntity.model;
    _maxLengthController.text = _queryEntity.maxTokens.toString();
    _temperatureController.text = _queryEntity.temperature.toString();
    _topPController.text = _queryEntity.topP.toString();
    _frequencyController.text = _queryEntity.frequencyPenalty.toString();
    _presenceController.text = _queryEntity.presencePenalty.toString();
  }

  void _initListener({
    required TextEditingController controller,
    required FocusNode focusNode,
    required num defaultValue,
    required List<num> range,
  }) {
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() {
          var value = double.tryParse(controller.text);
          if (value == null || value < range[0] || value > range[1]) {
            controller.text = defaultValue.toString();
          }
          if (defaultValue is double) {
            controller.text = double.parse(controller.text)
                .toStringAsFixedNoRound(2, isTight: true);
          } else {
            controller.text = int.parse(controller.text).toString();
          }
        });
      }
    });
  }

  Future<void> _save() async {
    await Future(() async {
      _queryEntity.model = _selectedModel;
      _queryEntity.maxTokens = int.parse(_maxLengthController.text);
      _queryEntity.temperature = double.parse(_temperatureController.text);
      _queryEntity.topP = double.parse(_topPController.text);
      _queryEntity.frequencyPenalty = double.parse(_frequencyController.text);
      _queryEntity.presencePenalty = double.parse(_presenceController.text);
      await appConfig.setGpt3GenerationSettings(_queryEntity);
    }).then((value) {
      context.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).gpt3),
        actions: [
          IconButton(
            onPressed: () async {
              await openWebView(
                  context: context,
                  url: Constants.apiCompletionsUrl,
                  title: 'Request body');
            },
            icon: const Icon(Icons.help),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _queryEntity = CompletionsQueryEntity.generation();
                _initValues();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(S.of(context).resetToDefault),
                  duration: const Duration(milliseconds: 1000),
                  action: SnackBarAction(
                    label: 'ok',
                    onPressed: () {},
                  ),
                ));
              });
            },
            icon: const Icon(Icons.settings_backup_restore),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildModel(),
                    const Divider(
                      height: 4,
                      thickness: 4,
                    ),
                    _buildNumberSetting(
                      label: S.of(context).maximumLength,
                      controller: _maxLengthController,
                      focusNode: _maxLengthFocus,
                      defaultValue: _queryEntity.maxTokens,
                      valueRange: maxLengthRange,
                    ),
                    const Divider(
                      height: 2,
                      thickness: 2,
                    ),
                    _buildNumberSetting(
                      label: S.of(context).temperature,
                      controller: _temperatureController,
                      focusNode: _temperatureFocus,
                      defaultValue: _queryEntity.temperature,
                      valueRange: rangeZeroToOne,
                    ),
                    const Divider(
                      height: 2,
                      thickness: 2,
                    ),
                    _buildNumberSetting(
                      label: S.of(context).topP,
                      controller: _topPController,
                      focusNode: _topPFocus,
                      defaultValue: _queryEntity.topP,
                      valueRange: rangeZeroToOne,
                    ),
                    const Divider(
                      height: 2,
                      thickness: 2,
                    ),
                    _buildNumberSetting(
                      label: S.of(context).frequencyPenalty,
                      controller: _frequencyController,
                      focusNode: _frequencyFocus,
                      defaultValue: _queryEntity.frequencyPenalty,
                      valueRange: rangeZeroToTwo,
                    ),
                    const Divider(
                      height: 2,
                      thickness: 2,
                    ),
                    _buildNumberSetting(
                      label: S.of(context).presencePenalty,
                      controller: _presenceController,
                      focusNode: _presenceFocus,
                      defaultValue: _queryEntity.presencePenalty,
                      valueRange: rangeZeroToTwo,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 4,
              thickness: 4,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    focusNode: _confirmButtonFocusNode,
                    onPressed: () async {
                      FocusScope.of(context)
                          .requestFocus(_confirmButtonFocusNode);
                      await _save();
                    },
                    child: Text(S.of(context).confirm),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () => context.pop(),
                    child: Text(S.of(context).cancel),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModel() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text('${S.of(context).model}:  '),
          DropdownButton(
            value: _selectedModel,
            items: Constants.gpt3Models.map((e) {
              return DropdownMenuItem<String>(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedModel = value!;
              });
              debugPrint(value);
            },
          ),
          IconButton(
            color: Colors.blue,
            onPressed: () async {
              await openWebView(
                  context: context,
                  url: Constants.aboutGPT3ModelsUrl,
                  title: 'GPT-3 models');
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberSetting({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required num defaultValue,
    required List<num> valueRange,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                width: defaultValue is double ? 60 : 80,
                height: 40,
                child: TextField(
                  textAlign: TextAlign.end,
                  focusNode: focusNode,
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter(
                      RegExp(defaultValue is double ? "[0-9.]" : "[0-9]"),
                      allow: true,
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          Slider(
            value: double.tryParse(controller.text) ?? defaultValue.toDouble(),
            min: valueRange[0].toDouble(),
            max: valueRange[1].toDouble(),
            divisions: defaultValue is double
                ? valueRange[1] ~/ 0.01
                : valueRange[1].toInt(),
            onChanged: (double value) {
              setState(() {
                controller.text = defaultValue is double
                    ? value.toString()
                    : value.toInt().toString();
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _temperatureFocus.dispose();
    _temperatureController.dispose();
    _maxLengthFocus.dispose();
    _maxLengthController.dispose();
    _topPFocus.dispose();
    _topPController.dispose();
    _frequencyFocus.dispose();
    _frequencyController.dispose();
    _presenceFocus.dispose();
    _presenceController.dispose();
    _confirmButtonFocusNode.dispose();
    super.dispose();
  }
}
