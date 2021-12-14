export 'entity/novel_entity.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pangrowth/novel_entrance/novel_entrance_view.dart';
import 'package:flutter_pangrowth/video/DrawVideoFullView.dart';

import 'entity/novel_entity.dart';

part 'flutter_pangrowth_code.dart';

part 'flutter_pangrowth_novel.dart';
part 'flutter_pangrowth_video.dart';

class FlutterPangrowth {
  static const MethodChannel pangrowthChannel = MethodChannel('flutter_pangrowth');

}
