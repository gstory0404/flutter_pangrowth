part of 'flutter_pangrowth.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/13 3:36 下午
/// @Email gstory0404@gmail.com
/// @Description: 内容合作视频

class PangrowthVideo{
  ///
  /// # NovelSDK注册初始化
  ///
  /// [appName] app名字
  ///
  /// [andoridSiteId] andorid广告appId innerOpenAdSdk = true时必填
  ///
  /// [iosAppId] ios广告appId innerOpenAdSdk = true时必填
  ///
  /// [debug] 是否实现日志
  ///
  /// [mPartner] 合作方标识，必填
  ///
  ///  [mSecureKey] 必填
  ///
  ///  [mOldPartner] 通过API方式对接的合作方身份
  ///
  ///   [mOldUUID] 通过API方式对接时传给字节的用户身份标识
  ///
  static Future<bool> registerVideo({
    required String appName,
    required String andoridAppId,
    required String iosAppId,
    bool? debug,
    String? mPartner,
    String? mSecureKey,
    String? mOldPartner,
    String? mOldUUID,
  }) async {
    return await FlutterPangrowth.pangrowthChannel.invokeMethod("registerVideo", {
      "andoridAppId": andoridAppId,
      "iosAppId": iosAppId,
      "debug": debug ?? false,
      "mPartner": mPartner,
      "mSecureKey": mSecureKey,
      "mOldPartner": mOldPartner,
      "mOldUUID": mOldUUID,
    });
  }

  ///# 打开沉浸式小视频 全屏样式
  static Future<NovelEntity> openDrawVideoFull() async {
    return await FlutterPangrowth.pangrowthChannel.invokeMethod("openDrawVideoFull", null);
  }

  ///# 打开宫格小视频 全屏样式
  static Future<NovelEntity> openGridVideo() async {
    return await FlutterPangrowth.pangrowthChannel.invokeMethod("openGridVideo", null);
  }

  ///# 打开新闻 多列表
  static Future<NovelEntity> openNewsTabs() async {
    return await FlutterPangrowth.pangrowthChannel.invokeMethod("openNewsTabs", null);
  }

  ///# 打开新闻 单列表
  static Future<NovelEntity> openNewsTabOne() async {
    return await FlutterPangrowth.pangrowthChannel.invokeMethod("openNewsTabOne", null);
  }


  static Widget drawVideoFullView(
      {required double viewWidth,
        required double viewHeight}) {
    return DrawVideoFullView(
      viewWidth: viewWidth,
      viewHeight: viewHeight,
    );
  }
}

