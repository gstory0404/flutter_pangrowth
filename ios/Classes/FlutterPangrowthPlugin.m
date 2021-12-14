#import "FlutterPangrowthPlugin.h"
#import "NovelPlugin.h"
#import "BDNovelPublicConfig.h"
#import "novel/novel_entrance/NovelEntranceView.h"
#import "video/VideoPlugin.h"
#import "video/base/DrawVideoFullView.h"

@interface FlutterPangrowthPlugin()

@end

@implementation FlutterPangrowthPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutter_pangrowth"
                                     binaryMessenger:[registrar messenger]];
    FlutterPangrowthPlugin* instance = [[FlutterPangrowthPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    //注册小说入口控件
    [registrar registerViewFactory:[[NovelEntranceViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.gstory.flutter_pangrowth/NovelEntranceView"];
    
    [registrar registerViewFactory:[[DrawVideoFullViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.gstory.flutter_pangrowth/DrawVideoFullView"];
}


- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    //初始化小说
    if ([@"registerNovel" isEqualToString:call.method]) {
        [NovelPlugin registerNovel:call.arguments result:result];
        //打开小说主页
    }else if([@"openNovelPage" isEqualToString:call.method]){
        [NovelPlugin openNovelPage:call.arguments result:result ];
        //获取阅读历史，单本
    }else if([@"getNovelHistory" isEqualToString:call.method]){
        [NovelPlugin getNovelHistory:call.arguments result:result ];
        //获取启动后推荐书列表，信息较少
    }else if([@"getNovelRecommendV1" isEqualToString:call.method]){
        [NovelPlugin getNovelRecommendV1:call.arguments result:result];
        //获取Feed推荐书列表，信息较多
    }else if([@"getNovelRecommendFeed" isEqualToString:call.method]){
        [NovelPlugin getNovelRecommendFeed:call.arguments result:result];
        //打开小说页面
    }else if([@"openNovelPageWithConfig" isEqualToString:call.method]){
        [NovelPlugin openNovelPageWithConfig:call.arguments result:result];
        //打开小说页面url
    }else if([@"openNovelPageWithUrl" isEqualToString:call.method]){
        [NovelPlugin openNovelPageWithUrl:call.arguments result:result];
        //为了更精准推荐书籍，当显示getReadConfigWithParam获得的书时，调用此接口,上报埋点增强推荐能力
    }else if([@"reportRecentNovelShow" isEqualToString:call.method]){
        [NovelPlugin reportRecentNovelShow:call.arguments result:result ];
        //获取小说阅读时长
    }else if([@"getReadDuration" isEqualToString:call.method]){
        NSUInteger duration = [BDNovelPublicConfig getReadDuration];
        result(@(duration));
        // 小说搜索推荐
    }else if([@"searchNovelSuggestions" isEqualToString:call.method]){
        [NovelPlugin searchNovelSuggestions:call.arguments result:result];
        // 小说搜索结果
    }else if([@"searchNovelResults" isEqualToString:call.method]){
        [NovelPlugin searchNovelResults:call.arguments result:result];
        //视频初始化
    }else if([@"registerVideo" isEqualToString:call.method]){
        [VideoPlugin registerVideo:call.arguments result:result];
        //打开沉浸式小视频场景展示：全屏样式
    }else if([@"openDrawVideoFull" isEqualToString:call.method]){
        [VideoPlugin openDrawVideoFull];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
