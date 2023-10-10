#import "FlutterPangrowthPlugin.h"
#import "video/VideoPlugin.h"
#import "playlet/PlayletPlugin.h"
#import "video/view/DrawVideoFullView.h"
#import "video/view/NewsTabsView.h"
#import "video/view/NewsTabOneView.h"
#import "video/view/GridVideoView.h"
#import "video/view/VideoBannerView.h"
#import "video/view/VideoTextChainView.h"
#import "video/view/VideoBubbleView.h"
#import "video/view/VideoSingleCardView.h"
#import "video/view/VideoNewsSingleCardView.h"
#import "video/view/VideoCardView.h"
#import "playlet/view/PlayletCardView.h"

@interface FlutterPangrowthPlugin()

@end

@implementation FlutterPangrowthPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutter_pangrowth"
                                     binaryMessenger:[registrar messenger]];
    FlutterPangrowthPlugin* instance = [[FlutterPangrowthPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    //沉浸式小视频view
    [registrar registerViewFactory:[[DrawVideoFullViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.gstory.flutter_pangrowth/DrawFullView"];
    //宫格小视频view
    [registrar registerViewFactory:[[GridVideoViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.gstory.flutter_pangrowth/GridVideoView"];
    //新闻多列表view
    [registrar registerViewFactory:[[NewsTabsViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.gstory.flutter_pangrowth/NewsTabsView"];
    //新闻单列表view
    [registrar registerViewFactory:[[NewsTabOneViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.gstory.flutter_pangrowth/NewsTabOneView"];
    //视频组件-banner
    [registrar registerViewFactory:[[VideoBannerViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.gstory.flutter_pangrowth/VideoBannerView"];
    //视频组件-文字链
    [registrar registerViewFactory:[[VideoTextChainViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.gstory.flutter_pangrowth/VideoTextChainView"];
    //视频组件-气泡
    [registrar registerViewFactory:[[VideoBubbleViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.gstory.flutter_pangrowth/VideoBubbleView"];
    //视频 单卡片视频
    [registrar registerViewFactory:[[VideoSingleCardViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.gstory.flutter_pangrowth/VideoSingleCardView"];
    //视频 单卡片新闻
    [registrar registerViewFactory:[[VideoNewsSingleCardViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.gstory.flutter_pangrowth/VideoNewsSingleCardView"];
    //视频 卡片
    [registrar registerViewFactory:[[VideoCardViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.gstory.flutter_pangrowth/VideoCardView"];
    //短剧 卡片
    [registrar registerViewFactory:[[PlayletCardViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.gstory.flutter_pangrowth/PlayletCardView"];
    
}


- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    //视频初始化
    if([@"registerVideo" isEqualToString:call.method]){
        [VideoPlugin registerVideo:call.arguments result:result];
        //打开沉浸式小视频场景展示：全屏样式
    }else if([@"openDrawVideoFull" isEqualToString:call.method]){
        [VideoPlugin openDrawVideoFull];
        //打开宫格小视频：全屏样式
    }else if([@"openGridVideo" isEqualToString:call.method]){
        [VideoPlugin openGridVideo];
        //打开新闻 多列表 全屏样式
    }else if([@"openNewsTabs" isEqualToString:call.method]){
        [VideoPlugin openNewsTabs];
        //打开新闻 单列表 全屏样式
    }else if([@"openNewsTabOne" isEqualToString:call.method]){
        [VideoPlugin openNewsTabOne];
        //打开个人主页
    }else if([@"openUserCenter" isEqualToString:call.method]){
        [VideoPlugin openUserCenter];
        //获取信息流数据
    }else if([@"getFeedNativeData" isEqualToString:call.method]){
        [VideoPlugin getFeedNativeData:call.arguments result:result];
        //短剧聚合页
    }else if([@"openPlayletAggregatePage" isEqualToString:call.method]){
        [PlayletPlugin openPlayletAggregatePage:call.arguments];
        //打开短剧混排
    }else if([@"openPlayletDrawVideoPage" isEqualToString:call.method]){
        [PlayletPlugin openPlayletDrawVideoPage:call.arguments];
        //打开短剧搜索
    }else if([@"openPlayletSearchPage" isEqualToString:call.method]){
        [PlayletPlugin openPlayletSearchPage:call.arguments];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
