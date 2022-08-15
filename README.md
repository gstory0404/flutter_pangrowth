# 字节跳动内容合作 Flutter版本
<p>
<a href="https://pub.flutter-io.cn/packages/flutter_pangrowth"><img src=https://img.shields.io/badge/flutter_pangrowth-v1.0.6-success></a>
</p>

## 简介
flutter_pangrowth是一个可以帮助开发者直接引入穿山甲内容合作，为自己app无侵入快速引入小说、视频内容的插件。[体验demo](https://www.pgyer.com/sUQU)

<img src="https://github.com/gstory0404/flutter_pangrowth/blob/master/images/1639014433814834.gif" width="30%"><img src="https://github.com/gstory0404/flutter_pangrowth/blob/branch_video/images/video.gif" width="30%">



## 说明

使用flutter_pangrowth插件，必须先接入穿山甲广告插件[flutter_unionad](https://github.com/gstory0404/flutter_unionad),不然无法显示广告

## 接入文档 (插件升级必须对照以下文档变动，以防不必要错误)

* [Android](https://github.com/gstory0404/flutter_pangrowth/blob/master/Android.md)

* [ios](https://github.com/gstory0404/flutter_pangrowth/blob/master/IOS.md)

## 本地环境
```
[✓] Flutter (Channel stable, 3.0.4, on macOS 12.5 21G72 darwin-x64, locale zh-Hans-CN)
[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.0-rc1)
[✓] Xcode - develop for iOS and macOS (Xcode 13.4.1)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2021.2)
[✓] IntelliJ IDEA Ultimate Edition (version 2022.1.1)
[✓] VS Code (version 1.69.2)
[✓] Connected device (3 available)
[✓] HTTP Host Availability
```

## 原生SDK版本
#### 1、android
2.7.0.5

#### 2、ios
2.7.0.0(短视频静态库)

## 集成步骤
#### 1、pubspec.yaml
```Dart
flutter_pangrowth: ^1.0.6
//该版本必须指定广告插件版本，不然会出现兼容问题
flutter_unionad: 1.3.8
```

#### 2、引入
```Dart
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
```

## 使用

### [小说使用文档](https://github.com/gstory0404/flutter_pangrowth/blob/branch_video/novel.md)
### [短视频使用文档](https://github.com/gstory0404/flutter_pangrowth/blob/branch_video/video.md)

## 插件链接

|插件|地址|
|:----|:----|
|字节穿山甲广告插件|[flutter_unionad](https://github.com/gstory0404/flutter_unionad)|
|腾讯优量汇广告插件|[flutter_tencentad](https://github.com/gstory0404/flutter_tencentad)|
|聚合广告插件|[flutter_universalad](https://github.com/gstory0404/flutter_universalad)|
|百度百青藤广告插件|[flutter_baiduad](https://github.com/gstory0404/flutter_baiduad)|
|字节穿山甲内容合作插件|[flutter_pangrowth](https://github.com/gstory0404/flutter_pangrowth)|
|文档预览插件|[file_preview](https://github.com/gstory0404/file_preview)|
|滤镜|[gpu_image](https://github.com/gstory0404/gpu_image)|
|Gromore聚合广告|[gromore](https://github.com/gstory0404/gromore)|

### 开源不易，觉得有用的话可以请作者喝杯奶茶🧋
<img src="https://github.com/gstory0404/flutter_pangrowth/blob/master/images/weixin.jpg" width = "200" height = "160" alt="打赏"/>

## 联系方式
* Email: gstory0404@gmail.com
* Blog：https://www.gstory.cn/

* QQ群: <a target="_blank" href="https://qm.qq.com/cgi-bin/qm/qr?k=4j2_yF1-pMl58y16zvLCFFT2HEmLf6vQ&jump_from=webapi"><img border="0" src="//pub.idqqimg.com/wpa/images/group.png" alt="649574038" title="flutter交流"></a>


