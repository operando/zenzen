import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:zenzen/slack/channel.dart';
import 'package:zenzen/slack/user_conversation.dart';

class Slack {
  static const String SLACK_API = 'https://slack.com/api/';
  final log = Logger('slack');
  final String token;

  Slack(this.token);

  Future<List<Channel>> getJoinedChannels(String userId) async {
    var url =
        '${SLACK_API}users.conversations?token=${token}&user=${userId}&pretty=1';
    var response = await http.get(url);
    if (response.statusCode != 200) {
      return List.empty();
    }
    log.fine(response.body);
    var userConversation = UserConversation.fromJson(jsonDecode(response.body));
    if (!userConversation.ok) {
      return List.empty();
    }
    var channels = userConversation.channels
        .where(
            (e) => !e.isArchived && !e.isPrivate && !e.isGeneral && e.isChannel)
        .toList();
    channels.forEach((element) {
      log.fine(element.name);
    });
    return channels;
  }

  Future<bool> leave(Channel channel) async {
    var url =
        '${SLACK_API}conversations.leave?token=${token}&channel=${channel.id}';
    var response = await http.post(url);
    log.fine(response.body);
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }

  Future<bool> join(Channel channel) async {
    var url =
        '${SLACK_API}conversations.join?token=${token}&channel=${channel.id}';
    var response = await http.post(url);
    log.fine(response.body);
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }
}
