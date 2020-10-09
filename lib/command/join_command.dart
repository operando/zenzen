import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:slack_leave_rejoin_channel/slack/channel.dart';
import 'package:slack_leave_rejoin_channel/slack/slack.dart';

class JoinCommand extends Command {
  @override
  String description = 'slack channel join.';
  @override
  String name = 'rejoin';

  final String token;
  final String joinChannelsFile;

  JoinCommand(this.token, this.joinChannelsFile);

  @override
  void run() {
    final file = File(joinChannelsFile);
    if (!file.existsSync()) {
      print('file not found.');
      return;
    }
    final slack = Slack(token);
    (json.decode(file.readAsStringSync()) as List)
        .map((e) => Channel.fromJson(e))
        .toList()
        .forEach((element) async {
      await slack.join(element);
    });
  }
}
