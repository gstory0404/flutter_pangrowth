//
//  VideoPlugin.m
//  flutter_pangrowth
//
//  Created by gstory on 2021/12/13.
//

#import "VideoPlugin.h"
#import "controller/GridVideoViewController.h"
#import "controller/DrawVideoViewController.h"
#import "controller/AccessUserCenterViewController.h"
#import "UIViewController+getCurrentVC.h"

@implementation VideoPlugin

# pragma mark - 初始化视频
+(void)registerVideo:(NSDictionary *)dic result:(FlutterResult)result{
    BOOL debug = [dic[@"debug"] boolValue];
    // 初始化LCDSDK
    LCDConfig *config = [LCDConfig new];
    config.logLevel = LCDSDKLogLevelDebug;
    // 请使用您的配置文件(例如SDK_Setting_5151488.json)初始化SDK，并确保配置文件已经作为Copy Bundle Resource引入工程
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"pangrowthconfig" ofType:@"json"];
    [LCDManager initializeWithConfigPath:configPath config:config];
    [LCDManager startWithCompleteHandler:^(LCDINITStatus initStatus, NSDictionary * _Nonnull userInfo) {
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
//    [[UIViewController jsd_getRootViewController] presentViewController:[[DrawVideoViewController alloc] init] animated:YES completion:^{}];
}

# pragma mark -  打开宫格小视频 全屏样式
+(void)openGridVideo{
    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
    [viewController pushViewController:[[GridVideoViewController alloc] init] animated:YES];
//    [[UIViewController jsd_getRootViewController] presentViewController:[[GridVideoViewController alloc] init] animated:YES completion:^{}];
}

# pragma mark - 打开个人主页
+(void)openUserCenter{
    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
    [viewController pushViewController:[[AccessUserCenterViewController alloc] init] animated:YES];
}

@end
