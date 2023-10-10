part of 'flutter_pangrowth.dart';

/// @Author: gstory
/// @CreateDate: 2023/10/10 12:06
/// @Email gstory0404@gmail.com
/// @Description: 短剧

class PangrowthPlaylet {
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

  ///# 打开短剧混排页面（封装方式）
  ///- [freeCount] 免费观看的集数 默认3
  ///- [unlockCountUsingAD] 观看一次激励视频解锁的集数 默认1
  ///- [isShowTitle] 是否展示导航栏标题名称 默认true
  ///- [isShowBackButton] 是否展示导航栏左上角返回按钮 默认true
  ///- [isVideoPlaylet] 是否短视频、短剧混排 默认true
  ///- [playletFreeCount] 短剧混排流中的免费短剧集数，默认3
  ///- [topSkitId] 短剧混排流中要第一部展现的短剧id 默认0
  static Future<bool> openPlayletDrawVideoPage({
    int? freeCount,
    int? unlockCountUsingAD,
    bool? isShowTitle,
    bool? isShowBackButton,
    bool? isVideoPlaylet,
    int? playletFreeCount,
    int? topSkitId,
  }) async {
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("openPlayletDrawVideoPage", {
      "freeCount": freeCount ?? 3,
      "unlockCountUsingAD": unlockCountUsingAD ?? 1,
      "isShowTitle": isShowTitle ?? true,
      "isShowBackButton": isShowBackButton ?? true,
      "isVideoPlaylet": isVideoPlaylet ?? true,
      "playletFreeCount": playletFreeCount ?? 3,
      "topSkitId": topSkitId ?? 0,
    });
  }

  ///# 打开短剧搜索页面
  static Future<bool> openPlayletSearchPage() async{
    return await FlutterPangrowth.pangrowthChannel
        .invokeMethod("openPlayletSearchPage", {});
  }
}
