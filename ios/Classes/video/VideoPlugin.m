//
//  VideoPlugin.m
//  flutter_pangrowth
//
//  Created by gstory on 2021/12/13.
//

#import "VideoPlugin.h"
#import "controller/GridVideoViewController.h"
#import "controller/DrawVideoViewController.h"
#import "controller/FeedExploreViewController.h"
#import "controller/SingleFeedViewController.h"
#import "controller/AccessUserCenterViewController.h"

@implementation VideoPlugin

# pragma mark - 初始化视频
+(void)registerVideo:(NSDictionary *)dic result:(FlutterResult)result{
    BOOL debug = [dic[@"debug"] boolValue];
    // 初始化LCDSDK
    LCDConfig *config = [LCDConfig new];
    config.logLevel = LCDSDKLogLevelDebug;
    // 请使用您的配置文件(例如SDK_Setting_5151488.json)初始化SDK，并确保配置文件已经作为Copy Bundle Resource引入工程
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"pangrowthconfig" ofType:@"json"];
    [LCDManager startWithConfigPath:configPath config:config completion:^(LCDINITStatus initStatus, NSDictionary * _Nonnull userInfo) {
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
    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
    [viewController pushViewController:[[DrawVideoViewController alloc] init] animated:YES];
}

# pragma mark -  打开宫格小视频 全屏样式
+(void)openGridVideo{
    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
    [viewController pushViewController:[[GridVideoViewController alloc] init] animated:YES];
}

# pragma mark - 打开新闻 多列表 全屏样式
+(void)openNewsTabs{
    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
    [viewController pushViewController:[[FeedExploreViewController alloc] init] animated:YES];
}

# pragma mark - 打开新闻 单列表 全屏样式
+(void)openNewsTabOne{
    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
    [viewController pushViewController:[[SingleFeedViewController alloc] init] animated:YES];
}


# pragma mark - 打开个人主页
+(void)openUserCenter{
    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
    [viewController pushViewController:[[AccessUserCenterViewController alloc] init] animated:YES];
}

# pragma mark - 信息流数据获取
+(void)getFeedNativeData:(NSDictionary *)dic result:(FlutterResult)result{
    [LCDFeedNativeLoadManager loadNativeModelsWithCategory:@"__all__" completion:^(NSArray<LCDNativeDataModel *> * _Nullable nativeModels, NSDictionary * _Nullable extra, NSError * _Nullable error) {
        NSLog(@"%@",nativeModels);
    }];
}

@end
