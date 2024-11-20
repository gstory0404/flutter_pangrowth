part of 'flutter_pangrowth.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/13 3:36 下午
/// @Email gstory0404@gmail.com
/// @Description: 内容输出视频

class PangrowthVideo {
  ///
  /// # 短视频注册初始化
  ///
  /// [debug] 是否实现日志
  ///
  static Future<bool> registerVideo({
    bool? debug,
  }) async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("registerVideo", {
      "debug": debug ?? false,
    });
  }

  ///# 打开沉浸式小视频 全屏样式
  static Future<bool> openDrawVideoFull() async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("openDrawVideoFull", null);
  }

  ///# 打开宫格小视频 全屏样式
  static Future<bool> openGridVideo() async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("openGridVideo", null);
  }

  @deprecated

  ///# 打开新闻 多列表 全屏样式
  static Future<bool> openNewsTabs() async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("openNewsTabs", null);
  }

  @deprecated

  ///# 打开新闻 单列表 全屏样式
  static Future<bool> openNewsTabOne() async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("openNewsTabOne", null);
  }

  ///# 打开个人主页
  static Future<NovelEntity> openUserCenter() async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("openUserCenter", null);
  }

  ///沉浸式小视频 view
  ///
  /// [viewWidth] 宽
  ///
  /// [viewHeight] 高
  ///
  static Widget drawVideoFullView(
      {required double viewWidth, required double viewHeight}) {
    return DrawVideoFullView(
      viewWidth: viewWidth,
      viewHeight: viewHeight,
    );
  }

  ///宫格小视频 view
  ///
  /// [viewWidth] 宽
  ///
  /// [viewHeight] 高
  ///
  static Widget gridVideoView(
      {required double viewWidth, required double viewHeight}) {
    return GridVideoView(
      viewWidth: viewWidth,
      viewHeight: viewHeight,
    );
  }

  ///新闻多列表view
  ///
  /// [viewWidth] 宽
  ///
  /// [viewHeight] 高
  ///
  static Widget newsTabsView(
      {required double viewWidth, required double viewHeight}) {
    return NewsTabsView(
      viewWidth: viewWidth,
      viewHeight: viewHeight,
    );
  }

  ///新闻单列表view
  ///
  /// [viewWidth] 宽
  ///
  /// [viewHeight] 高
  ///
  static Widget newsTabOneView(
      {required double viewWidth, required double viewHeight}) {
    return NewsTabOneView(
      viewWidth: viewWidth,
      viewHeight: viewHeight,
    );
  }

  ///视频组件-banner
  ///
  /// [viewWidth] 宽
  ///
  /// [viewHeight] 高
  ///
  static Widget videoBannerView(
      {required double viewWidth, required double viewHeight}) {
    return VideoBannerView(
      viewWidth: viewWidth,
      viewHeight: viewHeight,
    );
  }

  ///视频组件-文字链
  ///
  /// [viewWidth] 宽
  ///
  /// [viewHeight] 高
  ///
  static Widget videoTextChainView(
      {required double viewWidth, required double viewHeight}) {
    return VideoTextChainView(
      viewWidth: viewWidth,
      viewHeight: viewHeight,
    );
  }

  ///视频组件-气泡
  ///
  /// [viewWidth] 宽
  ///
  /// [viewHeight] 高
  ///
  static Widget videoBubbleView({
    required double viewWidth,
    required double viewHeight,
    required String title,
  }) {
    return VideoBubbleView(
      viewWidth: viewWidth,
      viewHeight: viewHeight,
      title: title,
    );
  }

  ///单卡片 视频
  ///
  /// [viewWidth] 宽
  ///
  /// [viewHeight] 高
  ///
  static Widget videoSingleCardView(
      {required double viewWidth, required double viewHeight}) {
    return VideoSingleCardView(
      viewWidth: viewWidth,
      viewHeight: viewHeight,
    );
  }

  ///单卡片 信息流
  ///
  /// [viewWidth] 宽
  ///
  /// [viewHeight] 高
  ///
  static Widget videoNewsSingleCardView(
      {required double viewWidth, required double viewHeight}) {
    return VideoNewsSingleCardView(
      viewWidth: viewWidth,
      viewHeight: viewHeight,
    );
  }

  ///卡片 新闻
  ///
  /// [viewWidth] 宽
  ///
  /// [viewHeight] 高
  ///
  static Widget videoCardView(
      {required double viewWidth, required double viewHeight}) {
    return VideoCardView(
      viewWidth: viewWidth,
      viewHeight: viewHeight,
    );
  }

  static Future<bool> getFeedNativeData() async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("getFeedNativeData", null);
  }
}
