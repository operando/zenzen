import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:slack_leave_rejoin_channel/slack/channel.dart';
import 'package:slack_leave_rejoin_channel/slack/user_conversation.dart';

class Slack {
  static const String SLACK_API = 'https://slack.com/api/';
  final String token;

  Slack(this.token);

  Future<List<Channel>> getJoinedChannels(String userId) async {
    var url =
        '${SLACK_API}users.conversations?token=${token}&user=${userId}&pretty=1';
    var response = await http.get(url);
    if (response.statusCode != 200) {
      return List.empty();
    }
    print(response.body);
    var userConversation = UserConversation.fromJson(jsonDecode(response.body));
    if (!userConversation.ok) {
      return List.empty();
    }
    var channels = userConversation.channels
        .where(
            (e) => !e.isArchived && !e.isPrivate && !e.isGeneral && e.isChannel)
        .toList();
    channels.forEach((element) {
      print(element.name);
    });
    return channels;
  }

  Future<bool> leave(Channel channel) async {
    var url =
        '${SLACK_API}conversations.leave?token=${token}&channel=${channel.id}';
    var response = await http.post(url);
    print(response.body);
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }

  Future<bool> join(Channel channel) async {
    var url =
        '${SLACK_API}conversations.join?token=${token}&channel=${channel.id}';
    var response = await http.post(url);
    print(response.body);
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }
}
