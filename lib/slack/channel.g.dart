// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Channel _$ChannelFromJson(Map<String, dynamic> json) {
  return Channel(
    json['id'] as String,
    json['name'] as String,
    json['is_channel'] as bool,
    json['is_archived'] as bool,
    json['is_general'] as bool,
    json['is_private'] as bool,
  );
}

Map<String, dynamic> _$ChannelToJson(Channel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_channel': instance.isChannel,
      'is_archived': instance.isArchived,
      'is_general': instance.isGeneral,
      'is_private': instance.isPrivate,
    };
