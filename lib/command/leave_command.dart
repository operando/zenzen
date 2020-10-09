import 'dart:collection';

import 'package:args/command_runner.dart';
import 'package:zenzen/slack/slack.dart';

class LeaveCommand extends Command {
  @override
  String description = 'slack channel leave.';
  @override
  String name = 'leave';

  final String token;
  final String userId;
  final UnmodifiableListView<dynamic> notLeaveChannels;

  LeaveCommand(this.token, this.userId, this.notLeaveChannels);

  @override
  Future<void> run() async {
    final slack = Slack(token);
    final channels = await slack.getJoinedChannels(userId);
    if (channels.isEmpty) {
      print('channel is empty.');
      return;
    }
    channels
        .where((channel) => !notLeaveChannels.whereType<String>().any((e) {
              return e == channel.name ||
                  e == channel.id ||
                  (e.startsWith('#') &&
                      e.replaceFirst('#', '') == channel.name);
            }))
        .forEach((channel) async {
      await slack.leave(channel);
    });
  }
}
