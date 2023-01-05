import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hao_chatgpt/src/extensions.dart';

import '../../l10n/generated/l10n.dart';
import '../constants.dart';
import '../network/entity/openai/completions_query_entity.dart';
import '../preferences_manager.dart';

class CustomizeGpt3Page extends StatefulWidget {
  const CustomizeGpt3Page({Key? key}) : super(key: key);

  @override
  State<CustomizeGpt3Page> createState() => _CustomizeGpt3PageState();
}
/// https://beta.openai.com/docs/guides/completion/generation

class _CustomizeGpt3PageState extends State<CustomizeGpt3Page> {
  late CompletionsQueryEntity _queryEntity;
  late String _selectedModel;
  final _temperatureTextFocusNode = FocusNode();
  final _temperatureTextController = TextEditingController();
  final _maxLengthTextFocusNode = FocusNode();
  final _maxLengthTextController = TextEditingController();
  final _topPTextFocusNode = FocusNode();
  final _topPTextController = TextEditingController();
  final _frequencyTextFocusNode = FocusNode();
  final _frequencyTextController = TextEditingController();
  final _presenceTextFocusNode = FocusNode();
  final _presenceTextController = TextEditingController();
  final _confirmButtonFocusNode = FocusNode();
  static const List<double> temperatureRange = [0.0, 1.0];
  static const List<double> maxLengthRange = [1.0, 4000.0];
  static const List<double> topPRange = [0.0, 1.0];
  static const List<double> frequencyRange = [0.0, 2.0];
  static const List<double> presenceRange = [0.0, 2.0];

  @override
  void initState() {
    super.initState();
    _queryEntity = appPref.gpt3GenerationSettings ?? CompletionsQueryEntity.generation();
    _selectedModel = _queryEntity.model;
    _temperatureTextController.text = _queryEntity.temperature.toString();
    _temperatureTextFocusNode.addListener(() {
      if(!_temperatureTextFocusNode.hasFocus) {
        setState(() {
          var value = double.tryParse(_temperatureTextController.text);
          if(value == null || value < temperatureRange[0] || value > temperatureRange[1]) {
            _temperatureTextController.text = _queryEntity.temperature.toString();
          }
          _temperatureTextController.text = double.parse(_temperatureTextController.text).toStringAsFixedNoRound(2, isTight: true);
        });
      }
    });
    _maxLengthTextController.text = _queryEntity.maxTokens.toStringAsFixed(0);
    _maxLengthTextFocusNode.addListener(() {
      if(!_maxLengthTextFocusNode.hasFocus) {
        setState(() {
          var value = int.tryParse(_maxLengthTextController.text);
          if(value == null || value < maxLengthRange[0] || value > maxLengthRange[1]) {
            _maxLengthTextController.text = _queryEntity.maxTokens.toString();
          }
        });
      }
    });
    _topPTextController.text = _queryEntity.topP.toString();
    _topPTextFocusNode.addListener(() {
      if(!_topPTextFocusNode.hasFocus) {
        setState(() {
          var value = double.tryParse(_topPTextController.text);
          if(value == null || value < topPRange[0] || value > topPRange[1]) {
            _topPTextController.text = _queryEntity.topP.toString();
          }
          _topPTextController.text = double.parse(_topPTextController.text).toStringAsFixedNoRound(2, isTight: true);
        });
      }
    });
    _frequencyTextController.text = _queryEntity.frequencyPenalty.toString();
    _frequencyTextFocusNode.addListener(() {
      if(!_frequencyTextFocusNode.hasFocus) {
        setState(() {
          var value = double.tryParse(_frequencyTextController.text);
          if(value == null || value < frequencyRange[0] || value > frequencyRange[1]) {
            _frequencyTextController.text = _queryEntity.frequencyPenalty.toString();
          }
          _frequencyTextController.text = double.parse(_frequencyTextController.text).toStringAsFixedNoRound(2, isTight: true);
        });
      }
    });
    _presenceTextController.text = _queryEntity.presencePenalty.toString();
    _presenceTextFocusNode.addListener(() {
      if(!_presenceTextFocusNode.hasFocus) {
        setState(() {
          var value = double.tryParse(_presenceTextController.text);
          if(value == null || value < presenceRange[0] || value > presenceRange[1]) {
            _presenceTextController.text = _queryEntity.presencePenalty.toString();
          }
          _presenceTextController.text = double.parse(_presenceTextController.text).toStringAsFixedNoRound(2, isTight: true);
        });
      }
    });

  }

  void _initController({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String defaultValue,
    required List<num> range,

  }) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).gpt3),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildModel(),
              const Divider(height: 4, thickness: 4,),
              _buildTemperature(),
              const Divider(height: 1,),
              _buildMaximumLength(),
              const Divider(height: 1,),
              _buildTopP(),
              const Divider(height: 1,),
              _buildFrequency(),
              const Divider(height: 1,),
              _buildPresence(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 4, thickness: 4,),
          Row(
            children: [
              Expanded(child: TextButton(
                focusNode: _confirmButtonFocusNode,
                onPressed: () {
                  FocusScope.of(context).requestFocus(_confirmButtonFocusNode);
                  Future(() async {
                    _queryEntity.model = _selectedModel;
                    _queryEntity.temperature = double.parse(_temperatureTextController.text);
                    _queryEntity.maxTokens = int.parse(_maxLengthTextController.text);
                    _queryEntity.topP = double.parse(_topPTextController.text);
                    _queryEntity.frequencyPenalty = double.parse(_frequencyTextController.text);
                    _queryEntity.presencePenalty = double.parse(_presenceTextController.text);
                    await appPref.setGpt3GenerationSettings(_queryEntity);
                  }).then((value) {
                    context.pop();
                  });
                },
                child: Text(S.of(context).confirm),
              )),
              Expanded(child: TextButton(
                onPressed: () => context.pop(),
                child: Text(S.of(context).cancel),
              )),
            ],
          ),
        ],
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
        ],
      ),
    );
  }

  Widget _buildTemperature() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(S.of(context).temperature),
              const SizedBox(width: 8,),
              SizedBox(
                width: 60,
                height: 40,
                child: TextField(
                  textAlign: TextAlign.end,
                  focusNode: _temperatureTextFocusNode,
                  controller: _temperatureTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                  ],
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          Slider(
            value: double.tryParse(_temperatureTextController.text) ?? _queryEntity.temperature,
            min: temperatureRange[0],
            max: temperatureRange[1],
            divisions: temperatureRange[1] ~/ 0.01,
            onChanged: (double value) {
              setState(() {
                _temperatureTextController.text = value.toString();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMaximumLength() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(S.of(context).maximumLength),
              const SizedBox(width: 8,),
              SizedBox(
                width: 80,
                height: 40,
                child: TextField(
                  textAlign: TextAlign.end,
                  focusNode: _maxLengthTextFocusNode,
                  controller: _maxLengthTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp("[0-9]"), allow: true),
                  ],
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          Slider(
            value: double.tryParse(_maxLengthTextController.text) ?? _queryEntity.maxTokens.toDouble(),
            min: maxLengthRange[0],
            max: maxLengthRange[1],
            divisions: maxLengthRange[1].toInt(),
            onChanged: (double value) {
              setState(() {
                _maxLengthTextController.text = value.toStringAsFixed(0);
              });
            },
          ),

        ],
      ),
    );
  }

  Widget _buildTopP() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(S.of(context).topP),
              const SizedBox(width: 8,),
              SizedBox(
                width: 60,
                height: 40,
                child: TextField(
                  textAlign: TextAlign.end,
                  focusNode: _topPTextFocusNode,
                  controller: _topPTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                  ],
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          Slider(
            value: double.tryParse(_topPTextController.text) ?? _queryEntity.topP,
            min: topPRange[0],
            max: topPRange[1],
            divisions: topPRange[1] ~/ 0.01,
            onChanged: (double value) {
              setState(() {
                _topPTextController.text = value.toString();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFrequency() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(S.of(context).frequencyPenalty),
              const SizedBox(width: 8,),
              SizedBox(
                width: 60,
                height: 40,
                child: TextField(
                  textAlign: TextAlign.end,
                  focusNode: _frequencyTextFocusNode,
                  controller: _frequencyTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                  ],
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          Slider(
            value: double.tryParse(_frequencyTextController.text) ?? _queryEntity.frequencyPenalty,
            min: frequencyRange[0],
            max: frequencyRange[1],
            divisions: frequencyRange[1]~/0.01,
            onChanged: (double value) {
              setState(() {
                _frequencyTextController.text = value.toString();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPresence() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(S.of(context).presencePenalty),
              const SizedBox(width: 8,),
              SizedBox(
                width: 60,
                height: 40,
                child: TextField(
                  textAlign: TextAlign.end,
                  focusNode: _presenceTextFocusNode,
                  controller: _presenceTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                  ],
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          Slider(
            value: double.tryParse(_presenceTextController.text) ?? _queryEntity.presencePenalty,
            min: presenceRange[0],
            max: presenceRange[1],
            divisions: presenceRange[1]~/0.01,
            onChanged: (double value) {
              setState(() {
                _presenceTextController.text = value.toString();
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _temperatureTextFocusNode.dispose();
    _temperatureTextController.dispose();
    _maxLengthTextFocusNode.dispose();
    _maxLengthTextController.dispose();
    _topPTextFocusNode.dispose();
    _topPTextController.dispose();
    _frequencyTextFocusNode.dispose();
    _frequencyTextController.dispose();
    _presenceTextFocusNode.dispose();
    _presenceTextController.dispose();
    _confirmButtonFocusNode.dispose();
    super.dispose();
  }
}
