// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attention_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttentionItemModel _$AttentionItemModelFromJson(Map<String, dynamic> json) {
  return AttentionItemModel(
      json['type'] as int,
      json['commonGoods'] == null
          ? null
          : CommonGood.fromJson(json['commonGoods'] as Map<String, dynamic>));
}

Map<String, dynamic> _$AttentionItemModelToJson(AttentionItemModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'commonGoods': instance.commonGoods
    };

CommonGood _$CommonGoodFromJson(Map<String, dynamic> json) {
  return CommonGood(
      json['uid'] as String,
      json['userName'] as String,
      json['userPhoto'] as String,
      json['userStatus'] as int,
      json['infoId'] as String,
      json['infoDesc'] as String,
      json['infoCover'] == null
          ? null
          : InfoCover.fromJson(json['infoCover'] as Map<String, dynamic>),
      (json['infoCoverList'] as List)
          ?.map((e) =>
              e == null ? null : PicUrl.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['metric'] as String,
      json['infoPrice'] as int,
      json['status'] as int,
      json['specialUserDesc'] == null
          ? null
          : SpecialUserDesc.fromJson(
              json['specialUserDesc'] as Map<String, dynamic>),
      json['isShowUserDesc'] as int,
      json['cateId'] as int,
      json['cateChildId'] as int,
      (json['dislikeList'] as List)
          ?.map((e) => e == null
              ? null
              : DislikeInfo.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['goodsIndex'] as int,
      json['goodsPage'] as int,
      json['title'] as String,
      json['grandCateId'] as int,
      json['creatTime'] as String,
      json['infoType'] as int,
      json['updateTimestamp'] as String,
      json['isCollected'] as int);
}

Map<String, dynamic> _$CommonGoodToJson(CommonGood instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'userName': instance.userName,
      'userPhoto': instance.userPhoto,
      'userStatus': instance.userStatus,
      'infoId': instance.infoId,
      'infoDesc': instance.infoDesc,
      'infoCover': instance.infoCover,
      'infoCoverList': instance.infoCoverList,
      'metric': instance.metric,
      'infoPrice': instance.infoPrice,
      'status': instance.status,
      'specialUserDesc': instance.specialUserDesc,
      'isShowUserDesc': instance.isShowUserDesc,
      'cateId': instance.cateId,
      'cateChildId': instance.cateChildId,
      'dislikeList': instance.dislikeList,
      'goodsIndex': instance.goodsIndex,
      'goodsPage': instance.goodsPage,
      'title': instance.title,
      'grandCateId': instance.grandCateId,
      'creatTime': instance.creatTime,
      'infoType': instance.infoType,
      'updateTimestamp': instance.updateTimestamp,
      'isCollected': instance.isCollected
    };

InfoCover _$InfoCoverFromJson(Map<String, dynamic> json) {
  return InfoCover(json['picUrl'] as String, json['width'] as String,
      json['height'] as String);
}

Map<String, dynamic> _$InfoCoverToJson(InfoCover instance) => <String, dynamic>{
      'picUrl': instance.picUrl,
      'width': instance.width,
      'height': instance.height
    };

PicUrl _$PicUrlFromJson(Map<String, dynamic> json) {
  return PicUrl(json['picUrl'] as String);
}

Map<String, dynamic> _$PicUrlToJson(PicUrl instance) =>
    <String, dynamic>{'picUrl': instance.picUrl};

DislikeInfo _$DislikeInfoFromJson(Map<String, dynamic> json) {
  return DislikeInfo(json['content'] as String, json['type'] as String,
      json['text'] as String, json['feedbackId'] as String);
}

Map<String, dynamic> _$DislikeInfoToJson(DislikeInfo instance) =>
    <String, dynamic>{
      'content': instance.content,
      'type': instance.type,
      'text': instance.text,
      'feedbackId': instance.feedbackId
    };

SpecialUserDesc _$SpecialUserDescFromJson(Map<String, dynamic> json) {
  return SpecialUserDesc(json['type'] as int, json['desc'] as String);
}

Map<String, dynamic> _$SpecialUserDescToJson(SpecialUserDesc instance) =>
    <String, dynamic>{'type': instance.type, 'desc': instance.desc};
