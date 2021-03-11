/*
 * @Author: 弗拉德
 * @Date: 2021-03-10 14:39:33
 * @LastEditTime: 2021-03-11 20:22:36
 * @Support: http://fulade.me
 */

/*       
{
  "type":0,
  "commonGoods":{
      "uid":"285255922278803584",
      "userName":"落雪无痕c3525zd4",
      "userPhoto":"http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJiaaJWMqNlSJ7Ey9iaucpRia41TgO5Ofy6oVZuIKPloAFPY13WpqMNQ3RsGm34K1uC7hmtG1d8KXlTQ/132",
      "userStatus":1,
      "infoId":"1364024599314564096",
      "infoDesc":"8千多买的，放在公司一直没没用，现在公司搬家没地方放！150",
      "infoCover":{
          "picUrl":"89b97666-894a-4173-90b4-999595e44561.jpg",
          "width":"960",
          "height":"1280"
      },
      "infoCoverList":[
          {
              "picUrl":"89b97666-894a-4173-90b4-999595e44561.jpg"
          },
          {
              "picUrl":"4ac600d8-014c-401d-a719-0f7ffdc820d7.jpg"
          },
          {
              "picUrl":"e2e85c18-805e-4bfa-9393-72f7e1bc0b97.jpg"
          }
      ],
      "metric":"oC4sBl91jH4PmFkGFxAkVA13108o9",
      "infoPrice":150000,
      "status":1,
      "discountInfo":[

      ],
      "labelPosition":{

      },
      "video":{

      },
      "specialUserDesc":{
          "type":1,
          "desc":"大庆 让胡路"
      },
      "isShowUserDesc":1,
      "cateId":2107028,
      "cateChildId":2107028008,
      "dislikeList":[
          {
              "content":"不喜欢该商品"
          },
          {
              "content":"不喜欢该品牌"
          },
          {
              "content":"不喜欢个护健康",
              "type":"cate2",
              "text":"个护健康",
              "feedbackId":"2107028"
          },
          {
              "content":"商品质量差"
          },
          {
              "content":"不喜欢该卖家"
          },
          {
              "content":"已买类似商品"
          }
      ],
      "goodsIndex":4,
      "goodsPage":1,
      "title":"8千多买的，放在公司一直没没用，现在公司搬家没地方放！150",
      "grandCateId":1100000144,
      "creatTime":"1614043781464",
      "infoType":0,
      "updateTimestamp":"1614043781870",
      "isCollected":0
  }
},
*/

// commonGoods
import 'package:json_annotation/json_annotation.dart';
part 'attention_item_model.g.dart';

@JsonSerializable()
class AttentionItemModel {
  AttentionItemModel(this.type, this.commonGoods);
  int type;
  CommonGood commonGoods;
  factory AttentionItemModel.fromJson(Map<String, dynamic> json) =>
      _$AttentionItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$AttentionItemModelToJson(this);
}

@JsonSerializable()
class CommonGood {
  CommonGood(
      this.uid,
      this.userName,
      this.userPhoto,
      this.userStatus,
      this.infoId,
      this.infoDesc,
      this.infoCover,
      this.infoCoverList,
      this.metric,
      this.infoPrice,
      this.status,
      this.specialUserDesc,
      this.isShowUserDesc,
      this.cateId,
      this.cateChildId,
      this.dislikeList,
      this.video,
      this.goodsIndex,
      this.goodsPage,
      this.title,
      this.grandCateId,
      this.creatTime,
      this.infoType,
      this.updateTimestamp,
      this.isCollected);
  String uid;
  String userName;
  String userPhoto;
  int userStatus;
  String infoId;
  String infoDesc;
  InfoCover infoCover;
  List<PicUrl> infoCoverList;
  String metric;
  int infoPrice;
  int status;
  SpecialUserDesc specialUserDesc;
  int isShowUserDesc;
  int cateId;
  int cateChildId;
  List<DislikeInfo> dislikeList;
  List<VideoInfo> video;
  int goodsIndex;
  int goodsPage;
  String title;
  int grandCateId;
  String creatTime;
  int infoType;
  String updateTimestamp;
  int isCollected;

  factory CommonGood.fromJson(Map<String, dynamic> json) =>
      _$CommonGoodFromJson(json);
  Map<String, dynamic> toJson() => _$CommonGoodToJson(this);
}

@JsonSerializable()
class InfoCover {
  InfoCover(this.picUrl, this.width, this.height);
  String picUrl;
  String width;
  String height;
  factory InfoCover.fromJson(Map<String, dynamic> json) =>
      _$InfoCoverFromJson(json);
  Map<String, dynamic> toJson() => _$InfoCoverToJson(this);
}

@JsonSerializable()
class PicUrl {
  PicUrl(this.picUrl);
  String picUrl;
  factory PicUrl.fromJson(Map<String, dynamic> json) => _$PicUrlFromJson(json);
  Map<String, dynamic> toJson() => _$PicUrlToJson(this);
}

@JsonSerializable()
class DislikeInfo {
  DislikeInfo(this.content, this.type, this.text, this.feedbackId);
  String content;
  String type;
  String text;
  String feedbackId;
  factory DislikeInfo.fromJson(Map<String, dynamic> json) =>
      _$DislikeInfoFromJson(json);
  Map<String, dynamic> toJson() => _$DislikeInfoToJson(this);
}

/// specialUserDesc
@JsonSerializable()
class SpecialUserDesc {
  SpecialUserDesc(this.type, this.desc);
  int type;
  String desc;
  factory SpecialUserDesc.fromJson(Map<String, dynamic> json) =>
      _$SpecialUserDescFromJson(json);
  Map<String, dynamic> toJson() => _$SpecialUserDescToJson(this);
}

@JsonSerializable()
class VideoInfo {
  VideoInfo(this.picUrl, this.videoUrl, this.recordTime);
  String picUrl;
  String videoUrl;
  String recordTime;
  factory VideoInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoInfoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoInfoToJson(this);
}
