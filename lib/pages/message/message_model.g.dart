// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return MessageModel(
      json['text'] as String,
      json['nickName'] as String,
      json['imageUrl'] as String,
      json['portrait'] as String,
      json['isTagMessage'] as bool);
}

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'nickName': instance.nickName,
      'imageUrl': instance.imageUrl,
      'portrait': instance.portrait,
      'isTagMessage': instance.isTagMessage
    };
