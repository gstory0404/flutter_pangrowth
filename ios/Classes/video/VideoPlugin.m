//
//  VideoPlugin.m
//  flutter_pangrowth
//
//  Created by 郭维佳 on 2021/12/13.
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
//+(void)openDrawVideoFull{
//    LCDDrawVideoViewController *vc = [[LCDDrawVideoViewController alloc] init];
//    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
//    [viewController pushViewController:vc animated:YES];
//}

# pragma mark - 小视频宫格
+(void)openDrawVideoFull{
    LCDGridVideoViewController *vc = [[LCDGridVideoViewController alloc] init];
    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
    [viewController pushViewController:vc animated:YES];
}

@end
