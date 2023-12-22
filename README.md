# 字节跳动内容输出 Flutter版本

<p>
<a href="https://pub.flutter-io.cn/packages/flutter_pangrowth"><img src=https://img.shields.io/pub/v/flutter_pangrowth?color=orange></a>
<a href="https://pub.flutter-io.cn/packages/flutter_pangrowth"><img src=https://img.shields.io/pub/likes/flutter_pangrowth></a>
<a href="https://pub.flutter-io.cn/packages/flutter_pangrowth"><img src=https://img.shields.io/pub/points/flutter_pangrowth></a>
<a href="https://github.com/gstory0404/flutter_pangrowth/commits"><img src=https://img.shields.io/github/last-commit/gstory0404/flutter_pangrowth></a>
<a href="https://github.com/gstory0404/flutter_pangrowth"><img src=https://img.shields.io/github/stars/gstory0404/flutter_pangrowth></a>
</p>
<p>
<a href="http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=VhD0AZSmzvsD3fu7CeQFkzpBQHMHANb1&authKey=W7JGJ0HKklyhP1jyBvbTF2Dkw0cq4UmhVSx2zXVdIm6n48Xrto%2B7%2B1n9jbkAadyF&noverify=0&group_code=649574038"><img src=https://img.shields.io/badge/flutter%E4%BA%A4%E6%B5%81%E7%BE%A4-649574038-blue></a>
<a href="http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=9I9lyXewEsEnx0f00EOF_9hEcFmG5Bmg&authKey=AJfQ8%2FhOLcoJ0p5B16EITjFav1IIs3UAerZSUsWZfa0evuklgxibHti51AYlZgI3&noverify=0&group_code=769626410"><img src=https://img.shields.io/badge/flutter%E4%BA%A4%E6%B5%81%E7%BE%A42-769626410-blue></a>
</p>

## 简介
flutter_pangrowth是一个可以帮助开发者直接引入穿山甲内容输出，为自己app无侵入快速引入小说、视频内容的插件。[体验demo](https://www.pgyer.com/sUQU)

<img src="https://github.com/gstory0404/flutter_pangrowth/blob/master/images/1639014433814834.gif" width="30%"><img src="https://github.com/gstory0404/flutter_pangrowth/blob/master/images/video.gif" width="30%"><img src="https://github.com/gstory0404/flutter_pangrowth/blob/master/images/playlet.gif" width="30%">

## 说明

使用flutter_pangrowth插件，必须先接入穿山甲广告插件[flutter_unionad](https://github.com/gstory0404/flutter_unionad),不然无法显示广告

## 接入文档 (插件升级必须对照以下文档变动，以防不必要错误)

* [Android](https://github.com/gstory0404/flutter_pangrowth/blob/master/doc/Android.md)

* [ios](https://github.com/gstory0404/flutter_pangrowth/blob/master/doc/IOS.md)

## 本地环境
```
[✓] Flutter (Channel stable, 3.10.6, on macOS 13.5 22G74 darwin-x64, locale
    zh-Hans-CN)
[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.1)
[✓] Xcode - develop for iOS and macOS (Xcode 14.3.1)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2022.1)
[✓] IntelliJ IDEA Ultimate Edition (version 2023.2)
[✓] VS Code (version 1.80.2)
[✓] Connected device (4 available)
[✓] Network resources
```

## 原生SDK版本
#### 1、android
[3.9.0.2](https://www.csjplatform.com/union/media/union/download/detail?id=81&docId=61278ade8b4d7d004768125c&osType=)

#### 2、ios
[3.9.0.2(短视频静态库)](https://www.csjplatform.com/union/media/union/download/detail?id=81&docId=614564ca6b639b0042135d6b&osType=)

## 集成步骤
#### 1、pubspec.yaml
```Dart
flutter_pangrowth: ^1.0.9
//该版本必须指定广告插件版本，不然会出现兼容问题
flutter_unionad: 1.3.27
```

#### 2、引入
```Dart
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
```

## 使用文档

### [~~小说使用文档(官方已下线)~~](https://github.com/gstory0404/flutter_pangrowth/blob/master/doc/novel.md)
### [短视频使用文档](https://github.com/gstory0404/flutter_pangrowth/blob/master/doc/video.md)
### [短剧使用文档](https://github.com/gstory0404/flutter_pangrowth/blob/master/doc/playlet.md)

## 插件链接

|插件|地址|
|:----|:----|
|字节-穿山甲广告插件|[flutter_unionad](https://github.com/gstory0404/flutter_unionad)|
|腾讯-优量汇广告插件|[flutter_tencentad](https://github.com/gstory0404/flutter_tencentad)|
|百度-百青藤广告插件|[baiduad](https://github.com/gstory0404/baiduad)|
|字节-Gromore聚合广告|[gromore](https://github.com/gstory0404/gromore)|
|Sigmob广告|[sigmobad](https://github.com/gstory0404/sigmobad)|
|聚合广告插件(迁移至GTAds)|[flutter_universalad](https://github.com/gstory0404/flutter_universalad)|
|GTAds聚合广告|[GTAds](https://github.com/gstory0404/GTAds)|
|字节穿山甲内容输出插件|[flutter_pangrowth](https://github.com/gstory0404/flutter_pangrowth)|
|文档预览插件|[file_preview](https://github.com/gstory0404/file_preview)|
|滤镜|[gpu_image](https://github.com/gstory0404/gpu_image)|

### 开源不易，觉得有用的话可以请作者喝杯奶茶🧋
<img src="https://github.com/gstory0404/flutter_pangrowth/blob/master/images/weixin.jpg" width = "200" height = "160" alt="打赏"/>

## 联系方式
* Email: gstory0404@gmail.com
* Blog：https://www.gstory.cn/



