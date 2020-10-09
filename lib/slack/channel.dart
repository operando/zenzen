import 'package:json_annotation/json_annotation.dart';

part 'channel.g.dart';

@JsonSerializable()
class Channel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'is_channel')
  final bool isChannel;
  @JsonKey(name: 'is_archived')
  final bool isArchived;
  @JsonKey(name: 'is_general')
  final bool isGeneral;
  @JsonKey(name: 'is_private')
  final bool isPrivate;

  Channel(this.id, this.name, this.isChannel, this.isArchived, this.isGeneral,
      this.isPrivate);

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelToJson(this);
}
