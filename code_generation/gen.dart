// ignore_for_file: unused_element

import 'dart:io';

import 'package:cli_dialog/cli_dialog.dart';

String baseModulePath = 'lib/modules';
String projectName = 'flutter_challenge';

enum Task {
  module('1. New Module'),
  controller('2. Controller in an existing module'),
  model('3. Model in an existing module'),
  screen('4. Screen in an existing module');

  final String label;
  const Task(this.label);
}

void main(List<String> arguments) {
  bool onlyPortrait = true;
  bool onlyLandscape = false;

  var listQuestions = [
    [
      {
        'question': 'What do you want to generate?',
        'options': Task.values.map((e) => e.label).toList()
      },
      'task'
    ]
  ];

  final initialDialog = CLI_Dialog(listQuestions: listQuestions);
  final answer = initialDialog.ask();
  final task = answer['task'];
  Task task0 = Task.values.firstWhere((element) => element.label == task);

  switch (task0) {
    case Task.module:
      final moduleDialog = CLI_Dialog(questions: [
        ['Enter the new module name?', 'name']
      ]);
      _createModule(
        moduleDialog.ask()['name'],
        onlyPortrait: onlyPortrait,
        onlyLandscape: onlyLandscape,
      );
      break;

    case Task.controller:
      final controllerDialog = CLI_Dialog(questions: [
        ['Enter the controller name?', 'controllerName']
      ]);
      final moduleNameDialog = CLI_Dialog(questions: [
        ['Enter the module name where this should be created?', 'moduleName']
      ]);

      String controllerName = controllerDialog.ask()['controllerName'];
      String moduleName = moduleNameDialog.ask()['moduleName'];
      _createCubitInModule('$moduleName,$controllerName');
      break;

    case Task.model:
      final modelDialog = CLI_Dialog(questions: [
        ['Enter the model name?', 'modelName']
      ]);
      final moduleNameDialog = CLI_Dialog(questions: [
        ['Enter the module name where this should be created?', 'moduleName']
      ]);

      String modelName = modelDialog.ask()['modelName'];
      String moduleName = moduleNameDialog.ask()['moduleName'];
      _createModelInModule('$moduleName,$modelName');
      break;
    case Task.screen:
      final screenDialog = CLI_Dialog(questions: [
        ['Enter the screen name?', 'screenName']
      ]);
      final moduleNameDialog = CLI_Dialog(questions: [
        ['Enter the module name where this should be created?', 'moduleName']
      ]);

      String screenName = screenDialog.ask()['screenName'];
      String moduleName = moduleNameDialog.ask()['moduleName'];
      _createViewInModule(
        '$moduleName,$screenName',
        onlyPortrait: onlyPortrait,
        onlyLandscape: onlyLandscape,
      );
      break;
    default:
      break;
  }
}

String _toCamelCase(String value) {
  List<String> keys = value.split('_');
  List<String> processedKeys = [];
  for (String key in keys) {
    processedKeys.add(key[0].toUpperCase() + key.substring(1));
  }
  return processedKeys.join();
}

String _toLowerCamelCase(String value) {
  String camelCase = _toCamelCase(value);
  return camelCase[0].toLowerCase() + camelCase.substring(1);
}

String _toUpperCamelCase(String value) {
  String camelCase = _toCamelCase(value);
  return camelCase[0].toUpperCase() + camelCase.substring(1);
}

bool _stringToBool(String? value) {
  if (value != null) {
    return value.toLowerCase() == 'true';
  }
  return false;
}

String _getSampleModel(String name, String fileName) {
  return '''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '$fileName.freezed.dart';
part '$fileName.g.dart';

@JsonSerializable(createFactory: false)
@freezed
class ${_toUpperCamelCase(name)} with _\$${_toUpperCamelCase(name)} {
  factory ${_toUpperCamelCase(name)}({
     @Default(false) bool isLoading,
     String? id,
  }) = _${_toUpperCamelCase(name)};

  factory ${_toUpperCamelCase(name)}.fromJson(Map<String, dynamic> json) =>
      _\$${_toUpperCamelCase(name)}FromJson(json);
  @override
  Map<String, dynamic> toJson() => _\$${_toUpperCamelCase(name)}ToJson(this);
}

''';
}

String _getStatefulWidget(String name) {
  return '''
import 'package:flutter/material.dart';

class ${_toUpperCamelCase(name)}Index extends StatefulWidget {
  const ${_toUpperCamelCase(name)}Index({ Key? key }) : super(key: key);

  @override
  State<${_toUpperCamelCase(name)}Index> createState() => _${_toUpperCamelCase(name)}IndexState();
}

class _${_toUpperCamelCase(name)}IndexState extends State<${_toUpperCamelCase(name)}Index> {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
      ''';
}

String _getStatelessWidget(String name) {
  return '''
import 'package:flutter/material.dart';

class ${_toUpperCamelCase(name)}Widget extends StatelessWidget {
  const ${_toUpperCamelCase(name)}Widget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
''';
}

String _getSecondaryViewIndex({
  required String name,
  required String controllerName,
  required String controllerPath,
  required String childWidgetNameL,
  required String childWidgetPathL,
  required String childWidgetNameP,
  required String childWidgetPathP,
  required String modelName,
  required bool onlyLandscape,
  required bool onlyPortrait,
  required String modelPath,
}) {
  return '''
import 'package:get/instance_manager.dart';
import 'package:$projectName/global/utilities/layout_resolver.dart';
import 'package:$modelPath';
import 'package:$controllerPath';
${onlyLandscape ? "import 'package:$childWidgetPathL';" : onlyPortrait ? "import 'package:$childWidgetPathP';" : "import 'package:$childWidgetPathL';\nimport 'package:$childWidgetPathP';"}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class $name extends StatefulWidget {
  const $name({super.key});

  @override
  State<$name> createState() => _${name}State();
}

class _${name}State extends State<$name> {
 final $controllerName _controller = Get.find<$controllerName>();

  @override
  Widget build(BuildContext context) {
      return BlocBuilder<$controllerName, $modelName>(
        bloc: _controller,
        builder: (context, state) {
           return Scaffold(
            appBar: AppBar(
              title: const Text('${name.replaceAll('Screen', '')}'),
            ),
            body:  const LayoutResolver(
              landscapeWidget: ${onlyPortrait ? '$childWidgetNameP()' : '$childWidgetNameL()'},
              portraitWidget: ${onlyLandscape ? '$childWidgetNameL()' : '$childWidgetNameP()'},
            ),
          );
        });
  }
}
''';
}

String _getViewIndex({
  required String name,
  required String controllerName,
  required String controllerPath,
  required String childWidgetNameL,
  required String childWidgetPathL,
  required String childWidgetNameP,
  required String childWidgetPathP,
  required bool onlyLandscape,
  required bool onlyPortrait,
}) {
  return '''
import 'package:get/instance_manager.dart';
import 'package:$projectName/global/utilities/layout_resolver.dart';
import 'package:$controllerPath';
${onlyLandscape ? "import 'package:$childWidgetPathL';" : onlyPortrait ? "import 'package:$childWidgetPathP';" : "import 'package:$childWidgetPathL';\nimport 'package:$childWidgetPathP';"}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class $name extends StatefulWidget {
  const $name({super.key});

  @override
  State<$name> createState() => _${name}State();
}

class _${name}State extends State<$name> {
  late $controllerName _controller;

  @override
  void initState() {
    _controller = $controllerName();
    Get.put(_controller);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<$controllerName>();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _controller,
        child: const LayoutResolver(
        landscapeWidget: ${onlyPortrait ? '$childWidgetNameP()' : '$childWidgetNameL()'},
        portraitWidget: ${onlyLandscape ? '$childWidgetNameL()' : '$childWidgetNameP()'},
      ),
    );
  }
}
''';
}

String _getController({
  required String name,
  required String stateName,
  required String statePath,
}) {
  return '''
import 'package:$statePath';
import 'package:flutter_bloc/flutter_bloc.dart';

class $name extends Cubit<$stateName> {
  $name() : super($stateName());

  void showLoader() {
    emit(state.copyWith(isLoading: true));
  }

  void hideLoader() {
    emit(state.copyWith(isLoading: false));
  }
}

''';
}

String _getBlocPageView({
  required String modelPath,
  required String controllerPath,
  required String name,
  required String controllerName,
  required String modelName,
}) {
  return '''
import 'package:get/instance_manager.dart';
import 'package:$modelPath';
import 'package:$controllerPath';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class $name extends StatefulWidget {
  const $name({super.key});

  @override
  State<$name> createState() => _${name}State();
}

class _${name}State extends State<$name> {
   final $controllerName _controller = Get.find<$controllerName>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<$controllerName, $modelName>(
        bloc: _controller,
        builder: (context, state) {
           return Scaffold(
            appBar: AppBar(
              title: const Text('${name.replaceAll('Screen', '')}'),
            ),
          );
        });
  }
}

''';
}

void printToConsole(String message) {
  // ignore: avoid_print
  print('<========== $message ==========>');
}

Future<void> _createModelInModule(String modelData) async {
  List<String> params = modelData.split(',');
  if (params.length != 2) {
    printToConsole('Invalid input');
  } else {
    String moduleName = params.first;
    String modelName0 =
        params[1].replaceAll('model', '').replaceAll('state', '');

    String modelName = '${_toUpperCamelCase(modelName0)}Model';
    String modelFileName = '${modelName0}_model';
    String modelPath = '$baseModulePath/$moduleName/data/models';

    await _createModel(
      moduleName: modelName,
      fileName: modelFileName,
      path: modelPath,
    );

    printToConsole('Boilerplate created. Generating annotated code.');
    await Process.run(
      'flutter',
      [
        'pub',
        'run',
        'build_runner',
        'build',
        '--delete-conflicting-outputs',
      ],
    );
    printToConsole('Code generation completed');
  }
}

Future<void> _createCubitInModule(String cubitData) async {
  List<String> params = cubitData.split(',');
  if (params.length != 2) {
    printToConsole('Invalid input');
  } else {
    String moduleName = params.first;
    String cubitName =
        params[1].replaceAll('controller', '').replaceAll('cubit', '');

    String modelName = '${_toUpperCamelCase(cubitName)}State';
    String modelFileName = '${cubitName}_state_model';
    String modelPath = '$baseModulePath/$moduleName/data/models';

    String repoFileName = '${cubitName}_repository';
    String repoPath = '$baseModulePath/$moduleName/data/repositories';

    String controllerName = '${cubitName}Controller';
    String controllerFileName = '${cubitName}_controller';
    String controllerPath = '$baseModulePath/$moduleName/domain/controllers';

    await Future.wait([
      _createModel(
        moduleName: modelName,
        fileName: modelFileName,
        path: modelPath,
      ),
      _createRepository(
        moduleName: moduleName,
        fileName: repoFileName,
        path: repoPath,
      ),
      _createController(
        name: controllerName,
        fileName: controllerFileName,
        path: controllerPath,
        stateName: modelName,
        statePath:
            '$projectName/modules/$moduleName/data/models/$modelFileName.dart',
      ),
    ]);

    printToConsole('Boilerplate created. Generating annotated code.');
    await Process.run(
      'flutter',
      [
        'pub',
        'run',
        'build_runner',
        'build',
        '--delete-conflicting-outputs',
      ],
    );
    printToConsole('Code generation completed');
  }
}

Future<void> _createViewInModule(
  String viewData, {
  bool onlyLandscape = false,
  bool onlyPortrait = true,
}) async {
  List<String> params = viewData.split(',');
  if (params.length != 2) {
    printToConsole('Invalid input');
  } else {
    String moduleName = params.first;
    String viewName = params[1];

    String controllerName = '${_toUpperCamelCase(moduleName)}Controller';
    String controllerFileName = '${moduleName}_controller';

    String indexFileName = '${viewName}_index';
    String indexPath = '$baseModulePath/$moduleName/views/screens';
    String viewIndexWidgetName = '${_toUpperCamelCase(viewName)}Index';

    String responsiveFileNameP = '${viewName}_screen_portrait';
    String responsiveNameP = '${_toUpperCamelCase(viewName)}ScreenPortrait';
    String responsivePathP = '$baseModulePath/$moduleName/views/widgets';

    String responsiveFileNameL = '${viewName}_screen_landscape';
    String responsiveNameL = '${_toUpperCamelCase(viewName)}ScreenLandscape';
    String responsivePathL = '$baseModulePath/$moduleName/views/widgets';

    String modelName = '${_toUpperCamelCase(moduleName)}State';
    String modelFileName = '${moduleName}_state_model';

    Future.wait([
      _createViewIndex(
        fileName: indexFileName,
        path: indexPath,
        childWidgetNameP: responsiveFileNameP,
        childWidgetPathP:
            '$projectName/modules/$moduleName/views/widgets/$responsiveFileNameP.dart',
        childWidgetNameL: responsiveFileNameL,
        childWidgetPathL:
            '$projectName/modules/$moduleName/views/widgets/$responsiveFileNameL.dart',
        controllerName: controllerName,
        controllerPath:
            '$projectName/modules/$moduleName/domain/controllers/$controllerFileName.dart',
        name: viewIndexWidgetName,
        onlyLandscape: onlyLandscape,
        onlyPortrait: onlyPortrait,
        isSecondaryScreen: true,
        modelName: modelName,
        modelPath:
            '$projectName/modules/$moduleName/data/models/$modelFileName.dart',
      ),
      if (!onlyLandscape)
        _createBlocPageView(
          controllerName: controllerName,
          controllerPath:
              '$projectName/modules/$moduleName/domain/controllers/$controllerFileName.dart',
          modelName: modelName,
          modelPath:
              '$projectName/modules/$moduleName/data/models/$modelFileName.dart',
          name: responsiveNameP,
          fileName: responsiveFileNameP,
          path: responsivePathP,
        ),
      if (!onlyPortrait)
        _createBlocPageView(
          controllerName: controllerName,
          controllerPath:
              '$projectName/modules/$moduleName/domain/controllers/$controllerFileName.dart',
          modelName: modelName,
          modelPath:
              '$projectName/modules/$moduleName/data/models/$modelFileName.dart',
          name: responsiveNameL,
          fileName: responsiveFileNameL,
          path: responsivePathL,
        ),
    ]);
    printToConsole('Screen created.');
  }
}

void _createModule(
  String moduleName, {
  bool onlyLandscape = false,
  bool onlyPortrait = false,
}) async {
  String module = _toLowerCamelCase(moduleName);
  String moduleForFiles = moduleName[0].toLowerCase() + moduleName.substring(1);

  String modelName = '${module}State';
  String modelFileName = '${moduleForFiles}_state_model';
  String modelPath = '$baseModulePath/$moduleForFiles/data/models';

  String repoFileName = '${moduleForFiles}_repository';
  String repoPath = '$baseModulePath/$moduleForFiles/data/repositories';

  String controllerName = '${_toUpperCamelCase(module)}Controller';
  String controllerFileName = '${moduleForFiles}_controller';
  String controllerPath = '$baseModulePath/$moduleForFiles/domain/controllers';

  String indexFileName = '${moduleForFiles}_index';
  String indexPath = '$baseModulePath/$moduleForFiles/views/screens';
  String viewIndexWidgetName = '${_toUpperCamelCase(module)}Index';

  String blocPageFileNameP = '${moduleForFiles}_screen_portrait';
  String blocPageNameP = '${_toUpperCamelCase(module)}ScreenPortrait';
  String blocPagePathP = '$baseModulePath/$moduleForFiles/views/widgets';

  String blocPageFileNameL = '${moduleForFiles}_screen_landscape';
  String blocPageNameL = '${_toUpperCamelCase(module)}ScreenLandscape';
  String blocPagePathL = '$baseModulePath/$moduleForFiles/views/widgets';

  await Future.wait([
    _createModel(
      moduleName: modelName,
      fileName: modelFileName,
      path: modelPath,
    ),
    _createRepository(
      moduleName: module,
      fileName: repoFileName,
      path: repoPath,
    ),
    _createController(
      name: controllerName,
      fileName: controllerFileName,
      path: controllerPath,
      stateName: modelName,
      statePath:
          '$projectName/modules/$moduleForFiles/data/models/$modelFileName.dart',
    ),
    _createViewIndex(
      fileName: indexFileName,
      path: indexPath,
      childWidgetNameP: blocPageNameP,
      childWidgetPathP:
          '$projectName/modules/$moduleForFiles/views/widgets/$blocPageFileNameP.dart',
      childWidgetNameL: blocPageNameL,
      childWidgetPathL:
          '$projectName/modules/$moduleForFiles/views/widgets/$blocPageFileNameL.dart',
      controllerName: controllerName,
      controllerPath:
          '$projectName/modules/$moduleForFiles/domain/controllers/$controllerFileName.dart',
      name: viewIndexWidgetName,
      onlyPortrait: onlyPortrait,
      onlyLandscape: onlyLandscape,
      modelName: modelName,
      modelPath: modelPath,
    ),
    if (!onlyLandscape)
      _createBlocPageView(
        controllerName: controllerName,
        controllerPath:
            '$projectName/modules/$moduleForFiles/domain/controllers/$controllerFileName.dart',
        modelName: modelName,
        modelPath:
            '$projectName/modules/$moduleForFiles/data/models/$modelFileName.dart',
        name: blocPageNameP,
        fileName: blocPageFileNameP,
        path: blocPagePathP,
      ),
    if (!onlyPortrait)
      _createBlocPageView(
        controllerName: controllerName,
        controllerPath:
            '$projectName/modules/$moduleForFiles/domain/controllers/$controllerFileName.dart',
        modelName: modelName,
        modelPath:
            '$projectName/modules/$moduleForFiles/data/models/$modelFileName.dart',
        name: blocPageNameL,
        fileName: blocPageFileNameL,
        path: blocPagePathL,
      ),
  ]);

  printToConsole('Boilerplate created. Generating annotated code.');
  await Process.run(
    'flutter',
    [
      'pub',
      'run',
      'build_runner',
      'build',
      '--delete-conflicting-outputs',
    ],
  );
  printToConsole('Code generation completed');
}

Future<void> _createModel({
  required String moduleName,
  required String fileName,
  required String path,
}) async {
  await Directory(path).create(recursive: true);
  File('$path/$fileName.dart')
      .writeAsString(_getSampleModel(moduleName, fileName));
}

Future<void> _createRepository({
  required String moduleName,
  required String fileName,
  required String path,
}) async {
  await Directory(path).create(recursive: true);
  await File('$path/$fileName.dart')
      .writeAsString('class ${_toUpperCamelCase(moduleName)}Repository {}');
  return;
}

Future<void> _createController({
  required String name,
  required String fileName,
  required String path,
  required String stateName,
  required String statePath,
}) async {
  await Directory(path).create(recursive: true);
  await File('$path/$fileName.dart').writeAsString(_getController(
    name: _toUpperCamelCase(name),
    stateName: _toUpperCamelCase(stateName),
    statePath: statePath,
  ));
  return;
}

Future<void> _createPages({
  required String moduleName,
  required String fileName,
  required String path,
}) async {
  await Directory(path).create(recursive: true);
  await File('$path/$fileName.dart')
      .writeAsString(_getStatefulWidget(moduleName));
  return;
}

Future<void> _createWidgets({
  required String moduleName,
  required String fileName,
  required String path,
}) async {
  await Directory(path).create(recursive: true);
  await File('$path/$fileName.dart')
      .writeAsString(_getStatelessWidget(moduleName));
  return;
}

Future<void> _createViewIndex({
  required String name,
  required String controllerName,
  required String controllerPath,
  required String childWidgetNameP,
  required String childWidgetPathP,
  required String childWidgetNameL,
  required String childWidgetPathL,
  required String fileName,
  required String path,
  required bool onlyPortrait,
  required String modelName,
  required String modelPath,
  required bool onlyLandscape,
  bool isSecondaryScreen = false,
}) async {
  await Directory(path).create(recursive: true);
  if (isSecondaryScreen) {
    await File('$path/$fileName.dart').writeAsString(
      _getSecondaryViewIndex(
        childWidgetNameP: _toUpperCamelCase(childWidgetNameP),
        childWidgetPathP: childWidgetPathP,
        childWidgetNameL: _toUpperCamelCase(childWidgetNameL),
        childWidgetPathL: childWidgetPathL,
        controllerName: _toUpperCamelCase(controllerName),
        controllerPath: controllerPath,
        name: _toUpperCamelCase(name),
        onlyPortrait: onlyPortrait,
        onlyLandscape: onlyLandscape,
        modelName: modelName,
        modelPath: modelPath,
      ),
    );
  } else {
    await File('$path/$fileName.dart').writeAsString(
      _getViewIndex(
        childWidgetNameP: _toUpperCamelCase(childWidgetNameP),
        childWidgetPathP: childWidgetPathP,
        childWidgetNameL: _toUpperCamelCase(childWidgetNameL),
        childWidgetPathL: childWidgetPathL,
        controllerName: _toUpperCamelCase(controllerName),
        controllerPath: controllerPath,
        name: _toUpperCamelCase(name),
        onlyPortrait: onlyPortrait,
        onlyLandscape: onlyLandscape,
      ),
    );
  }
  return;
}

Future<void> _createBlocPageView({
  required String modelPath,
  required String controllerPath,
  required String name,
  required String controllerName,
  required String modelName,
  required String fileName,
  required String path,
}) async {
  await Directory(path).create(recursive: true);
  await File('$path/$fileName.dart').writeAsString(_getBlocPageView(
    controllerName: _toUpperCamelCase(controllerName),
    controllerPath: controllerPath,
    modelName: _toUpperCamelCase(modelName),
    modelPath: modelPath,
    name: _toUpperCamelCase(name),
  ));
  return;
}