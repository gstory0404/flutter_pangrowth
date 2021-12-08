# 字节跳动内容合作 Flutter版本
<p>
<a href="https://pub.flutter-io.cn/packages/flutter_pangrowth"><img src=https://img.shields.io/badge/flutter_pangrowth-v0.0.1-success></a>
</p>

## 简介
flutter_pangrowth是一个可以帮助开发者直接引入穿山甲内容合作的插件。[体验demo](https://www.pgyer.com/sUQU)
目前仅支持小说。

## 说明

使用flutter_pangrowth插件，必须先接入穿山甲广告插件[flutter_unionad](https://github.com/gstory0404/flutter_unionad),不然无法显示广告

## 接入文档

* [Android](https://github.com/gstory0404/flutter_pangrowth/blob/master/Android.md)

* [ios](https://github.com/gstory0404/flutter_pangrowth/blob/master/IOS.md)

## 本地环境
```
[✓] Flutter (Channel stable, 2.5.0, on macOS 11.6 20G165 darwin-x64, locale zh-Hans-CN)
[✓] Android toolchain - develop for Android devices (Android SDK version 30.0.3)
[✓] Xcode - develop for iOS and macOS
[✓] Chrome - develop for the web
[✓] Android Studio (version 2020.3)
[✓] VS Code (version 1.60.1)
[✓] Connected device (4 available)
```

## 集成步骤
#### 1、pubspec.yaml
```Dart
flutter_pangrowth: ^0.0.1
//或者

```

#### 2、引入
```Dart
import 'package:flutter_pangrowth/flutter_pangrowth.dart';
```

## 使用

#### 1、SDK初始化

⚠️注意 ：初始化sdk前，必须先调用用[flutter_unionad](https://github.com/gstory0404/flutter_unionad)的初始化方法，不然无法加载广告

```dart
await FlutterPangrowth.registerNovel(
      //接入小说SDK的App的英文名 必填
      appName: "appName",
      ////接入小说SDKApp的版本名称 必填
      appVersionName: "1.0.0",
      //接入小说SDK App的版本号 必填
      appVersionCode: 1,
      //埋点上传时的渠道号维度。开发者自定义字符串即可(建议不要包含test)。选填
      channel: "test",
      ////appid 必填
      andoridAppId: "302043",
      iosAppId: "299886",
      //是否显示日志
      debug: true,
    );
```

#### 2、打开小说主页

```dart
await FlutterPangrowth.openNovelPage();
```

#### 3、NovelEntity说明
```dart
{
    "code": 0,//1成功 0失败
    "msg": "",//错误提示
    "data": [//返回小说数组
        {
            "bookId": "6806002909138914318",//小说id
            "bookName": "",//小说名字
            "readUrl": "",//阅读地址
            "thumbUrl": "",//小说封面
            "novelDetail": ""//小说具体信息json（由于android、ios数据格式、后续跳转所需参数等都不相同，所以不做处理直接返回json数据，开发者可根据需求在项目中自行解析）
        }
    ]
}

```

#### 4、获取阅读历史
```dart
NovelEntity novel = await FlutterPangrowth.getNovelHistory();
```

#### 5、获取启动推荐书籍列表
```dart
NovelEntity novel = await FlutterPangrowth.getNovelRecommendV1(
          size: 10,//返回数据数量
        )
```

#### 6、获取Feed推荐书籍列表
```dart
NovelEntity novel = await FlutterPangrowth.getNovelRecommendFeed(
          size: 10,//返回数据数量
        )
```

#### 7、小说显示上报
```dart
await FlutterPangrowth.reportRecentNovelShow(
         type: result.type,//NovelEntity 中type字段
         book: result.novelDetail,//NovelEntity 中novelDetail字段
);
```

#### 8、打开小说页面
```dart
await FlutterPangrowth.openNovelPageWithConfig(
  type: result.type,//NovelEntity 中type字段
  book: result.novelDetail,//NovelEntity 中novelDetail字段
);
```

#### 9、获取当日阅读时长
单位：毫秒
```dart
int _duration = await FlutterPangrowth.getReadDuration();
```

#### 10、获取搜索Suggestion
```dart
NovelEntity novel = await FlutterPangrowth.searchNovelSuggestions(
          queryContent: query,//搜索关键字
          offset: 1,//页码
          limit: 20,//单次数量
)
```

#### 11、获取搜索Results
```dart
NovelEntity novel = await FlutterPangrowth.searchNovelResults(
          queryContent: query,//搜索关键字
          offset: 1,//页码
          limit: 20,//单次数量
)
```

## 插件链接

|插件|地址|
|:----|:----|
|字节穿山甲广告插件|[flutter_unionad](https://github.com/gstory0404/flutter_unionad)|
|腾讯优量汇广告插件|[flutter_tencentad](https://github.com/gstory0404/flutter_tencentad)|
|聚合广告插件|[flutter_universalad](https://github.com/gstory0404/flutter_universalad)|
|百度百青藤广告插件|[flutter_baiduad](https://github.com/gstory0404/flutter_baiduad)|
|字节穿山甲内容合作插件|[flutter_pangrowth](https://github.com/gstory0404/flutter_pangrowth)|

## 联系方式
* Email: gstory0404@gmail.com
* Blog：https://gstory.vercel.app/

* QQ群: <a target="_blank" href="https://qm.qq.com/cgi-bin/qm/qr?k=4j2_yF1-pMl58y16zvLCFFT2HEmLf6vQ&jump_from=webapi"><img border="0" src="//pub.idqqimg.com/wpa/images/group.png" alt="649574038" title="flutter交流"></a>


