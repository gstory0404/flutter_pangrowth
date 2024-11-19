part of 'flutter_pangrowth.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/13 3:23 下午
/// @Email gstory0404@gmail.com
/// @Description: 内容输出小说

class PangrowthNovel {
  ///短小说初始化
  static Future<bool> registerNovel() async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("registerNovel", {});
  }

  ///# 打开小说聚合页
  static Future<bool> openNovelAggregatePage() async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("openNovelAggregatePage", null);
  }

  ///# 打开书籍
  ///
  /// [novelId] 小说id
  /// [index] 章节id
  ///
  static Future<bool> openMiniStory({
    required int novelId,
    required int index,
  }) async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("openMiniStory", {
      "novelId": novelId,
      "index": index,
    });
  }

  ///# 查询短故事类目列表
  static Future<NovelEntity> requestNovelCategoryList() async {
    dynamic data = await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestNovelCategoryList");
    print(data);
    return NovelEntity.fromJson(Map<String, dynamic>.from(data));
  }

  ///根据搜索关键词获取短剧列表
  /// [keyword] 关键词
  /// [isFuzzy] 是否模糊匹配
  /// [page] 页码
  /// [size] 每页数量
  static Future<List<NovelEntity>?> requestStoryListWithSearchWord({
    required String keyword,
    required bool isFuzzy,
    required int page,
    required int size,
  }) async {
    var listStr = await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestStoryListWithSearchWord", {
      "keyword": keyword,
      "isFuzzy": isFuzzy,
      "page": page,
      "size": size,
    });
    if (listStr == null) {
      return null;
    }
    var novelList = <NovelEntity>[];
    for (var playletStr in listStr) {
      var novel = json.decode(playletStr);
      if (Platform.isAndroid) {
      } else if (Platform.isIOS) {
        novelList.add(NovelEntity.fromIosJson(novel));
      }
    }
    return novelList;
  }

  ///短故事按照book_id查询
  /// [ids] 小说id集合
  static Future<List<NovelEntity>?> requestStoryListWithBookId({
    required List<String> ids,
  }) async {
    var listStr = await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestStoryListWithBookId", {
      "ids": ids,
    });
    if (listStr == null) {
      return null;
    }
    var novelList = <NovelEntity>[];
    for (var playletStr in listStr) {
      var novel = json.decode(playletStr);
      if (Platform.isAndroid) {
      } else if (Platform.isIOS) {
        novelList.add(NovelEntity.fromIosJson(novel));
      }
    }
    return novelList;
  }

  ///短故事分页加载
  /// [page] 页码
  /// [size] 每页数量
  /// [order] 排序 0：正序，1：倒序
  static Future<List<NovelEntity>?> requestAllStoryListPage({
    required int page,
    required int size,
    required int order,
  }) async {
    var listStr = await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestAllStoryListPage", {
      "page": page,
      "size": size,
      "order": order,
    });
    if (listStr == null) {
      return null;
    }
    var novelList = <NovelEntity>[];
    for (var playletStr in listStr) {
      var novel = json.decode(playletStr);
      if (Platform.isAndroid) {
      } else if (Platform.isIOS) {
        novelList.add(NovelEntity.fromIosJson(novel));
      }
    }
    return novelList;
  }

  ///根据排序方式，查询短故事列表
  /// [order] 排序 0：正序，1：倒序
  static Future<List<NovelEntity>?> requestAllStoryListWithOrder({
    required int order,
  }) async {
    var listStr = await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestAllStoryListWithOrder", {
      "order": order,
    });
    if (listStr == null) {
      return null;
    }
    var novelList = <NovelEntity>[];
    for (var playletStr in listStr) {
      var novel = json.decode(playletStr);
      if (Platform.isAndroid) {
      } else if (Platform.isIOS) {
        novelList.add(NovelEntity.fromIosJson(novel));
      }
    }
    return novelList;
  }

  ///根据类目id查询短故事列表
  /// [categoryId] 分类id
  /// [page] 页码
  /// [size] 每页数量
  /// [order] 排序 0：正序，1：倒序
  static Future<List<NovelEntity>?> requestCategoryStoryListWithCategoryId({
    required int categoryId,
    required int page,
    required int size,
    required int order,
  }) async {
    var listStr = await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestCategoryStoryListWithCategoryId", {
      "categoryId": categoryId,
      "page": page,
      "size": size,
      "order": order,
    });
    if (listStr == null) {
      return null;
    }
    var novelList = <NovelEntity>[];
    for (var playletStr in listStr) {
      var novel = json.decode(playletStr);
      if (Platform.isAndroid) {
      } else if (Platform.isIOS) {
        novelList.add(NovelEntity.fromIosJson(novel));
      }
    }
    return novelList;
  }

  ///短小说阅读记录
  /// [page] 页码
  /// [size] 每页数量
  static Future<List<NovelEntity>?> requestHistoryStoryList({
    required int page,
    required int size,
  }) async {
    var listStr = await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestHistoryStoryList", {
      "page": page,
      "size": size,
    });
    if (listStr == null) {
      return null;
    }
    var novelList = <NovelEntity>[];
    for (var playletStr in listStr) {
      var novel = json.decode(playletStr);
      if (Platform.isAndroid) {
      } else if (Platform.isIOS) {
        novelList.add(NovelEntity.fromIosJson(novel));
      }
    }
    return novelList;
  }

  /// 收藏短故事
  /// [novelId] 小说id
  static Future<bool> requestCollectStory({
    required int novelId,
  }) async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestCollectStory", {
      "novelId": novelId,
    });
  }

  /// 取消收藏短故事
  /// [novelId] 小说id
  static Future<bool> requestCancelCollectStory({
    required int novelId,
  }) async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestCancelCollectStory", {
      "novelId": novelId,
    });
  }

  ///短故事收藏列表
  /// [page] 页码
  /// [size] 每页数量
  static Future<List<NovelEntity>?> requestStoryCollectionList({
    required int page,
    required int size,
  }) async {
    var listStr = await FlutterPangrowth.pangrowthChannel
        .invokeMethod("requestStoryCollectionList", {
      "page": page,
      "size": size,
    });
    if (listStr == null) {
      return null;
    }
    var novelList = <NovelEntity>[];
    for (var playletStr in listStr) {
      var novel = json.decode(playletStr);
      if (Platform.isAndroid) {
      } else if (Platform.isIOS) {
        novelList.add(NovelEntity.fromIosJson(novel));
      }
    }
    return novelList;
  }
}
