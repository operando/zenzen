import 'dart:collection';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:logging/logging.dart';
import 'package:toml/loader.dart';
import 'package:toml/loader/fs.dart';
import 'package:zenzen/command/join_command.dart';
import 'package:zenzen/command/leave_command.dart';
import 'package:zenzen/command/version_command.dart';

Future<void> main(List<String> arguments) async {
  FilesystemConfigLoader.use();
  var cfg = await loadConfig();

  final token = cfg['slack']['token'];
  if (token == null) {
    print('slack token is null.');
    return;
  }

  final logLevelName =
      (cfg['logging']['level'] as String ?? Level.OFF.name).toLowerCase();
  final logLevel = Level.LEVELS.firstWhere(
      (element) => element.name.toLowerCase() == logLevelName,
      orElse: () => Level.OFF);
  Logger.root.level = logLevel;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  final version = VersionCommand();
  final cr = CommandRunner('zenzen',
      'leave from many channels on Slack.You can also rejoin the channel from which you left.');
  final notLeaveChannels = cfg['slack']['not_leave_channels'];
  cr
    ..argParser.addFlag('version',
        abbr: 'v', negatable: false, help: version.description, callback: (f) {
      if (f) {
        cr.run(['version']);
        exit(0);
      }
    })
    ..addCommand(version)
    ..addCommand(JoinCommand(token, cfg['slack']['rejoin_channel_json_file']))
    ..addCommand(LeaveCommand(token, cfg['slack']['user_id'],
        notLeaveChannels ?? UnmodifiableListView(List.empty())))
    ..run(arguments).catchError((e) {
      if (e is! UsageException) throw e;
      print(e);
      exit(64);
    });
}
