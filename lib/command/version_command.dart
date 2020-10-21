import 'dart:io';

import 'package:args/command_runner.dart';

class VersionCommand extends Command {
  @override
  final description = 'Print version.';
  @override
  final name = 'version';
  final String VERSION = '1.0.1';

  VersionCommand();

  @override
  void run() {
    print('version: ${VERSION}');
    print('Dart ${Platform.version}');
  }
}
