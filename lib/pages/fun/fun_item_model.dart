/*
 * @Author: 弗拉德
 * @Date: 2021-02-24 15:37:30
 * @LastEditTime: 2021-02-24 16:26:41
 * @Support: http://fulade.me
 */

import 'package:json_annotation/json_annotation.dart';
part 'fun_item_model.g.dart';

@JsonSerializable()
class FunRecommend {
  FunRecommend(
      this.desc,
      this.icon,
      this.target_id,
      this.target_name,
      this.track_id,
      this.type,
      this.topic_id,
      this.topic_name,
      this.category_id,
      this.category_name,
      this.predict_click_ratio,
      this.is_activate_search);
  String desc;
  String icon;
  String target_id;
  String target_name;
  String track_id;
  String type;
  String topic_id;
  String topic_name;
  String category_id;
  String category_name;
  double predict_click_ratio;
  bool is_activate_search;
  //不同的类使用不同的mixin即可
  factory FunRecommend.fromJson(Map<String, dynamic> json) =>
      _$FunRecommendFromJson(json);
  Map<String, dynamic> toJson() => _$FunRecommendToJson(this);
}

@JsonSerializable()
class DislikeOptional {
  DislikeOptional(this.follow_user);
  bool follow_user;
  //不同的类使用不同的mixin即可
  factory DislikeOptional.fromJson(Map<String, dynamic> json) =>
      _$DislikeOptionalFromJson(json);
  Map<String, dynamic> toJson() => _$DislikeOptionalToJson(this);
}

@JsonSerializable()
class ImageItem {
  ImageItem(this.fileid, this.height, this.width, this.url, this.url_size_large,
      this.original, this.trace_id);
  String fileid;
  int height;
  int width;
  String url;
  String url_size_large;
  String original;
  String trace_id;
  factory ImageItem.fromJson(Map<String, dynamic> json) =>
      _$ImageItemFromJson(json);
  Map<String, dynamic> toJson() => _$ImageItemToJson(this);
}

@JsonSerializable()
class VideoInfo {
  VideoInfo();
  String id;
  int height;
  int width;
  String url;
  List url_info_list;
  int preload_size;
  int played_count;
  int duration;
  int frame_ts;
  bool is_user_select;
  bool is_upload;
  String thumbnail;
  factory VideoInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoInfoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoInfoToJson(this);
}

@JsonSerializable()
class FunUser {
  FunUser(
      this.userid, this.nickname, this.images, this.red_official_verify_type);
  String userid;
  String nickname;
  String images;
  int red_official_verify_type;
  factory FunUser.fromJson(Map<String, dynamic> json) =>
      _$FunUserFromJson(json);
  Map<String, dynamic> toJson() => _$FunUserToJson(this);
}

@JsonSerializable()
class FunItemModel {
  FunItemModel(
    this.cursor_score,
    this.recommend,
    this.dislike_optional,
    this.id,
    this.type,
    this.timestamp,
    this.name,
    this.title,
    this.desc,
    this.display_title,
    this.images_list,
    this.inlikes,
    this.user,
    this.model_type,
    this.is_ads,
    this.is_tracking,
    this.debug_info,
    this.is_tracking_upgrade,
    this.has_music,
    this.is_top_show_eco_officer_note,
  );

  String cursor_score;
  FunRecommend recommend;
  DislikeOptional dislike_optional;
  String id;
  String type;
  int timestamp;
  String name;
  String title;
  String desc;
  String display_title;
  List<ImageItem> images_list;
  VideoInfo video_info;
  bool inlikes;
  int likes;
  FunUser user;
  String model_type;
  bool is_ads;
  bool is_tracking;
  Map debug_info;
  bool is_tracking_upgrade;
  bool has_music;
  bool is_top_show_eco_officer_note;

  factory FunItemModel.fromJson(Map<String, dynamic> json) =>
      _$FunItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$FunItemModelToJson(this);
}

/*
{
            "cursor_score":"1614144700.9970",
            "recommend":{
                "desc":"",
                "icon":"",
                "target_id":"",
                "target_name":"",
                "track_id":"dssm_dssm_well@286swwoftbqx2n0vez9a5",
                "type":"",
                "topic_id":"",
                "topic_name":"",
                "category_id":"c00000000000000000000260",
                "category_name":"医疗药品",
                "predict_click_ratio":0.027723966166377068,
                "is_activate_search":false
            },
            "dislike_optional":{
                "follow_user":false
            },
            "id":"5fe9cd3d000000000101c46a",
            "type":"normal",
            "timestamp":1609157949,
            "name":"超痛！！但是巨好用！！",
            "title":"超痛！！但是巨好用！！",
            "desc":"小林制药液体创可贴（有点像透明的甲油[笑哭R]
真的很防水，涂上两三天还稳稳的粘着伤口
关节处涂上也完全不会有影响 。超级服帖
比普通的创可贴好用一万倍[赞R][赞R]
唯一的缺点就是剧痛，刚涂上那十",
            "display_title":"超痛！！但是巨好用！！",
            "images_list":[
                {
                    "fileid":"f2b125ce-f7f1-36ac-8e43-4a7d917137a2",
                    "height":1705,
                    "width":1279,
                    "url":"http://sns-img-qc.xhscdn.com/f2b125ce-f7f1-36ac-8e43-4a7d917137a2?imageView2/2/w/540/format/jpg/q/75",
                    "url_size_large":"http://sns-img-qc.xhscdn.com/f2b125ce-f7f1-36ac-8e43-4a7d917137a2?imageView2/2/w/1080/format/webp",
                    "original":"",
                    "trace_id":"f2b125ce-f7f1-36ac-8e43-4a7d917137a2"
                }
            ],
            "inlikes":false,
            "likes":20679,
            "user":{
                "userid":"59e57de4b1da143fea75d726",
                "nickname":"堆堆^",
                "images":"https://sns-avatar-qc.xhscdn.com/avatar/5f8812a8e2dbee0001dcd770.jpg?imageView2/2/w/80/format/jpg",
                "red_official_verify_type":0
            },
            "model_type":"note",
            "is_ads":false,
            "is_tracking":false,
            "debug_info":{

            },
            "is_tracking_upgrade":false,
            "has_music":false,
            "is_top_show_eco_officer_note":false
        }
        */
