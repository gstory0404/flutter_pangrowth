part of '../flutter_pangrowth.dart';

/// @Author: gstory
/// @CreateDate: 2024/11/18 11:46
/// @Email gstory0404@gmail.com
/// @Description: 短剧详情

class PlayletEntity {
  int? playletId;
  String? title;
  String? coverImage;
  int? status;
  int? total;
  String? desc;
  int? categoryId;
  String? categoryName;
  String? sourceNovelName;
  String? sourceNovelAuthor;
  int? videoDuration;
  int? currentEpisode;
  int? groupId;
  int? channelId;
  int? nextSkitId;
  int? createTime;
  int? actionTime;
  int? unlockIndex;
  String? icpNumber;
  int? favoriteState;
  int? favoriteTime;
  int? favoriteCount;
  int? likeState;
  int? likeTime;
  int? likeCount;
  int? levelLabel;
  bool? isPotential;
  Map<String, dynamic>? data;

  /// [playletId] 短剧ID
  /// [title]短剧名
  /// [coverImage] 短剧的封面
  /// [status] 短剧状态 1表示未完结
  /// [total] 共多少集
  /// [desc] 简介
  /// [categoryId] 分类id
  /// [categoryName]/ 分类名称
  /// [sourceNovelName] 短剧对应的小说名
  /// [sourceNovelAuthor] 小说作者
  /// [videoDuration] 时长
  /// [currentEpisode] 播放到第几集
  /// [groupId] 播放到的剧集gid
  /// [channelId] 推荐模块id
  /// [nextSkitId] 下一步短剧的id
  /// [createTime] 上线时间
  /// [actionTime] 观看时间
  /// [unlockIndex] 解锁集数
  /// [icpNumber] 备案号
  /// [favoriteState]
  /// [favoriteTime]
  /// [favoriteCount]
  /// [likeState]
  /// [likeTime]
  /// [likeCount]
  /// [levelLabel] 等级标签 "1:S|2:A|3:B"
  /// [isPotential] 是否潜力剧
  /// [data] 原始数据
  PlayletEntity({
    this.playletId,
    this.title,
    this.coverImage,
    this.status,
    this.total,
    this.desc,
    this.categoryId,
    this.categoryName,
    this.sourceNovelName,
    this.sourceNovelAuthor,
    this.videoDuration,
    this.currentEpisode,
    this.groupId,
    this.channelId,
    this.nextSkitId,
    this.createTime,
    this.actionTime,
    this.unlockIndex,
    this.icpNumber,
    this.favoriteState,
    this.favoriteTime,
    this.favoriteCount,
    this.likeState,
    this.likeTime,
    this.likeCount,
    this.levelLabel,
    this.isPotential,
    this.data,
  });

  PlayletEntity.fromJson(Map<String, dynamic> json) {
    playletId = json['playletId'];
    title = json['title'];
    coverImage = json['coverImage'];
    status = json['status'];
    total = json['total'];
    desc = json['desc'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    sourceNovelName = json['sourceNovelName'];
    sourceNovelAuthor = json['sourceNovelAuthor'];
    videoDuration = json['videoDuration'];
    currentEpisode = json['currentEpisode'];
    groupId = json['groupId'];
    channelId = json['channelId'];
    nextSkitId = json['nextSkitId'];
    createTime = json['createTime'];
    actionTime = json['actionTime'];
    unlockIndex = json['unlockIndex'];
    icpNumber = json['icpNumber'];
    favoriteState = json['favoriteState'];
    favoriteTime = json['favoriteTime'];
    favoriteCount = json['favoriteCount'];
    likeState = json['likeState'];
    likeTime = json['likeTime'];
    likeCount = json['likeCount'];
    levelLabel = json['levelLabel'];
    isPotential = json['isPotential'];
    data = json;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playletId'] = this.playletId;
    data['title'] = this.title;
    data['coverImage'] = this.coverImage;
    data['status'] = this.status;
    data['total'] = this.total;
    data['desc'] = this.desc;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['sourceNovelName'] = this.sourceNovelName;
    data['sourceNovelAuthor'] = this.sourceNovelAuthor;
    data['videoDuration'] = this.videoDuration;
    data['currentEpisode'] = this.currentEpisode;
    data['groupId'] = this.groupId;
    data['channelId'] = this.channelId;
    data['nextSkitId'] = this.nextSkitId;
    data['createTime'] = this.createTime;
    data['actionTime'] = this.actionTime;
    data['unlockIndex'] = this.unlockIndex;
    data['icpNumber'] = this.icpNumber;
    data['favoriteState'] = this.favoriteState;
    data['favoriteTime'] = this.favoriteTime;
    data['favoriteCount'] = this.favoriteCount;
    data['likeState'] = this.likeState;
    data['likeTime'] = this.likeTime;
    data['likeCount'] = this.likeCount;
    data['levelLabel'] = this.levelLabel;
    data['isPotential'] = this.isPotential;
    return data;
  }

  ///ios数据转换
  //@property (nonatomic, assign) NSInteger shortplay_id;               // 短剧ID
  //   @property (nonatomic, copy) NSString *title;                     // 短剧名
  //   @property (nonatomic, copy) NSString *cover_image;               // 短剧的封面
  //   @property (nonatomic, assign) NSInteger status;                  // 短剧状态 1表示未完结
  //   @property (nonatomic, assign) NSInteger total;                   // 共多少集
  //   @property (nonatomic, copy) NSString *desc;                      // 简介
  //   @property (nonatomic, assign) NSInteger category_id;             // 分类id
  //   @property (nonatomic, copy) NSString *category_name;             // 分类名称
  //   @property (nonatomic, copy) NSString *source_novel_name;         // 短剧对应的小说名
  //   @property (nonatomic, copy) NSString *source_novel_author;       // 小说作者
  //   @property (nonatomic, assign) CGFloat video_duration;            // 时长
  //   @property (nonatomic, assign) NSInteger current_episode;         // 播放到第几集
  //   @property (nonatomic, assign) NSInteger group_id;                // 播放到的剧集gid
  //   @property (nonatomic, assign) NSInteger channel_id;              // 推荐模块id
  //   @property (nonatomic, assign) NSInteger next_skit_id;            // 下一步短剧的id
  //   @property (nonatomic, assign) NSInteger create_time;             // 上线时间
  //   @property (nonatomic, assign) NSInteger action_time;             // 观看时间
  //   @property (nonatomic, assign) NSInteger unlock_index;            // 解锁集数
  //   @property (nonatomic, copy) NSArray<NSNumber *> *lockStatusArray; // 解锁状态列表
  //   @property (nonatomic) NSString *icp_number;                       // 备案号
  //   @property (nonatomic, copy) NSArray<DJXShortplayCover *> *cover_image_v2s; // 短剧封面海报
  //   @property (nonatomic, copy) NSArray<DJXShortplayCover *> *poster_image_v2s; // 剧集首帧
  //   @property (nonatomic) NSInteger favorite_state;
  //   @property (nonatomic) NSInteger favorite_time;
  //   @property (nonatomic) NSInteger favorite_count;
  //   @property (nonatomic) NSInteger like_state;
  //   @property (nonatomic) NSInteger like_time;
  //   @property (nonatomic) NSInteger like_count;
  //   @property (nonatomic) NSInteger level_label;                    //等级标签 "1:S|2:A|3:B"
  //   @property (nonatomic) BOOL is_potential;                        //是否潜力剧
  factory PlayletEntity.fromIosJson(Map<String, dynamic> jsonRes) {
    return PlayletEntity(
      playletId: jsonRes["shortplay_id"],
      title: jsonRes["title"],
      coverImage: jsonRes["cover_image"],
      status: jsonRes["status"],
      total: jsonRes["total"],
      desc: jsonRes["desc"],
      categoryId: jsonRes["category_id"],
      categoryName: jsonRes["category_name"],
      sourceNovelName: jsonRes["source_novel_name"],
      sourceNovelAuthor: jsonRes["source_novel_author"],
      videoDuration: jsonRes["video_duration"],
      currentEpisode: jsonRes["current_episode"],
      groupId: jsonRes["group_id"],
      channelId: jsonRes["channel_id"],
      nextSkitId: jsonRes["next_skit_id"],
      createTime: jsonRes["create_time"],
      actionTime: jsonRes["action_time"],
      unlockIndex: jsonRes["unlock_index"],
      favoriteState: jsonRes["favorite_state"],
      favoriteTime: jsonRes["favorite_time"],
      favoriteCount: jsonRes["favorite_count"],
      likeState: jsonRes["like_state"],
      likeTime: jsonRes["like_time"],
      likeCount: jsonRes["like_count"],
      levelLabel: jsonRes["level_label"],
      isPotential: jsonRes["is_potential"],
    );
  }
}
