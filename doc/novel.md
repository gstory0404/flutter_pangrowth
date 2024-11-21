#### 1、SDK初始化

穿山甲广告初始化
```dart
await FlutterPangrowth.registerAd(
      androidAppId: "645479",
      iosAppId: "645479",
    );
```

短小说初始化
```dart
await PangrowthNovel.registerNovel();
```

#### 2、打开小说聚合页

```dart
await PangrowthNovel.openNovelAggregatePage(
  adCode: "961597868",
);
```

#### 3、NovelEntity说明
```dart
/// [bookId] 短故事ID
/// [title] 短故事名
/// [desc] 简介
/// [author] 小说作者
/// [coverImage] 短故事的封面
/// [categoryId] 类目id
/// [categoryName] 类目名称
/// [total] 总共章数
/// [createTime] 上线时间
/// [index] 当前集数
/// [progress] 本章阅读进度
/// [statsCount] 用户阅读次数
/// [favoriteState] 1表示已收藏，非1表示未收藏
/// [favoriteTime] 收藏时间，单位秒
/// [coverType] 0:短故事封面，1:默认图，2:无图
/// [contentTruncation] 第一章前300个字
/// [data] 原始数据
NovelEntity()

```

#### 4、搜索小说
```dart
List<NovelEntity> novels = await PangrowthNovel.requestStoryListWithSearchWord(
    keyword: value, isFuzzy: true, page: 1, size: 30)
```

#### 5、根据ids查询短小说
```dart
List<NovelEntity> novels = await PangrowthNovel.requestStoryListWithBookId(ids: ["6331","8178"]);
```

#### 6、短小说分页加载
```dart
List<NovelEntity> novels = await PangrowthNovel.requestAllStoryListPage(
  page: 1,
  size: 30,
  order: 1,
);
```

#### 7、短小说阅读记录
```dart
List<NovelEntity> novels = await PangrowthNovel.requestHistoryStoryList(page: 1,size: 30);
```

#### 8、短小说分类
单位：毫秒
```dart
List<String> categorys = await PangrowthNovel.requestNovelCategoryList();
```

#### 9、根据分类获取列表
```dart
List<NovelEntity> novels= await  PangrowthNovel.requestCategoryStoryListWithCategoryId(
categoryId: widget.id, page: 1, size: 30, order: 1);
```

#### 10、短小说收藏列表
```dart
List<NovelEntity> novels = PangrowthNovel.requestStoryCollectionList(page: 1,size: 30);
```


#### 11、小说收藏
```dart
PangrowthNovel.requestCollectStory(novelId: 11);
```

#### 12、小说取消收藏
```dart
PangrowthNovel.requestCancelCollectStory(novelId: 11);
```

#### 13、进入小说阅读器
```dart
PangrowthPlaylet.openMiniStory(novelId: 100,index: 1,adCode: "961597868");
```