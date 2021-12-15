//
//  VideoPlugin.m
//  flutter_pangrowth
//
//  Created by gstory on 2021/12/13.
//

#import "VideoPlugin.h"

@implementation VideoPlugin

# pragma mark - 初始化视频
+(void)registerVideo:(NSDictionary *)dic result:(FlutterResult)result{
    BOOL debug = [dic[@"debug"] boolValue];
    // 初始化LCDSDK
    LCDConfig *config = [LCDConfig new];
    config.logLevel = LCDSDKLogLevelDebug;
    // 请使用您的配置文件(例如SDK_Setting_5151488.json)初始化SDK，并确保配置文件已经作为Copy Bundle Resource引入工程
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"pangrowthconfig" ofType:@"json"];
    [LCDManager startWithConfigPath:configPath config:config completion:^(LCDINITStatus initStatus) {
        if (initStatus == LCDINITStatus_success) {
            NSLog(@"初始化注册成功！");
            result(@YES);
        } else {
            NSLog(@"初始化注册失败，请重新注册");
            result(@NO);
        }
    }];
}

# pragma mark - 打开沉浸式小视频场景展示：全屏样式
+(void)openDrawVideoFull{
    LCDDrawVideoViewController *vc = [[LCDDrawVideoViewController alloc] initWithConfigBuilder:^(LCDDrawVideoVCConfig * _Nonnull config) {
//        lcs_strongify(self)
        config.showCloseButton = YES;
//        config.out_bottomOffset = LCS_bottomHeight + 20;
//        config.delegate = self;
//        config.adDelegate = self;
        }];
//    LCDDrawVideoViewController *vc = [[LCDDrawVideoViewController alloc] init];
    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
    [viewController pushViewController:vc animated:YES];
}

# pragma mark -  打开宫格小视频 全屏样式
+(void)openGridVideo{
    LCDGridVideoViewController *vc = [[LCDGridVideoViewController alloc] initWithConfigBuilder:^(LCDGridVideoVCConfig * _Nonnull config) {
//        config.showCloseButton = YES;
    }];
    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
    [viewController pushViewController:vc animated:YES];
}

# pragma mark - 打开新闻 多列表 全屏样式
+(void)openNewsTabs{
    LCDFeedExploreViewController *vc = [[LCDFeedExploreViewController  alloc] init];
    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
    [viewController pushViewController:vc animated:YES];
}

# pragma mark - 打开新闻 单列表 全屏样式
+(void)openNewsTabOne{
    LCDSingleFeedViewController *vc = [[LCDSingleFeedViewController alloc] initWithConfigBuilder:^(LCDSingleFeedVCConfig * _Nonnull config) {
        config.category = @"__all__";
//        config.delegate = self;
//        config.adDelegate = self;
        config.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    }];

    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
    [viewController pushViewController:vc animated:YES];
}

# pragma mark - 信息流数据获取
+(void)getFeedNativeData:(NSDictionary *)dic result:(FlutterResult)result{
    [LCDFeedNativeLoadManager loadNativeModelsWithCategory:@"__all__" completion:^(NSArray<LCDNativeDataModel *> * _Nullable nativeModels, NSDictionary * _Nullable extra, NSError * _Nullable error) {
        NSLog(@"%@",nativeModels);
    }];
}

@end
