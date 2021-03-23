/*
 * @Author: 弗拉德
 * @Date: 2021-03-23 16:52:33
 * @LastEditTime: 2021-03-23 20:31:46
 * @Support: http://fulade.me
 */
import 'package:json_annotation/json_annotation.dart';
part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  MessageModel(this.text, this.nickName, this.imageUrl, this.portrait,
      this.isTagMessage);
  String text;
  String nickName;
  String imageUrl;
  String portrait;
  bool isTagMessage;
  //不同的类使用不同的mixin即可
  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
