import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:zenzen/slack/slack.dart';

class LeaveCommand extends Command {
  @override
  String description = 'slack channel leave.';
  @override
  String name = 'leave';

  final log = Logger('leave');
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

    final leaveChannel = channels
        .where((channel) => !notLeaveChannels.whereType<String>().any((e) {
              return e == channel.name ||
                  e == channel.id ||
                  (e.startsWith('#') &&
                      e.replaceFirst('#', '') == channel.name);
            }))
        .toList();

    final now = DateFormat('yyyy_MM_dd_HH_mm_ss').format(DateTime.now());
    final f = File('leave-channel-list-${now}.json');
    await f.writeAsString(jsonEncode(leaveChannel));

    leaveChannel.forEach((channel) async {
      log.fine('leave channel : ${channel.name}');
      await slack.leave(channel);
    });
  }
}
