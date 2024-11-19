#import "FlutterPangrowthPlugin.h"
#import "video/VideoPlugin.h"
#import "playlet/PlayletPlugin.h"
#import "novel/NovelPlugin.h"
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
#import <BUAdSDK/BUAdSDK.h>

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
    //广告初始化
    if([@"registerAd" isEqualToString:call.method]){
        NSString *appId = call.arguments[@"iosAppId"];
        BUAdSDKConfiguration *configuration = [BUAdSDKConfiguration configuration];
        configuration.appID = appId;
        // 设置日志输出
        configuration.debugLog = @(1);
        // 是否使用聚合
        configuration.useMediation = YES;
        // 隐私合规配置
        // 不限制个性化广告（聚合维度功能）
        configuration.mediation.limitPersonalAds = @(0);
        // 不限制程序化广告（聚合维度功能）
        configuration.mediation.limitProgrammaticAds = @(0);
        // 不禁止CAID（聚合维度功能）
        configuration.mediation.forbiddenCAID = @(0);
        // 未成年配置
        configuration.ageGroup = BUAdSDKAgeGroupAdult;
        // 主题模式
        configuration.themeStatus = @(BUAdSDKThemeStatus_Normal);
        // 初始化
        [BUAdSDKManager startWithAsyncCompletionHandler:^(BOOL success, NSError *error) {
            if (success) {
                result(@YES);
            }else{
                result(@NO);
            }
        }];
        //---------------------短视频--------------------//
    //视频初始化
    }else if([@"registerVideo" isEqualToString:call.method]){
        [VideoPlugin registerVideo:call.arguments result:result];
        //打开沉浸式小视频场景展示：全屏样式
    }else if([@"openDrawVideoFull" isEqualToString:call.method]){
        [VideoPlugin openDrawVideoFull];
        //打开宫格小视频：全屏样式
    }else if([@"openGridVideo" isEqualToString:call.method]){
        [VideoPlugin openGridVideo];
        //打开个人主页
    }else if([@"openUserCenter" isEqualToString:call.method]){
        [VideoPlugin openUserCenter];
        //获取信息流数据
    }else if([@"getFeedNativeData" isEqualToString:call.method]){
        [VideoPlugin getFeedNativeData:call.arguments result:result];
        //---------------------短剧--------------------//
        //初始化短剧
    }else if([@"registerPlaylet" isEqualToString:call.method]){
        [PlayletPlugin registerPlaylet:call.arguments result:result];
        //短剧聚合页
    }else if([@"openPlayletAggregatePage" isEqualToString:call.method]){
        [PlayletPlugin openPlayletAggregatePage:call.arguments];
        //分页拉取所有短剧
    }else if([@"requestAllPlayletListPage" isEqualToString:call.method]){
        [PlayletPlugin requestAllPlayletListPage:call.arguments result:result];
        //短剧推荐列表
    }else if([@"requestRecommendedPlayletListPage" isEqualToString:call.method]){
        [PlayletPlugin requestRecommendedPlayletListPage:call.arguments result:result];
        //短剧全部列表
    }else if([@"requestAllPlayletListWithOrder" isEqualToString:call.method]){
        [PlayletPlugin requestAllPlayletListWithOrder:call.arguments result:result];
        //根据短剧id获取列表
    }else if([@"requestPlayletListWithPlayletId" isEqualToString:call.method]){
        [PlayletPlugin requestPlayletListWithPlayletId:call.arguments result:result];
        //根据搜索关键词获取列表
    }else if([@"requestCategoryPlayletLisWithSearchWord" isEqualToString:call.method]){
        [PlayletPlugin requestCategoryPlayletLisWithSearchWord:call.arguments result:result];
        //短剧分类列表
    }else if([@"requestPlayletCategoryList" isEqualToString:call.method]){
        [PlayletPlugin requestCategoryList:call.arguments result:result];
        //根据分类获取列表
    }else if([@"requestCategoryPlayletLisWithCategory" isEqualToString:call.method]){
        [PlayletPlugin requestCategoryPlayletLisWithCategory:call.arguments result:result];
        //进入播放页
    }else if([@"enterPlayletPlayer" isEqualToString:call.method]){
        [PlayletPlugin enterPlayletPlayer:call.arguments result:result];
        //短剧历史记录列表
    }else if([@"requestPlayletHistoryListWithPage" isEqualToString:call.method]){
        [PlayletPlugin requestPlayletHistoryListWithPage:call.arguments result:result];
        // 短剧历史记录清除
    }else if([@"requestPlayletHistoryClean" isEqualToString:call.method]){
        [PlayletPlugin requestPlayletHistoryCleanWithCompletion:call.arguments result:result];
        // 点赞某一集短剧
    }else if([@"likeShortplay" isEqualToString:call.method]){
        [PlayletPlugin likeShortplay:call.arguments result:result];
        // 取消点赞某一集短剧
    }else if([@"cancelLikeShortplay" isEqualToString:call.method]){
        [PlayletPlugin cancelLikeShortplay:call.arguments result:result];
        // 收藏某部剧
    }else if([@"collectShortplay" isEqualToString:call.method]){
        [PlayletPlugin collectShortplay:call.arguments result:result];
        // 取消收藏某部剧
    }else if([@"cancelCollectShortplay" isEqualToString:call.method]){
        [PlayletPlugin cancelCollectShortplay:call.arguments result:result];
        // 获取收藏列表
    }else if([@"requestCollectionList" isEqualToString:call.method]){
        [PlayletPlugin requestCollectionList:call.arguments result:result];
        //---------------------短小说--------------------//
        //初始化短小说
    }else if([@"registerNovel" isEqualToString:call.method]){
        [NovelPlugin registerNovel:call.arguments result:result];
        //打开短小说聚合页
    }else if([@"openNovelAggregatePage" isEqualToString:call.method]){
        [NovelPlugin openNovelAggregatePage:call.arguments result:result];
        //打开短故事阅读器
    }else if([@"openMiniStory" isEqualToString:call.method]){
        [NovelPlugin openMiniStory:call.arguments result:result];
        //查询短故事类目列表
    }else if([@"requestNovelCategoryList" isEqualToString:call.method]){
        [NovelPlugin requestNovelCategoryList:call.arguments result:result];
        //短故事搜素
    }else if([@"requestStoryListWithSearchWord" isEqualToString:call.method]){
        [NovelPlugin requestStoryListWithSearchWord:call.arguments result:result];
        //短故事按照book_id查询
    }else if([@"requestStoryListWithBookId" isEqualToString:call.method]){
        [NovelPlugin requestStoryListWithBookId:call.arguments result:result];
        //短故事分页加载
    }else if([@"requestAllStoryListPage" isEqualToString:call.method]){
        [NovelPlugin requestAllStoryListPage:call.arguments result:result];
        // 根据排序方式，查询短故事列表
    }else if([@"requestAllStoryListWithOrder" isEqualToString:call.method]){
        [NovelPlugin requestAllStoryListWithOrder:call.arguments result:result];
        // 根据类目id查询短故事列表
    }else if([@"requestCategoryStoryListWithCategoryId" isEqualToString:call.method]){
        [NovelPlugin requestCategoryStoryListWithCategoryId:call.arguments result:result];
        // 短故事阅读记录
    }else if([@"requestHistoryStoryList" isEqualToString:call.method]){
        [NovelPlugin requestHistoryStoryList:call.arguments result:result];
        //  收藏短故事
    }else if([@"requestCollectStory" isEqualToString:call.method]){
        [NovelPlugin requestCollectStory:call.arguments result:result];
        // 取消收藏短故事
    }else if([@"requestCancelCollectStory" isEqualToString:call.method]){
        [NovelPlugin requestCancelCollectStory:call.arguments result:result];
        //获取短故事的收藏列表
    }else if([@"requestStoryCollectionList" isEqualToString:call.method]){
        [NovelPlugin requestStoryCollectionList:call.arguments result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}



@end
