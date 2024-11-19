part of 'flutter_pangrowth.dart';

/// @Author: gstory
/// @CreateDate: 2023/10/10 12:06
/// @Email gstory0404@gmail.com
/// @Description: 短剧

class PangrowthPlaylet {
  ///短剧初始化
  static Future<bool> registerPlaylet() async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("registerPlaylet", {});
  }

  ///# 打开短剧聚合页（封装方式）
  ///
  ///  - [freeCount] 免费观看的集数 默认3
  ///
  ///  - [unlockCountUsingAD] 观看一次激励视频解锁的集数 默认1
  ///
  ///  - [isShowTitle] 是否展示导航栏标题名称 默认true
  ///
  ///  - [isShowBackButton] 是否展示导航栏左上角返回按钮 默认true
  static Future<bool> openPlayletAggregatePage({
    int? freeCount,
    int? unlockCountUsingAD,
    bool? isShowTitle,
    bool? isShowBackButton,
  }) async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("openPlayletAggregatePage", {
      "freeCount": freeCount ?? 3,
      "unlockCountUsingAD": unlockCountUsingAD ?? 1,
      "isShowTitle": isShowTitle ?? true,
      "isShowBackButton": isShowBackButton ?? true,
    });
  }

  /// 分页拉取所有短剧
  /// [page] 页码
  /// [size] 每页数量
  /// [order] 排序 0：正序，1：倒序
  static Future<List<PlayletEntity>?> requestAllPlayletListPage({
    required int page,
    required int size,
    required int order,
  }) async {
    var listStr = await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestAllPlayletListPage", {
      "page": page,
      "size": size,
      "order": order,
    });
    if (listStr == null) {
      return null;
    }
    var playletList = <PlayletEntity>[];
    for (var playletStr in listStr) {
      var playlet = json.decode(playletStr);
      if (Platform.isAndroid) {
      } else if (Platform.isIOS) {
        playletList.add(PlayletEntity.fromIosJson(playlet));
      }
    }
    return playletList;
  }

  ///分页获取推荐短剧短剧
  /// [page] 页码
  /// [size] 每页数量
  static Future<List<PlayletEntity>?> requestRecommendedPlayletListPage({
    required int page,
    required int size,
  }) async {
    var listStr = await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestRecommendedPlayletListPage", {
      "page": page,
      "size": size,
    });
    if (listStr == null) {
      return null;
    }
    var playletList = <PlayletEntity>[];
    for (var playletStr in listStr) {
      var playlet = json.decode(playletStr);
      if (Platform.isAndroid) {
      } else if (Platform.isIOS) {
        playletList.add(PlayletEntity.fromIosJson(playlet));
      }
    }
    return playletList;
  }

  ///拉取所有短剧
  /// [order] 排序 0：正序，1：倒序
  static Future<List<PlayletEntity>?> requestAllPlayletListWithOrder({
    required int order,
  }) async {
    var listStr = await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestAllPlayletListWithOrder", {
      "order": order,
    });
    if (listStr == null) {
      return null;
    }
    var playletList = <PlayletEntity>[];
    for (var playletStr in listStr) {
      var playlet = json.decode(playletStr);
      if (Platform.isAndroid) {
      } else if (Platform.isIOS) {
        playletList.add(PlayletEntity.fromIosJson(playlet));
      }
    }
    return playletList;
  }

  ///根据短剧id获取列表
  /// [ids] 短剧id集合
  static Future<List<PlayletEntity>?> requestPlayletListWithPlayletId({
    required List<String> ids,
  }) async {
    var listStr = await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestPlayletListWithPlayletId", {
      "ids": ids,
    });
    if (listStr == null) {
      return null;
    }
    var playletList = <PlayletEntity>[];
    for (var playletStr in listStr) {
      var playlet = json.decode(playletStr);
      if (Platform.isAndroid) {
      } else if (Platform.isIOS) {
        playletList.add(PlayletEntity.fromIosJson(playlet));
      }
    }
    return playletList;
  }

  ///根据搜索关键词获取短剧列表
  /// [keyword] 关键词
  /// [isFuzzy] 是否模糊匹配
  /// [page] 页码
  /// [size] 每页数量
  static Future<List<PlayletEntity>?> requestCategoryPlayletLisWithSearchWord({
    required String keyword,
    required bool isFuzzy,
    required int page,
    required int size,
  }) async {
    var listStr = await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestCategoryPlayletLisWithSearchWord", {
      "keyword": keyword,
      "isFuzzy": isFuzzy,
      "page": page,
      "size": size,
    });
    if (listStr == null) {
      return null;
    }
    var playletList = <PlayletEntity>[];
    for (var playletStr in listStr) {
      var playlet = json.decode(playletStr);
      if (Platform.isAndroid) {
      } else if (Platform.isIOS) {
        playletList.add(PlayletEntity.fromIosJson(playlet));
      }
    }
    return playletList;
  }

  ///根据短剧id获取列表
  static Future<List<String>?> requestPlayletCategoryList() async {
    var list = await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestPlayletCategoryList");
    var categoryList = <String>[];
    for (String tag in list) {
      categoryList.add(tag);
    }
    return categoryList;
  }

  ///根据分类获取列表
  /// [category] 分类id
  /// [page] 页码
  /// [size] 每页数量
  static Future<List<PlayletEntity>?> requestCategoryPlayletLisWithCategory({
    required String category,
    required int page,
    required int size,
  }) async {
    var listStr = await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestCategoryPlayletLisWithCategory", {
      "category": category,
      "page": page,
      "size": size,
    });
    if (listStr == null) {
      return null;
    }
    var playletList = <PlayletEntity>[];
    for (var playletStr in listStr) {
      var playlet = json.decode(playletStr);
      if (Platform.isAndroid) {
      } else if (Platform.isIOS) {
        playletList.add(PlayletEntity.fromIosJson(playlet));
      }
    }
    return playletList;
  }

  /// 进入短剧播放器
  /// [playletId] 短剧id
  /// [index] 剧集下标
  static Future<bool> enterPlayletPlayer({
    required int playletId,
    required int index,
  }) async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("enterPlayletPlayer", {
      "playletId": playletId,
      "index": index,
    });
  }

  ///短剧历史记录列表
  /// [page] 页码
  /// [size] 每页数量
  static Future<List<PlayletEntity>?> requestPlayletHistoryListWithPage({
    required int page,
    required int size,
  }) async {
    var listStr = await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestPlayletHistoryListWithPage", {
      "page": page,
      "size": size,
    });
    if (listStr == null) {
      return null;
    }
    var playletList = <PlayletEntity>[];
    for (var playletStr in listStr) {
      var playlet = json.decode(playletStr);
      if (Platform.isAndroid) {
      } else if (Platform.isIOS) {
        playletList.add(PlayletEntity.fromIosJson(playlet));
      }
    }
    return playletList;
  }

  ///短剧历史记录清理
  static Future<bool> requestPlayletHistoryClean() async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestPlayletHistoryClean");
  }

  ///点赞某一集短剧
  /// [playletId] 短剧id
  /// [index] 剧集下标
  static Future<bool> likeShortplay({
    required int playletId,
    required int index,
  }) async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("likeShortplay", {
      "playletId": playletId,
      "index": index,
    });
  }

  ///取消点赞某一集短剧
  /// [playletId] 短剧id
  /// [index] 剧集下标
  static Future<bool> cancelLikeShortplay({
    required int playletId,
    required int index,
  }) async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("cancelLikeShortplay", {
      "playletId": playletId,
      "index": index,
    });
  }

  ///收藏某部剧
  /// [playletId] 短剧id
  static Future<bool> collectShortplay({
    required int playletId,
  }) async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("collectShortplay", {
      "playletId": playletId,
    });
  }

  ///取消收藏某部剧
  /// [playletId] 短剧id
  static Future<bool> cancelCollectShortplay({
    required int playletId,
  }) async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("cancelCollectShortplay", {
      "playletId": playletId,
    });
  }

  ///短剧收藏列表
  /// [page] 页码
  /// [size] 每页数量
  static Future<List<PlayletEntity>?> requestCollectionList({
    required int page,
    required int size,
  }) async {
    var listStr = await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestCollectionList", {
      "page": page,
      "size": size,
    });
    if (listStr == null) {
      return null;
    }
    var playletList = <PlayletEntity>[];
    for (var playletStr in listStr) {
      var playlet = json.decode(playletStr);
      if (Platform.isAndroid) {
      } else if (Platform.isIOS) {
        playletList.add(PlayletEntity.fromIosJson(playlet));
      }
    }
    return playletList;
  }
}
