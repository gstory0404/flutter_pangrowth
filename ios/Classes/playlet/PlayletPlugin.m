//
//  PlayletPlugin.m
//  flutter_pangrowth
//
//  Created by gstory on 2023/10/10.
//

#import "PlayletPlugin.h"
#import "LCDSDK/LCDPlayletAggregatePageViewController.h"
#import "LCDSDK/LCDDrawVideoViewController.h"
#import "LCDSDK/LCDPlayletSearchViewController.h"

@implementation PlayletPlugin

# pragma mark - 打开短剧聚合页
+(void)openPlayletAggregatePage:(NSDictionary*)arguments{
    NSDictionary *dic = arguments;
    NSLog(@"短剧聚合页%@",dic);
    NSInteger freeCount = [dic[@"freeCount"] intValue];
    NSInteger unlockCountUsingAD = [dic[@"unlockCountUsingAD"] intValue];
    BOOL isShowTitle = [dic[@"isShowTitle"] boolValue];
    BOOL isShowBackButton = [dic[@"isShowBackButton"] boolValue];
    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
    LCDPlayletAggregatePageViewController *vc = [[LCDPlayletAggregatePageViewController alloc] initWithConfigBuilder:^(LCDPlayletAggregatePageVCConfig * _Nonnull config) {
        LCDPlayletConfig *playletConfig = [LCDPlayletConfig new];
        //免费观看的集数n
        playletConfig.freeEpisodesCount = freeCount;
        //观看一次激励视频解锁的集数m
        playletConfig.unlockEpisodesCountUsingAD = unlockCountUsingAD;
        //接入模式 封装模式
        playletConfig.playletMode = LCDPlayletModeOptions_Package;
        //入口信息
        playletConfig.entranceType = LCDPlayletEntranceTypeDefault;
        config.playletConfig = playletConfig;
        // 是否展示导航栏标题名称
        config.isShowNavigationItemTitle = isShowTitle;
        // 是否展示导航栏左上角返回按钮
        config.isShowNavigationItemBackButton = isShowBackButton;
    }];
    [viewController pushViewController:vc animated:YES];
}

# pragma mark - 打开短剧混排
+(void)openPlayletDrawVideoPage:(NSDictionary*)arguments{
    NSDictionary *dic = arguments;
    NSLog(@"短剧混排%@",dic);
    NSInteger freeCount = [dic[@"freeCount"] intValue];
    NSInteger unlockCountUsingAD = [dic[@"unlockCountUsingAD"] intValue];
    BOOL isShowTitle = [dic[@"isShowTitle"] boolValue];
    BOOL isShowBackButton = [dic[@"isShowBackButton"] boolValue];
    BOOL isVideoPlaylet = [dic[@"isVideoPlaylet"] boolValue];
    NSInteger playletFreeCount = [dic[@"playletFreeCount"] intValue];
    NSInteger topSkitId = [dic[@"topSkitId"] intValue];
    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
    LCDDrawVideoViewController *vc = [[LCDDrawVideoViewController alloc] initWithConfigBuilder:^(LCDDrawVideoVCConfig * _Nonnull config) {
        LCDPlayletConfig *playletConfig = [LCDPlayletConfig new];
        playletConfig.playletMode = LCDPlayletModeOptions_Package;
        //免费观看的集数n
        playletConfig.freeEpisodesCount = freeCount;
        //观看一次激励视频解锁的集数m
        playletConfig.unlockEpisodesCountUsingAD = unlockCountUsingAD;
        //入口信息
        playletConfig.entranceType = LCDPlayletEntranceTypeSkitMixed;
        config.playletConfig = playletConfig;
        //是否短视频、短剧混排
        config.drawVCTabOptions = (isVideoPlaylet ? LCDDrawVideoVCTabOptions_playlet_mixed : LCDDrawVideoVCTabOptions_playlet_feed) | LCDDrawVideoVCTabOptions_theater;
        // 是否展示导航栏标题名称
        config.shouldHideTabBarView =isShowTitle;
        //是否需要展示左上角的关闭按钮
        config.showCloseButton = isShowBackButton;
        // 短剧混排流中的免费短剧集数，默认为1集混排
        config.playletFreeCount = playletFreeCount;
        // 短剧混排流中要第一部展现的短剧id
        config.topSkitId = topSkitId;
    }];
    //    [vc setUserInformationsWithAge:[LCDSurveyUserAge indexSet] Gender:LCDSurveyUserGender.]
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [viewController presentViewController:vc animated:YES completion:^{}];
}

# pragma mark - 打开短剧搜索
+(void)openPlayletSearchPage:(NSDictionary *)arguments{
    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
    LCDPlayletSearchViewController *vc = [[LCDPlayletSearchViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [viewController presentViewController:vc animated:NO completion:nil];
}

@end
