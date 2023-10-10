part of 'flutter_pangrowth.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/13 3:23 下午
/// @Email gstory0404@gmail.com
/// @Description: 内容输出小说

class PangrowthNovel{
  ///
  /// # NovelSDK注册初始化
  ///
  /// [appName] 接入小说SDK的App的英文名 必填
  ///
  /// [appVersionName] 入小说SDKApp的版本名称 必填
  ///
  /// [appVersionCode] 接入小说SDK App的版本号 必填
  ///
  /// [channel] 埋点上传时的渠道号维度。开发者自定义字符串即可(建议不要包含test)。选填
  ///
  /// [innerOpenAdSdk] 是否自动初始化广告sdk
  ///
  /// [andoridSiteId] andorid广告appId innerOpenAdSdk = true时必填
  ///
  /// [iosAppId] ios广告appId innerOpenAdSdk = true时必填
  ///
  /// [debug] 是否实现日志
  ///
  /// [personalRecommendAd] 是否个性化推送广告
  ///
  ///  [personalRecommendContent] 是否个性化推送小说内容
  ///
  ///  [normalFontType] 全局字号大小
  ///
  ///   [readFontType] 阅读字号大小
  ///
  static Future<bool> registerNovel({
    required String appName,
    required String appVersionName,
    required int appVersionCode,
    String? channel,
    required String andoridAppId,
    required String iosAppId,
    bool? debug,
    bool? personalRecommendAd,
    bool? personalRecommendContent,
    String? normalFontType,
    String? readFontType,
  }) async {
    return await FlutterPangrowth.pangrowthChannel.invokeMethod("registerNovel", {
      "appName": appName,
      "appVersionName": appVersionName,
      "appVersionCode": appVersionCode,
      "channel": channel ?? "",
      "andoridAppId": andoridAppId,
      "iosAppId": iosAppId,
      "debug": debug ?? false,
      "personalRecommendAd": personalRecommendAd ?? true,
      "personalRecommendContent": personalRecommendContent ?? true,
      "normalFontType": normalFontType ?? NormalFontSize.normal,
      "readFontType": readFontType ?? ReadFontSize.two,
    });
  }

  ///# 打开小说页面
  static Future<bool> openNovelPage() async {
    return await FlutterPangrowth.pangrowthChannel.invokeMethod("openNovelPage", null);
  }

  ///# 获取阅读历史，单本
  ///
  /// [size] 单次获取数量
  ///
  static Future<NovelEntity> getNovelHistory() async {
    dynamic data = await FlutterPangrowth.pangrowthChannel.invokeMethod("getNovelHistory", {
      "size": 1,
    });
    return NovelEntity.fromJson(Map<String,dynamic>.from(data));
  }

  ///# 获取启动后推荐书列表，信息较少
  ///
  /// [size] 单次获取数量
  ///
  static Future<NovelEntity> getNovelRecommendV1({
    required int size,
  }) async {
    dynamic data = await FlutterPangrowth.pangrowthChannel.invokeMethod("getNovelRecommendV1", {
      "size": size,
    });
    return NovelEntity.fromJson(Map<String, dynamic>.from(data));
  }

  ///# 获取Feed推荐书列表，信息较多
  ///
  /// [size] 单次获取数量
  ///
  static Future<NovelEntity> getNovelRecommendFeed({
    required int size,
  }) async {
    dynamic data = await FlutterPangrowth.pangrowthChannel.invokeMethod("getNovelRecommendFeed", {
      "size": size,
    });
    print("结果 =》$data");
    return NovelEntity.fromJson(Map<String, dynamic>.from(data));
  }

  ///# 打开书籍
  ///
  /// [size] 类型 0历史记录 1启动后推荐书 2Feed推荐书
  ///
  /// [book] 书籍json
  ///
  static Future<bool> openNovelPageWithConfig({
    required int type,
    required String book,
  }) async {
    return await FlutterPangrowth.pangrowthChannel.invokeMethod("openNovelPageWithConfig", {
      "type": type,
      "book": book,
    });
  }

  ///# 为了更精准推荐书籍，当显示历史、feed推荐书时，调用此接口,上报埋点增强推荐能力
  ///
  /// [type] 类型 0历史记录 1启动后推荐书 2Feed推荐书
  ///
  /// [book] 书籍json
  ///
  static Future<bool> reportRecentNovelShow({
    required int type,
    required String book,
  }) async {
    return await FlutterPangrowth.pangrowthChannel.invokeMethod("reportRecentNovelShow", {
      "type": type,
      "book": book,
    });
  }

  ///#当点击历史、feed推荐书时，调用此接口
  ///
  /// [type] 类型 0历史记录 1启动后推荐书 2Feed推荐书
  ///
  /// [book] 书籍json
  ///
  static Future<bool> reportRecentNovelClick({
    required int type,
    required String book,
  }) async {
    return await FlutterPangrowth.pangrowthChannel.invokeMethod("reportRecentNovelClick", {
      "type": type,
      "book": book,
    });
  }

  ///# 获取小说阅读时长
  ///
  ///小说当天的阅读时长，单位为ms
  static Future<int> getReadDuration() async {
    return await FlutterPangrowth.pangrowthChannel.invokeMethod("getReadDuration");
  }

  ///# 小说搜索推荐
  ///
  /// [queryContent] 搜索词
  ///
  static Future<NovelEntity> searchNovelSuggestions({
    required String queryContent,
  }) async {
    dynamic data = await FlutterPangrowth.pangrowthChannel.invokeMethod("searchNovelSuggestions", {
      "queryContent": queryContent,
    });
    return NovelEntity.fromJson(
        Map<String, dynamic>.from(data));
  }

  ///# 小说搜索结果
  ///
  /// [queryContent] 搜索词
  ///
  static Future<NovelEntity> searchNovelResults({
    required String queryContent,
    required int offset,
    required int limit,
  }) async {
    print("开始搜索$queryContent");
    dynamic data = await FlutterPangrowth.pangrowthChannel.invokeMethod("searchNovelResults", {
      "queryContent": queryContent,
      "offset": offset,
      "limit": limit,
    });
    print("搜索结果$data");
    return NovelEntity.fromJson(Map<String, dynamic>.from(data));
  }

  ///# 打开书籍
  ///
  /// [url] 小说跳转地址
  ///
  static Future<bool> openNovelPageWithUrl({
    required String url,
  }) async {
    return await FlutterPangrowth.pangrowthChannel.invokeMethod("openNovelPageWithUrl", {
      "url": url,
    });
  }

  ///小说入口view
  ///
  /// [viewWidth] 宽
  ///
  /// [viewHeight] 高
  ///
  /// [type] 类型
  ///
  /// [style] 样式
  ///
  static Widget novelEntranceView(
      {required double viewWidth,
        required double viewHeight,
        required String type,
        required String style}) {
    return NovelEntranceView(
      viewWidth: viewWidth,
      viewHeight: viewHeight,
      type: type,
      style: style,
    );
  }
}

