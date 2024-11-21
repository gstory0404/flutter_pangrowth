//
//  PlayletPlugin.m
//  flutter_pangrowth
//
//  Created by gstory on 2023/10/10.
//

#import "PlayletPlugin.h"
#import <PangrowthDJX/DJXSDK.h>
#import "MJExtension/MJExtension.h"
#import "UIViewController+getCurrentVC.h"
#import <PangrowthMiniStory/MNStoryManager.h>

@implementation PlayletPlugin

# pragma mark - 初始化视频
+(void)registerPlaylet:(NSDictionary *)dic result:(FlutterResult)result{
    // 请使用您的配置文件(例如SDK_Setting_5151488.json)初始化SDK，并确保配置文件已经作为Copy Bundle Resource引入工程
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"pangrowthconfig" ofType:@"json"];
    // 数据配置，可在app初始化时调用
    DJXConfig *config = [DJXConfig new];
    [DJXManager initializeWithConfigPath:configPath config:config];
    // 正在初始化，可在进入实际场景前使用
    [DJXManager startWithCompleteHandler:^(BOOL isSuccess, NSDictionary * _Nonnull userInfo) {
        if (isSuccess == YES) {
            NSLog(@"初始化注册成功！");
            result(@YES);
        } else {
            NSLog(@"%@", userInfo[@"msg"]);
            result(@NO);
        }
    }];
}

# pragma mark - 打开短剧聚合页
+(void)openPlayletAggregatePage:(NSDictionary*)arguments{
    NSDictionary *dic = arguments;
    NSLog(@"短剧聚合页%@",dic);
    NSInteger freeCount = [dic[@"freeCount"] intValue];
    NSInteger unlockCount = [dic[@"unlockCount"] intValue];
    BOOL isShowTitle = [dic[@"isShowTitle"] boolValue];
    BOOL isShowBackButton = [dic[@"isShowBackButton"] boolValue];
    DJXPlayletAggregatePageViewController *vc = [[DJXPlayletAggregatePageViewController alloc] initWithConfigBuilder:^(DJXPlayletAggregatePageVCConfig * _Nonnull config) {
        DJXPlayletConfig *playletConfig = [DJXPlayletConfig new];
        //免费观看的集数n
        playletConfig.freeEpisodesCount = freeCount;
        //观看一次激励视频解锁的集数m
        playletConfig.unlockEpisodesCountUsingAD = unlockCount;
        //接入模式 封装模式
        playletConfig.playletUnlockADMode = DJXPlayletUnlockADMode_Common;
        config.playletConfig = playletConfig;
        // 是否展示导航栏标题名称
        config.isShowNavigationItemTitle = isShowTitle;
        // 是否展示导航栏左上角返回按钮
        config.isShowNavigationItemBackButton = isShowBackButton;
    }];
//    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
//    [viewController pushViewController:vc animated:YES];
    [[UIViewController jsd_getRootViewController] presentViewController:vc animated:YES completion:^{}];
}

# pragma mark - 分页拉取所有短剧
+(void)requestAllPlayletListPage:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger page = [dic[@"page"] intValue];
    NSInteger size = [dic[@"size"] intValue];
    NSInteger order = [dic[@"order"] intValue];
    [[DJXPlayletManager shareInstance] requestAllPlayletListPage:page num:size order:order success:^(NSArray<DJXPlayletInfoModel *> * _Nonnull playletList, NSDictionary<NSString *,NSObject *> * _Nonnull info) {
        NSMutableArray *stringArray = [NSMutableArray array];
        for (DJXPlayletInfoModel *model in playletList) {
            [stringArray addObject:[model mj_JSONString]];
        }
        result(stringArray);
    } failure:^(NSError * _Nonnull error) {
        result(nil);
    }];
    
    
}

# pragma mark - 短剧推荐列表
+(void)requestRecommendedPlayletListPage:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger page = [dic[@"page"] intValue];
    NSInteger size = [dic[@"size"] intValue];
    [[DJXPlayletManager shareInstance] requestRecommendedPlayletListPage:page num:size success:^(NSArray<DJXPlayletInfoModel *> * _Nonnull playletList, NSDictionary<NSString *,NSObject *> * _Nonnull info) {
        NSMutableArray *stringArray = [NSMutableArray array];
        for (DJXPlayletInfoModel *model in playletList) {
            [stringArray addObject:[model mj_JSONString]];
        }
        result(stringArray);
    } failure:^(NSError * _Nonnull error) {
        result(nil);
    }];
}

# pragma mark - 短剧全部列表
+(void)requestAllPlayletListWithOrder:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger order = [dic[@"order"] intValue];
    [[DJXPlayletManager shareInstance] requestAllPlayletListWithOrder: order success:^(NSArray<DJXPlayletInfoModel *> * _Nonnull playletList, NSDictionary<NSString *,NSObject *> * _Nonnull info) {
        NSMutableArray *stringArray = [NSMutableArray array];
        for (DJXPlayletInfoModel *model in playletList) {
            [stringArray addObject:[model mj_JSONString]];
        }
        result(stringArray);
    } failure:^(NSError * _Nonnull error) {
        result(nil);
    }];
}

# pragma mark - 短剧列表(根据短剧id获取)
+(void)requestPlayletListWithPlayletId:(NSDictionary *)dic result:(FlutterResult)result{
    NSArray* idList = dic[@"ids"];
    [[DJXPlayletManager shareInstance] requestPlayletListWithPlayletId:idList success:^(NSArray<DJXPlayletInfoModel *> * _Nonnull playletList) {
        NSMutableArray *stringArray = [NSMutableArray array];
        for (DJXPlayletInfoModel *model in playletList) {
            [stringArray addObject:[model mj_JSONString]];
        }
        result(stringArray);
    } failure:^(NSError * _Nonnull error) {
        result(nil);
    }];
    
}

# pragma mark - 根据搜索关键词获取列表
+(void)requestCategoryPlayletLisWithSearchWord:(NSDictionary *)dic result:(FlutterResult)result{
    NSString *keyword = dic[@"keyword"];
    BOOL isFuzzy = [dic[@"isFuzzy"] boolValue];
    NSInteger page = [dic[@"page"] intValue];
    NSInteger size = [dic[@"size"] intValue];
    [[DJXPlayletManager shareInstance] requestCategoryPlayletLisWithSearchWord:keyword isFuzzy:isFuzzy page:page num:size success:^(NSArray<DJXPlayletInfoModel *> * _Nonnull playletList, BOOL hasMore) {
        NSMutableArray *stringArray = [NSMutableArray array];
        for (DJXPlayletInfoModel *model in playletList) {
            [stringArray addObject:[model mj_JSONString]];
        }
        result(stringArray);
    } failure:^(NSError * _Nonnull error) {
        result(nil);
    }];
}

# pragma mark - 短剧分类列表
+(void)requestCategoryList:(NSDictionary *)dic result:(FlutterResult)result{
    [[DJXPlayletManager shareInstance] requestCategoryList:^(NSArray<NSString *> * _Nonnull categoryList) {
        NSMutableArray *stringArray = [NSMutableArray array];
        for (NSString *category in categoryList) {
            [stringArray addObject:category];
        }
        result(categoryList);
    } failure:^(NSError * _Nonnull error) {
        result(nil);
    }];
}

# pragma mark - 根据分类获取列表
+(void)requestCategoryPlayletLisWithCategory:(NSDictionary *)dic result:(FlutterResult)result{
    NSString *category = dic[@"category"];
    NSInteger page = [dic[@"page"] intValue];
    NSInteger size = [dic[@"size"] intValue];
    [[DJXPlayletManager shareInstance] requestCategoryPlayletLisWithCategory:category page:page num:size success:^(NSArray<DJXPlayletInfoModel *> * _Nonnull playletList) {
        NSMutableArray *stringArray = [NSMutableArray array];
        for (DJXPlayletInfoModel *model in playletList) {
            [stringArray addObject:[model mj_JSONString]];
        }
        result(stringArray);
    } failure:^(NSError * _Nonnull error) {
        result(nil);
    }];
}

# pragma mark - 进入播放页
+(void)enterPlayletPlayer:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger playletId = [dic[@"playletId"] intValue];
    NSInteger index = [dic[@"index"] intValue];
    DJXPlayletConfig *config = [DJXPlayletConfig new];
    config.skitId = playletId;
    config.episode = index;
    config.playletUnlockADMode = DJXPlayletUnlockADMode_Common;
    DJXDrawVideoViewController *vc = [[DJXPlayletManager shareInstance] playletViewControllerWithParams:config];
//    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
//    [viewController pushViewController:vc animated:YES];
    [[UIViewController jsd_getRootViewController] presentViewController:vc animated:YES completion:^{}];
    result(@YES);
}

# pragma mark - 短剧历史记录列表
+(void)requestPlayletHistoryListWithPage:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger page = [dic[@"page"] intValue];
    NSInteger size = [dic[@"size"] intValue];
    [[DJXPlayletManager shareInstance] requestPlayletHistoryListWithPage:page num:size success:^(NSArray<DJXPlayletInfoModel *> * _Nonnull playletList) {
        NSMutableArray *stringArray = [NSMutableArray array];
        for (DJXPlayletInfoModel *model in playletList) {
            [stringArray addObject:[model mj_JSONString]];
        }
        result(stringArray);
    } failure:^(NSError * _Nonnull error) {
        result(nil);
    }];
}

# pragma mark - 短剧历史记录清除
+(void)requestPlayletHistoryCleanWithCompletion:(NSDictionary *)dic result:(FlutterResult)result{
    [[DJXPlayletManager shareInstance] requestPlayletHistoryCleanWithCompletion:^{
        result(@YES);
    } failure:^(NSError * _Nonnull error) {
        result(@NO);
    }];
}

# pragma mark - 点赞某一集短剧
+(void)likeShortplay:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger playletId = [dic[@"playletId"] intValue];
    NSInteger index = [dic[@"index"] intValue];
    [[DJXPlayletManager shareInstance] likeShortplay:playletId episode_index:index success:^{
        result(@YES);
    } failure:^(NSError * _Nonnull error) {
        result(@NO);
    }];
}

# pragma mark - 取消点赞某一集短剧
+(void)cancelLikeShortplay:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger playletId = [dic[@"playletId"] intValue];
    NSInteger index = [dic[@"index"] intValue];
    [[DJXPlayletManager shareInstance] cancelLikeShortplay:playletId episode_index:index success:^{
        result(@YES);
    } failure:^(NSError * _Nonnull error) {
        result(@NO);
    }];
}

# pragma mark - 收藏某部剧
+(void)collectShortplay:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger playletId = [dic[@"playletId"] intValue];
    [[DJXPlayletManager shareInstance] collectShortplay:playletId success:^{
        result(@YES);
    } failure:^(NSError * _Nonnull error) {
        result(@NO);
    }];
}

# pragma mark - 取消收藏某部剧
+(void)cancelCollectShortplay:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger playletId = [dic[@"playletId"] intValue];
    [[DJXPlayletManager shareInstance] cancelCollectShortplay:playletId success:^{
        result(@YES);
    } failure:^(NSError * _Nonnull error) {
        result(@NO);
    }];
}

# pragma mark - 短剧收藏列表
+(void)requestCollectionList:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger page = [dic[@"page"] intValue];
    NSInteger size = [dic[@"size"] intValue];
    [[DJXPlayletManager shareInstance] requestCollectionList:page pageSize:size success:^(NSArray<DJXPlayletInfoModel *> * _Nonnull playletList, BOOL hasMore) {
        NSMutableArray *stringArray = [NSMutableArray array];
        for (DJXPlayletInfoModel *model in playletList) {
            [stringArray addObject:[model mj_JSONString]];
        }
        result(stringArray);
    } failure:^(NSError * _Nonnull error) {
        result(nil);
    }];
}


@end
