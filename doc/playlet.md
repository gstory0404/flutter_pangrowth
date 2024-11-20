#### 1、SDK初始化

穿山甲广告初始化
```dart
await FlutterPangrowth.registerAd(
      androidAppId: "645479",
      iosAppId: "645479",
    );
```

短剧初始化
```dart
await PangrowthPlaylet.registerPlaylet();
```

#### 2、打开短剧聚合页
```dart
await PangrowthPlaylet.openPlayletAggregatePage(
// 免费观看的集数 默认3
freeCount: 10,
// 观看一次激励视频解锁的集数 默认1
unlockCountUsingAD: 2,
//是否展示导航栏标题名称 默认true
isShowTitle: true,
//是否展示导航栏左上角返回按钮 默认true
isShowBackButton: true,
);
```

#### 3、PlayletEntity
```dart
  /// [playletId] 短剧ID
  /// [title]短剧名
  /// [coverImage] 短剧的封面
  /// [status] 短剧状态 1表示未完结
  /// [total] 共多少集
  /// [desc] 简介
  /// [categoryId] 分类id
  /// [categoryName]/ 分类名称
  /// [sourceNovelName] 短剧对应的小说名
  /// [sourceNovelAuthor] 小说作者
  /// [videoDuration] 时长
  /// [currentEpisode] 播放到第几集
  /// [groupId] 播放到的剧集gid
  /// [channelId] 推荐模块id
  /// [nextSkitId] 下一步短剧的id
  /// [createTime] 上线时间
  /// [actionTime] 观看时间
  /// [unlockIndex] 解锁集数
  /// [icpNumber] 备案号
  /// [favoriteState]
  /// [favoriteTime]
  /// [favoriteCount]
  /// [likeState]
  /// [likeTime]
  /// [likeCount]
  /// [levelLabel] 等级标签 "1:S|2:A|3:B"
  /// [isPotential] 是否潜力剧
  /// [data] 原始数据
PlayletEntity()
```

#### 4、短剧分页加载
```dart
List<PlayletEntity> playlets = await PangrowthPlaylet.requestAllPlayletListPage(page: 1, size: 30, order: 1);
```

#### 5、推荐短剧
```dart
List<PlayletEntity> playlets = await PangrowthPlaylet.requestRecommendedPlayletListPage(
page: 1,
size: 30,
);
```

#### 6、根据id获取短剧
List<PlayletEntity> playlets = await PangrowthPlaylet.requestPlayletListWithPlayletId(ids: ["17916","17917"]);
```dart
```

#### 7、短剧搜索
```dart
List<PlayletEntity> playlets = await PangrowthPlaylet.requestCategoryPlayletLisWithSearchWord(
                          keyword: value, isFuzzy: true, page: 1, size: 30)
```

#### 8、短剧分类
```dart
List<String> categorys = await PangrowthPlaylet.requestPlayletCategoryList();
```

#### 9、根据分类获取列表
```dart
List<PlayletEntity> playlets = await PangrowthPlaylet.requestCategoryPlayletLisWithCategory(category:widget.category,page:1,size:30)
```

#### 10、短剧播放记录
```dart
List<PlayletEntity> playlets = await PangrowthPlaylet.requestPlayletHistoryListWithPage(page: 1, size: 30);
```

#### 11、短剧收藏列表
```dart
List<PlayletEntity> playlets = await PangrowthPlaylet.requestCollectionList(page: 1, size: 30)
```

#### 12、短剧收藏
```dart
PangrowthPlaylet.collectShortplay(playletId: 100);
```

#### 13、短剧取消收藏
```dart
PangrowthPlaylet.cancelCollectShortplay(playletId: 100);
```

#### 14、短剧点赞
```dart
PangrowthPlaylet.likeShortplay(playletId: 100);
```

#### 14、短剧取消点赞
```dart
PangrowthPlaylet.cancelLikeShortplay(playletId: 100);
```


#### 15、进入短剧播放器`
```dart
PangrowthPlaylet.enterPlayletPlayer(playletId: 100,index: 1);
```