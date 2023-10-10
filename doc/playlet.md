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

#### 2、打开短剧聚合页（封装方式）
```dart
await PangrowthPlaylet.openPlayletAggregatePage(
  //免费观看的集数 默认3
  freeCount: 5,
  // 观看一次激励视频解锁的集数 默认1
  unlockCountUsingAD: 2,
  //是否展示导航栏标题名称 默认true
  isShowTitle: true,
  //是否展示导航栏左上角返回按钮 默认true
  isShowBackButton: true,
);
```

#### 3、打开短剧混排页面（封装方式）
```dart
await PangrowthPlaylet.openPlayletDrawVideoPage(
  // 免费观看的集数 默认3
  freeCount: 5,
  // 观看一次激励视频解锁的集数 默认1
  unlockCountUsingAD: 2,
  //是否展示导航栏标题名称 默认true
  isShowTitle: false,
  //是否展示导航栏左上角返回按钮 默认true
  isShowBackButton: true,
  //是否短视频、短剧混排 默认true
  isVideoPlaylet: true,
  // 短剧混排流中的免费短剧集数，默认3
  playletFreeCount: 5,
  // 短剧混排流中要第一部展现的短剧id 默认0
  topSkitId: 0,
);
```

#### 3、短剧卡片
```dart
PlayletCardView(
  //宽 (根据宽返回 高:宽`为`16:9` 的视频，加载完成后插件会自动适配原生返回视频大小，这里高度可能会与设置的height不一致)
  width: 400,
  //高
  height: 200,
  //是否自动播放，默认true
  autoPlay: true,
  //是否是否循环播放播放，默认true
  loop: true,
  //是否静音，默认true
  mute: true,
)
```