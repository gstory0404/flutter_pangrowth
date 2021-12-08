export 'entity/novel_entity.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pangrowth/novel_entrance/novel_entrance_view.dart';

import 'entity/novel_entity.dart';

part 'flutter_pangrowth_code.dart';

class FlutterPangrowth {
  static const MethodChannel _channel = MethodChannel('flutter_pangrowth');

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
  /// [personalRecommend] 是否个性化推送
  ///
  static Future<bool> registerNovel({
    required String appName,
    required String appVersionName,
    required int appVersionCode,
    String? channel,
    required String andoridAppId,
    required String iosAppId,
    bool? debug,
    bool? personalRecommend,
  }) async {
    return await _channel.invokeMethod("registerNovel", {
      "appName": appName,
      "appVersionName": appVersionName,
      "appVersionCode": appVersionCode,
      "channel": channel ?? "",
      "andoridAppId": andoridAppId,
      "iosAppId": iosAppId,
      "debug": debug ?? false,
      " ": personalRecommend ?? true,
    });
  }

  ///# 打开小说页面
  static Future<bool> openNovelPage() async {
    return await _channel.invokeMethod("openNovelPage", null);
  }

  ///# 获取阅读历史，单本
  ///
  /// [size] 单次获取数量
  ///
  static Future<NovelEntity> getNovelHistory() async {
    dynamic data = await _channel.invokeMethod("getNovelHistory", {
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
    dynamic data = await _channel.invokeMethod("getNovelRecommendV1", {
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
    dynamic data = await _channel.invokeMethod("getNovelRecommendFeed", {
      "size": size,
    });
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
    return await _channel.invokeMethod("openNovelPageWithConfig", {
      "type": type,
      "book": book,
    });
  }

  ///# 为了更精准推荐书籍，当显示getReadConfigWithParam获得的书时，调用此接口,上报埋点增强推荐能力
  ///
  /// [size] 类型 0历史记录 1启动后推荐书 2Feed推荐书
  ///
  /// [book] 书籍json
  ///
  static Future<bool> reportRecentNovelShow({
    required int type,
    required String book,
  }) async {
    return await _channel.invokeMethod("reportRecentNovelShow", {
      "type": type,
      "book": book,
    });
  }

  ///# 获取小说阅读时长
  ///
  ///小说当天的阅读时长，单位为ms
  static Future<int> getReadDuration() async {
    return await _channel.invokeMethod("getReadDuration");
  }

  ///# 小说搜索推荐
  ///
  /// [queryContent] 搜索词
  ///
  static Future<NovelEntity> searchNovelSuggestions({
    required String queryContent,
  }) async {
    dynamic data = await _channel.invokeMethod("searchNovelSuggestions", {
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
    dynamic data = await _channel.invokeMethod("searchNovelResults", {
      "queryContent": queryContent,
      "offset": offset,
      "limit": limit,
    });
    print("搜索结果$data");
    return NovelEntity.fromJson(Map<String, dynamic>.from(data));
  }

  ///小说入口view
  ///
  /// [viewWidth] 宽
  ///
  /// [viewHeight] 高
  ///
  /// [type] 类型
  ///
  static Widget novelEntranceView(
      {required double viewWidth,
      required double viewHeight,
      required int type}) {
    return NovelEntranceView(
      viewWidth: viewWidth,
      viewHeight: viewHeight,
      type: type,
    );
  }
}
