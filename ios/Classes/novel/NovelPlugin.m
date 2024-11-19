//
//  PlayletPlugin.m
//  flutter_pangrowth
//
//  Created by gstory on 2023/10/10.
//

#import "NovelPlugin.h"
#import "MJExtension/MJExtension.h"
#import "UIViewController+getCurrentVC.h"
#import <PangrowthMiniStory/MNStoryManager.h>
#import <PangrowthMiniStory/MNConfig.h>
#import <PangrowthMiniStory/MNManager.h>
#import <PangrowthMiniStory/MNSMainViewController.h>
//#import <PangrowthMiniStory/MNStoryCategoryListItemModel.h>
#import <PangrowthMiniStory/MNStoryInfoModel.h>

@implementation NovelPlugin

# pragma mark - 初始化短小说
+(void)registerNovel:(NSDictionary *)dic result:(FlutterResult)result{
    // 请使用您的配置文件(例如SDK_Setting_5151488.json)初始化SDK，并确保配置文件已经作为Copy Bundle Resource引入工程
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"pangrowthconfig" ofType:@"json"];
    // 数据配置，可在app初始化时调用
    MNConfig *config = [MNConfig new];
    [MNManager initializeWithConfigPath:configPath config:config];
    // 正在初始化，可在进入实际场景前使用
    [MNManager startWithCompleteHandler:^(BOOL isSuccess, NSDictionary * _Nonnull userInfo) {
        if (isSuccess == YES) {
            NSLog(@"初始化注册成功！");
            result(@YES);
        } else {
            NSLog(@"%@", userInfo[@"msg"]);
            result(@NO);
        }
    }];
}

# pragma mark - 打开短小说聚合页
+(void)openNovelAggregatePage:(NSDictionary *)dic result:(FlutterResult)result{
    NSDictionary *arguments = dic;
    MNStoryReaderOpenParams *params = [[MNStoryReaderOpenParams alloc] init];
    params.customRewardAD = NO;//是否自定义激励解锁，默认为SDK直出，开发者也可以参照阅读器模块说明，进行自定义广告
    params.addCustomRewardPoint = NO;//是否增加自定义解锁点
    params.showCustomBottomBannerAD = YES;//是否加入banner广告
    params.showCustomMiddleAD = YES;//是否加入章间广告
    params.pageIntervalForMiddleAD = 4;//插入章间广告的间隔数，章头章末不插入
    params.customRewardEntryView = NO;//是否自定义激励入口
    MNSMainViewController *vc = [[MNSMainViewController alloc] initWithReadConfig:params];
    [[UIViewController jsd_getRootViewController] presentViewController:vc animated:YES completion:^{}];
}

# pragma mark - 打开短故事阅读器
+(void)openMiniStory:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger novelId = [dic[@"novelId"] intValue];
    NSInteger index = [dic[@"index"] intValue];
    NSInteger pageIntervalForMiddleAD = [dic[@"pageIntervalForMiddleAD"] intValue];
    MNStoryReaderOpenParams *params = [[MNStoryReaderOpenParams alloc] init];
    params.storyId = novelId;
    params.chapterIndex = index;
    params.customRewardAD = NO;
    params.addCustomRewardPoint = NO;
    params.showCustomBottomBannerAD = YES;
    params.showCustomMiddleAD = YES;
    params.pageIntervalForMiddleAD = pageIntervalForMiddleAD;
    params.customRewardEntryView = NO;
    [[MNStoryManager shareInstance] openMiniStory:params];
}

# pragma mark - 查询短故事类目列表
+(void)requestNovelCategoryList:(NSDictionary *)dic result:(FlutterResult)result{
    [[MNStoryManager shareInstance] requestCategoryList:^(BOOL success, NSArray<MNStoryCategoryListItemModel *> * _Nonnull categoryList) {
        if(success){
            NSMutableArray *stringArray = [NSMutableArray array];
//            for (MNStoryCategoryListItemModel *model in categoryList) {
//                [stringArray addObject:[model mj_JSONString]];
//            }
            result(stringArray);
        }else{
            result(nil);
        }
    }];
}

# pragma mark - 短故事搜素
+(void)requestStoryListWithSearchWord:(NSDictionary *)dic result:(FlutterResult)result{
    NSString *keyword = dic[@"keyword"];
    BOOL isFuzzy = [dic[@"isFuzzy"] boolValue];
    NSInteger page = [dic[@"page"] intValue];
    NSInteger size = [dic[@"size"] intValue];
    [[MNStoryManager shareInstance] requestStoryListWithSearchWord:keyword isFuzzy:isFuzzy page:page num:size completion:^(BOOL success, NSArray<MNStoryInfoModel *> * _Nonnull storyList, BOOL hasMore) {
        if(success){
            NSMutableArray *stringArray = [NSMutableArray array];
            for (MNStoryInfoModel *model in storyList) {
                [stringArray addObject:[model mj_JSONString]];
            }
            result(stringArray);
        }else{
            result(nil);
        }
    }];
}

# pragma mark - 短故事按照book_id查询
+(void)requestStoryListWithBookId:(NSDictionary *)dic result:(FlutterResult)result{
    NSArray* idList = dic[@"ids"];
    [[MNStoryManager shareInstance] requestStoryListWithBookId:idList completion:^(BOOL success, NSArray<MNStoryInfoModel *> * _Nonnull storyList) {
        if(success){
            NSMutableArray *stringArray = [NSMutableArray array];
            for (MNStoryInfoModel *model in storyList) {
                [stringArray addObject:[model mj_JSONString]];
            }
            result(stringArray);
        }else{
            result(nil);
        }
    }];
}

# pragma mark - 查询所有短故事
+(void)requestAllStoryListPage:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger page = [dic[@"page"] intValue];
    NSInteger size = [dic[@"size"] intValue];
    NSInteger order = [dic[@"order"] intValue];
    [[MNStoryManager shareInstance] requestAllStoryListPage:page num:size order:order completion:^(BOOL success, NSArray<MNStoryInfoModel *> * _Nonnull storyList, NSDictionary<NSString *,NSObject *> * _Nonnull totalDict, BOOL hasMore) {
        if(success){
            NSMutableArray *stringArray = [NSMutableArray array];
            for (MNStoryInfoModel *model in storyList) {
                [stringArray addObject:[model mj_JSONString]];
            }
            result(stringArray);
        }else{
            result(nil);
        }
    }];
}

# pragma mark - 根据排序方式，查询短故事列表
+(void)requestAllStoryListWithOrder:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger order = [dic[@"order"] intValue];
    [[MNStoryManager shareInstance] requestAllStoryListWithOrder:order completion:^(BOOL success, NSArray<MNStoryInfoModel *> * _Nonnull storyList, NSDictionary<NSString *,NSObject *> * _Nonnull totalDict) {
        if(success){
            NSMutableArray *stringArray = [NSMutableArray array];
            for (MNStoryInfoModel *model in storyList) {
                [stringArray addObject:[model mj_JSONString]];
            }
            result(stringArray);
        }else{
            result(nil);
        }
    }];
}

# pragma mark - 根据类目id查询短故事列表
+(void)requestCategoryStoryListWithCategoryId:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger categoryId = [dic[@"categoryId"] intValue];
    NSInteger page = [dic[@"page"] intValue];
    NSInteger size = [dic[@"size"] intValue];
    NSInteger order = [dic[@"order"] intValue];
    [[MNStoryManager shareInstance] requestCategoryStoryListWithCategoryId:categoryId page:page num:size order:order completion:^(BOOL success, NSArray<MNStoryInfoModel *> * _Nonnull storyList) {
        if(success){
            NSMutableArray *stringArray = [NSMutableArray array];
            for (MNStoryInfoModel *model in storyList) {
                [stringArray addObject:[model mj_JSONString]];
            }
            result(stringArray);
        }else{
            result(nil);
        }
    }];
}

# pragma mark - 查询历史记录列表
+(void)requestHistoryStoryList:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger page = [dic[@"page"] intValue];
    NSInteger size = [dic[@"size"] intValue];
    [[MNStoryManager shareInstance] requestHistoryStoryList:page num:size completion:^(BOOL success, NSArray<MNStoryInfoModel *> * _Nonnull storyList) {
        if(success){
            NSMutableArray *stringArray = [NSMutableArray array];
            for (MNStoryInfoModel *model in storyList) {
                [stringArray addObject:[model mj_JSONString]];
            }
            result(stringArray);
        }else{
            result(nil);
        }
    }];
}

# pragma mark - 收藏短故事
+(void)requestCollectStory:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger novelId = [dic[@"novelId"] intValue];
    [[MNStoryManager shareInstance] requestCollectStory:novelId completeHandler:^(NSError * _Nullable error) {
        result(@YES);
    }];
}

# pragma mark - 取消收藏短故事
+(void)requestCancelCollectStory:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger novelId = [dic[@"novelId"] intValue];
    [[MNStoryManager shareInstance] requestCancelCollectStory:novelId completeHandler:^(NSError * _Nullable error) {
        result(@YES);
    }];
}

# pragma mark - 获取短故事的收藏列表
+(void)requestStoryCollectionList:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger page = [dic[@"page"] intValue];
    NSInteger size = [dic[@"size"] intValue];
    [[MNStoryManager shareInstance] requestStoryCollectionList:page num:size completeHandler:^(BOOL success, NSArray<MNStoryInfoModel *> * _Nonnull storyList, NSDictionary<NSString *,NSObject *> * _Nonnull totalDict, BOOL hasMore) {
        if(success){
            NSMutableArray *stringArray = [NSMutableArray array];
            for (MNStoryInfoModel *model in storyList) {
                [stringArray addObject:[model mj_JSONString]];
            }
            result(stringArray);
        }else{
            result(nil);
        }
    }];
}

@end
