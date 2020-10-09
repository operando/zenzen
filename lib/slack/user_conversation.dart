import 'package:json_annotation/json_annotation.dart';
import 'package:zenzen/slack/channel.dart';

part 'user_conversation.g.dart';

@JsonSerializable()
class UserConversation {
  @JsonKey(name: 'channels')
  final List<Channel> channels;
  @JsonKey(name: 'ok')
  final bool ok;

  UserConversation(this.channels, this.ok);

  factory UserConversation.fromJson(Map<String, dynamic> json) =>
      _$UserConversationFromJson(json);
}
