// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fun_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FunRecommend _$FunRecommendFromJson(Map<String, dynamic> json) {
  return FunRecommend(
      json['desc'] as String,
      json['icon'] as String,
      json['target_id'] as String,
      json['target_name'] as String,
      json['track_id'] as String,
      json['type'] as String,
      json['topic_id'] as String,
      json['topic_name'] as String,
      json['category_id'] as String,
      json['category_name'] as String,
      (json['predict_click_ratio'] as num)?.toDouble(),
      json['is_activate_search'] as bool);
}

Map<String, dynamic> _$FunRecommendToJson(FunRecommend instance) =>
    <String, dynamic>{
      'desc': instance.desc,
      'icon': instance.icon,
      'target_id': instance.target_id,
      'target_name': instance.target_name,
      'track_id': instance.track_id,
      'type': instance.type,
      'topic_id': instance.topic_id,
      'topic_name': instance.topic_name,
      'category_id': instance.category_id,
      'category_name': instance.category_name,
      'predict_click_ratio': instance.predict_click_ratio,
      'is_activate_search': instance.is_activate_search
    };

DislikeOptional _$DislikeOptionalFromJson(Map<String, dynamic> json) {
  return DislikeOptional(json['follow_user'] as bool);
}

Map<String, dynamic> _$DislikeOptionalToJson(DislikeOptional instance) =>
    <String, dynamic>{'follow_user': instance.follow_user};

ImageItem _$ImageItemFromJson(Map<String, dynamic> json) {
  return ImageItem(
      json['fileid'] as String,
      json['height'] as int,
      json['width'] as int,
      json['url'] as String,
      json['url_size_large'] as String,
      json['original'] as String,
      json['trace_id'] as String);
}

Map<String, dynamic> _$ImageItemToJson(ImageItem instance) => <String, dynamic>{
      'fileid': instance.fileid,
      'height': instance.height,
      'width': instance.width,
      'url': instance.url,
      'url_size_large': instance.url_size_large,
      'original': instance.original,
      'trace_id': instance.trace_id
    };

VideoInfo _$VideoInfoFromJson(Map<String, dynamic> json) {
  return VideoInfo()
    ..id = json['id'] as String
    ..height = json['height'] as int
    ..width = json['width'] as int
    ..url = json['url'] as String
    ..url_info_list = json['url_info_list'] as List
    ..preload_size = json['preload_size'] as int
    ..played_count = json['played_count'] as int
    ..duration = json['duration'] as int
    ..frame_ts = json['frame_ts'] as int
    ..is_user_select = json['is_user_select'] as bool
    ..is_upload = json['is_upload'] as bool
    ..thumbnail = json['thumbnail'] as String;
}

Map<String, dynamic> _$VideoInfoToJson(VideoInfo instance) => <String, dynamic>{
      'id': instance.id,
      'height': instance.height,
      'width': instance.width,
      'url': instance.url,
      'url_info_list': instance.url_info_list,
      'preload_size': instance.preload_size,
      'played_count': instance.played_count,
      'duration': instance.duration,
      'frame_ts': instance.frame_ts,
      'is_user_select': instance.is_user_select,
      'is_upload': instance.is_upload,
      'thumbnail': instance.thumbnail
    };

FunUser _$FunUserFromJson(Map<String, dynamic> json) {
  return FunUser(json['userid'] as String, json['nickname'] as String,
      json['images'] as String, json['red_official_verify_type'] as int);
}

Map<String, dynamic> _$FunUserToJson(FunUser instance) => <String, dynamic>{
      'userid': instance.userid,
      'nickname': instance.nickname,
      'images': instance.images,
      'red_official_verify_type': instance.red_official_verify_type
    };

FunItemModel _$FunItemModelFromJson(Map<String, dynamic> json) {
  return FunItemModel(
      json['cursor_score'] as String,
      json['recommend'] == null
          ? null
          : FunRecommend.fromJson(json['recommend'] as Map<String, dynamic>),
      json['dislike_optional'] == null
          ? null
          : DislikeOptional.fromJson(
              json['dislike_optional'] as Map<String, dynamic>),
      json['id'] as String,
      json['type'] as String,
      json['timestamp'] as int,
      json['name'] as String,
      json['title'] as String,
      json['desc'] as String,
      json['display_title'] as String,
      (json['images_list'] as List)
          ?.map((e) =>
              e == null ? null : ImageItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['inlikes'] as bool,
      json['user'] == null
          ? null
          : FunUser.fromJson(json['user'] as Map<String, dynamic>),
      json['model_type'] as String,
      json['is_ads'] as bool,
      json['is_tracking'] as bool,
      json['debug_info'] as Map<String, dynamic>,
      json['is_tracking_upgrade'] as bool,
      json['has_music'] as bool,
      json['is_top_show_eco_officer_note'] as bool)
    ..video_info = json['video_info'] == null
        ? null
        : VideoInfo.fromJson(json['video_info'] as Map<String, dynamic>)
    ..likes = json['likes'] as int;
}

Map<String, dynamic> _$FunItemModelToJson(FunItemModel instance) =>
    <String, dynamic>{
      'cursor_score': instance.cursor_score,
      'recommend': instance.recommend,
      'dislike_optional': instance.dislike_optional,
      'id': instance.id,
      'type': instance.type,
      'timestamp': instance.timestamp,
      'name': instance.name,
      'title': instance.title,
      'desc': instance.desc,
      'display_title': instance.display_title,
      'images_list': instance.images_list,
      'video_info': instance.video_info,
      'inlikes': instance.inlikes,
      'likes': instance.likes,
      'user': instance.user,
      'model_type': instance.model_type,
      'is_ads': instance.is_ads,
      'is_tracking': instance.is_tracking,
      'debug_info': instance.debug_info,
      'is_tracking_upgrade': instance.is_tracking_upgrade,
      'has_music': instance.has_music,
      'is_top_show_eco_officer_note': instance.is_top_show_eco_officer_note
    };
