part of 'flutter_pangrowth.dart';

/// @Author: gstory
/// @CreateDate: 2021/12/3 5:33 下午
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

///数据类型
class FlutterNovelType {
  ///获取阅读历史，单本
  static const String history = "history";

  ///获取启动后推荐书列表，信息较少
  static const String recommendV1 = "recommendV1";

  ///获取Feed推荐书列表，信息较多
  static const String recommendFeed = "recommendFeed";
}

///小说导流控件类型
class FlutterNovelEntranceType{
  ///金刚位
  static const String icon = "icon";
  ///FloatBall悬浮球
  static const String floatBall = "floatBall";
  ///Banner
  static const String banner = "banner";
  ///Window
  static const String window = "window";
  ///Feed流小图
  static const String feedSingle = "feedSingle";
  ///Feed流列表
  static const String feedList = "feedList";
}

///金刚位样式
class FlutterNovelIconSytle{
  static const String circle = "circle";
  static const String rect = "rect";
}

///FloatBall悬浮球样式
class FlutterNovelFloatBallSytle{
  static const String withClose = "withClose";
  static const String withoutClose = "withoutClose";
}

///Banner样式
class FlutterNovelBannerSytle{
  static const String small = "small";
  static const String medium = "medium";
  static const String large = "large";
}

///Window样式
class FlutterNovelWindowSytle{
  static const String color1 = "color1";
  static const String color2 = "color2";
}

///Window样式
class FlutterNovelFeedSytle{
  static const String female = "female";
  static const String male = "male";
  static const String normal = "normal";
}

///全局字号大小
class NormalFontSize{
  static const String normal = "normal";
  static const String large = "large";
}

///阅读字号大小
class ReadFontSize{
  static const String one = "one";
  static const String two = "two";
  static const String there = "there";
  static const String four = "four";
  static const String five = "five";
  static const String six = "six";
}


