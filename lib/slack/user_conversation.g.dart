// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserConversation _$UserConversationFromJson(Map<String, dynamic> json) {
  return UserConversation(
    (json['channels'] as List)
        ?.map((e) =>
            e == null ? null : Channel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['ok'] as bool,
  );
}

Map<String, dynamic> _$UserConversationToJson(UserConversation instance) =>
    <String, dynamic>{
      'channels': instance.channels,
      'ok': instance.ok,
    };
