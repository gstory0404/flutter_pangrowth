#### 1、SDK初始化

⚠️注意 ：初始化sdk前，必须先调用用[flutter_unionad](https://github.com/gstory0404/flutter_unionad)的初始化方法，不然无法加载广告

```dart
await PangrowthVideo.registerVideo(
      //接入小说SDK的App的英文名 必填
      appName: "appName",
      ////appid 必填
      andoridAppId: "302043",
      iosAppId: "299886",
      //是否显示日志
      debug: true,
    );
```

#### 2、打开沉浸式小视频
```dart
await PangrowthVideo.openDrawVideoFull();
```

#### 3、打开宫格小视频
```dart
await PangrowthVideo.openGridVideo();
```

#### 6、沉浸小视频view
⚠️只支持ios
```dart
PangrowthVideo.drawVideoFullView(
        viewWidth: MediaQuery.of(context).size.width,//宽
        viewHeight: 700,//高
      ),
```

#### 7、宫格小视频view
⚠️只支持ios
```dart
PangrowthVideo.gridVideoView(
        viewWidth: MediaQuery.of(context).size.width,//宽
        viewHeight: 700,//高
      ),
```

#### 8、新闻多列表view
⚠️只支持ios
```dart
PangrowthVideo.newsTabsView(
        viewWidth: MediaQuery.of(context).size.width,//宽
        viewHeight: 700,//高
      ),
```

#### 9、新闻单列表view
⚠️只支持ios
```dart
PangrowthVideo.newsTabOneView(
        viewWidth: MediaQuery.of(context).size.width,//宽
        viewHeight: 700,//高
      ),
```

#### 10、视频组件-Banner
```dart
PangrowthVideo.videoBannerView(
              viewWidth: 300,//宽
              viewHeight: 200,//高
            ),
```

#### 11、视频组件-文字链
```dart
PangrowthVideo.videoTextChainView(
              viewWidth: 300,//宽
              viewHeight: 200,//高
            ),
```

#### 12、视频组件-气泡
```dart
PangrowthVideo.videoBubbleView(
              viewWidth: 300,//宽
              viewHeight: 200,//高
            ),
```

#### 13、视频卡片-单视频
```dart
PangrowthVideo.videoSingleCardView(
              viewWidth: 300,//宽
              viewHeight: 200,//高
            ),
```

#### 14、视频卡片-单信息流
```dart
PangrowthVideo.videoNewsSingleCardView(
              viewWidth: 300,//宽
              viewHeight: 200,//高
            ),
```

#### 15、视频卡片-列表
```dart
PangrowthVideo.videoCardView(
              viewWidth: 400,//宽
              viewHeight: 200,//高
            ),

#### 16、打开个人主页
```dart
await PangrowthVideo.openUserCenter();
```
