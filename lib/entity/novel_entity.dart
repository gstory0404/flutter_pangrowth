part of '../flutter_pangrowth.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/7 4:01 下午
/// @Email gstory0404@gmail.com
/// @Description: 小说数据

class NovelEntity {
  int? bookId;
  String? title;
  String? desc;
  String? author;
  String? coverImage;
  int? categoryId;
  String? categoryName;
  int? total;
  int? createTime;
  int? index;
  double? progress;
  int? statsCount;
  int? favoriteState;
  int? favoriteTime;
  int? coverType;
  String? contentTruncation;
  Map<String, dynamic>? data;

  /// [bookId] 短故事ID
  /// [title] 短故事名
  /// [desc] 简介
  /// [author] 小说作者
  /// [coverImage] 短故事的封面
  /// [categoryId] 类目id
  /// [categoryName] 类目名称
  /// [total] 总共章数
  /// [createTime] 上线时间
  /// [index] 当前集数
  /// [progress] 本章阅读进度
  /// [statsCount] 用户阅读次数
  /// [favoriteState] 1表示已收藏，非1表示未收藏
  /// [favoriteTime] 收藏时间，单位秒
  /// [coverType] 0:短故事封面，1:默认图，2:无图
  /// [contentTruncation] 第一章前300个字
  /// [data] 原始数据
  NovelEntity(
      {this.bookId,
      this.title,
      this.desc,
      this.author,
      this.coverImage,
      this.categoryId,
      this.categoryName,
      this.total,
      this.createTime,
      this.index,
      this.progress,
      this.statsCount,
      this.favoriteState,
      this.favoriteTime,
      this.coverType,
      this.contentTruncation,
      this.data});

  NovelEntity.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    title = json['title'];
    desc = json['desc'];
    author = json['author'];
    coverImage = json['cover_image'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    total = json['total'];
    createTime = json['create_time'];
    index = json['index'];
    progress = json['progress'];
    statsCount = json['stats_count'];
    favoriteState = json['favorite_state'];
    favoriteTime = json['favorite_time'];
    coverType = json['cover_type'];
    contentTruncation = json['content_truncation'];
    data = json;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['author'] = this.author;
    data['cover_image'] = this.coverImage;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['total'] = this.total;
    data['create_time'] = this.createTime;
    data['index'] = this.index;
    data['progress'] = this.progress;
    data['stats_count'] = this.statsCount;
    data['favorite_state'] = this.favoriteState;
    data['favorite_time'] = this.favoriteTime;
    data['cover_type'] = this.coverType;
    data['content_truncation'] = this.contentTruncation;
    data['data'] = this.data;
    return data;
  }

  //@property (nonatomic) NSInteger book_id;                        //短故事ID
  // @property (nonatomic, copy) NSString *title;                    //短故事名
  // @property (nonatomic, copy) NSString *desc;                     //简介
  // @property (nonatomic, copy) NSString *author;                   //小说作者
  // @property (nonatomic, copy) NSString *cover_image;              //短故事的封面
  // @property (nonatomic) NSInteger category_id;                    //类目id
  // @property (nonatomic, copy) NSString *category_name;            //类目名称
  // @property (nonatomic, assign) NSInteger total;                  //总共章数
  // @property (nonatomic, assign) NSInteger create_time;            //上线时间
  // //当前用户阅读进度信息
  // @property (nonatomic, assign) NSInteger index;                  //当前集数
  // @property (nonatomic, assign) CGFloat progress;                 //本章阅读进度
  // //短故事统计数据
  // @property (nonatomic, assign) NSInteger stats_count;            //用户阅读次数
  //
  // /// 1表示已收藏，非1表示未收藏
  // @property (nonatomic) NSInteger favorite_state;
  // /// 收藏时间，单位秒
  // @property (nonatomic) NSInteger favorite_time;
  //
  // @property (nonatomic) NSInteger cover_type;                     // 0:短故事封面，1:默认图，2:无图
  // @property (nonatomic, copy) NSString *content_truncation;       // 第一章前300个字
  factory NovelEntity.fromIosJson(Map<String, dynamic> jsonRes) {
    return NovelEntity(
      bookId: jsonRes["book_id"],
      title: jsonRes["title"],
      desc: jsonRes["desc"],
      author: jsonRes["author"],
      coverImage: jsonRes["cover_image"],
      categoryId: jsonRes["category_id"],
      categoryName: jsonRes["category_name"],
      total: jsonRes["total"],
      createTime: jsonRes["create_time"],
      index: jsonRes["index"],
      progress: jsonRes["progress"] * 1.0,
      statsCount: jsonRes["stats_count"],
      favoriteState: jsonRes["favorite_state"],
      favoriteTime: jsonRes["favorite_time"],
      coverType: jsonRes["cover_type"],
      contentTruncation: jsonRes["content_truncation"],
      data: jsonRes,
    );
  }
}
