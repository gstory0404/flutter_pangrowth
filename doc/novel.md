#### 1、SDK初始化

⚠️注意 ：初始化sdk前，必须先调用用[flutter_unionad](https://github.com/gstory0404/flutter_unionad)的初始化方法，不然无法加载广告

```dart
await PangrowthNovel.registerNovel(
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
        //是否个性化推送广告
        personalRecommendAd: true,
        //是否个性化推送小说内容
        personalRecommendContent: true,
        //全局字号大小
        normalFontType: NormalFontSize.normal,
        //阅读字号大小
        readFontType: ReadFontSize.two,
    );
```

#### 2、打开小说主页

```dart
await PangrowthNovel.openNovelPage();
```

#### 3、NovelEntity说明
```dart
{
    "code": true,//true获取成功 false获取失败
    "msg": "",//错误提示
    "data": [//返回小说数组
        {
            "type":1,//来源类型，小说跳转时使用
            "readUrl": "",//阅读地址
            "bookName": "",//小说名字
            "thumbUrl": "",//小说封面
            "novelDetail": ""//小说具体信息json（由于android、ios数据格式、后续跳转所需参数等都不相同，所以不做处理直接返回json数据，开发者可根据需求在项目中自行解析）
        }
    ]
}

```

#### 4、获取阅读历史
```dart
NovelEntity novel = await PangrowthNovel.getNovelHistory();
```

#### 5、获取启动推荐书籍列表
```dart
NovelEntity novel = await PangrowthNovel.getNovelRecommendV1(
          size: 10,//返回数据数量
        )
```

#### 6、获取Feed推荐书籍列表
```dart
NovelEntity novel = await PangrowthNovel.getNovelRecommendFeed(
          size: 10,//返回数据数量
        )
```

#### 7、小说显示上报
当获取了用户的阅读历史信息，展示的时候务必上报
当用户点击了阅读历史信息，务必上报
```dart
await PangrowthNovel.reportRecentNovelShow(
         type: result.type,//NovelEntity 中type字段
         book: result.novelDetail,//NovelEntity 中novelDetail字段
);
```

#### 8、打开小说页面
主要getNovelHistory、getNovelRecommendV1、getNovelRecommendFeed返回NovelEntity跳转
```dart
await PangrowthNovel.openNovelPageWithConfig(
  type: result.type,//NovelEntity 中type字段
  book: result.novelDetail,//NovelEntity 中novelDetail字段
);
```

#### 9、获取当日阅读时长
单位：毫秒
```dart
int _duration = await PangrowthNovel.getReadDuration();
```

#### 10、获取搜索Suggestion
```dart
NovelEntity novel = await PangrowthNovel.searchNovelSuggestions(
          queryContent: query,//搜索关键字
          offset: 1,//页码
          limit: 20,//单次数量
)
```

#### 11、获取搜索Results
```dart
NovelEntity novel = await PangrowthNovel.searchNovelResults(
          queryContent: query,//搜索关键字
          offset: 1,//页码
          limit: 20,//单次数量
)
```
#### 12、根据url跳转小说页面
主要searchNovelSuggestions、searchNovelResults返回NovelEntity跳转
```dart
await PangrowthNovel.openNovelPageWithUrl(url: result.readUrl,//NovelEntity中readUrl
  );
```

#### 14、小说导流入口控件
```dart
PangrowthNovel.novelEntranceView(
                viewWidth: 50,//宽
                viewHeight: 50,//高
                type: FlutterNovelEntranceType.icon,//类型
                style: FlutterNovelIconSytle.circle,//类型下对应样式
              ),
```
```dart
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
```