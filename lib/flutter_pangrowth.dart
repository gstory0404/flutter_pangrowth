import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pangrowth/novel_entrance/novel_entrance_view.dart';
import 'package:flutter_pangrowth/video/draw_video_full_view.dart';
import 'package:flutter_pangrowth/video/grid_video_view.dart';
import 'package:flutter_pangrowth/video/news_tab_one_view.dart';
import 'package:flutter_pangrowth/video/news_tabs_view.dart';
import 'package:flutter_pangrowth/video/video_banner_view.dart';
import 'package:flutter_pangrowth/video/video_card_view.dart';
import 'package:flutter_pangrowth/video/video_news_single_card_view.dart';
import 'package:flutter_pangrowth/video/video_single_card_view.dart';
import 'package:flutter_pangrowth/video/video_textchain_view.dart';
import 'package:flutter_pangrowth/video/video_bubble_view.dart';
import 'package:flutter_pangrowth/playlet/PlayletCardView.dart';

part 'flutter_pangrowth_code.dart';

part 'flutter_pangrowth_novel.dart';
part 'flutter_pangrowth_video.dart';
part 'flutter_pangrowth_playlet.dart';

part  'entity/playlet_entity.dart';
part  'entity/novel_entity.dart';

class FlutterPangrowth {
  static const MethodChannel pangrowthChannel = MethodChannel('flutter_pangrowth');

  static Future<bool> registerAd({
    required String androidAppId,
    required String iosAppId,
  }) async {
    return await FlutterPangrowth.pangrowthChannel.invokeMethod("registerAd", {
      "androidAppId": androidAppId,
      "iosAppId": iosAppId,
    });
  }
}
