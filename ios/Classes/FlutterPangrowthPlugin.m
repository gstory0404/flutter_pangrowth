#import "FlutterPangrowthPlugin.h"
#import "BDNovelPublicConfig.h"
#import "UIViewController+getCurrentVC.h"
#import "LogUtil.h"
#import "BDNovelPublicConfig+ReadConfig.h"
#import "BDNovelPublicReadConfig.h"
#import "MJExtension.h"
#import "NovelEntranceView.h"
#import "NovelEntity.h"

@interface FlutterPangrowthPlugin()
@property (nonatomic, strong) UINavigationController *navi;

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
}


- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    //初始化小说
    if ([@"registerNovel" isEqualToString:call.method]) {
        [self registerNovel:call.arguments result:result ];
        //打开小说主页
    }else if([@"openNovelPage" isEqualToString:call.method]){
        [self openNovelPage:call.arguments result:result ];
        //获取阅读历史，单本
    }else if([@"getNovelHistory" isEqualToString:call.method]){
        [self getNovelHistory:call.arguments result:result ];
        //获取启动后推荐书列表，信息较少
    }else if([@"getNovelRecommendV1" isEqualToString:call.method]){
        [self getNovelRecommendV1:call.arguments result:result ];
        //获取Feed推荐书列表，信息较多
    }else if([@"getNovelRecommendFeed" isEqualToString:call.method]){
        [self getNovelRecommendFeed:call.arguments result:result ];
        //打开小说页面
    }else if([@"openNovelPageWithConfig" isEqualToString:call.method]){
        [self openNovelPageWithConfig:call.arguments result:result ];
        //打开小说页面url
    }else if([@"openNovelPageWithUrl" isEqualToString:call.method]){
        [self openNovelPageWithUrl:call.arguments result:result ];
        //为了更精准推荐书籍，当显示getReadConfigWithParam获得的书时，调用此接口,上报埋点增强推荐能力
    }else if([@"reportRecentNovelShow" isEqualToString:call.method]){
        [self reportRecentNovelShow:call.arguments result:result ];
        //获取小说阅读时长
    }else if([@"getReadDuration" isEqualToString:call.method]){
        NSUInteger duration = [BDNovelPublicConfig getReadDuration];
        result(@(duration));
        // 小说搜索推荐
    }else if([@"searchNovelSuggestions" isEqualToString:call.method]){
        [self searchNovelSuggestions:call.arguments result:result ];
        // 小说搜索结果
    }else if([@"searchNovelResults" isEqualToString:call.method]){
        [self searchNovelResults:call.arguments result:result ];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

# pragma mark - 初始化小说
-(void)registerNovel:(NSDictionary *)dic result:(FlutterResult)result{
    BOOL debug = [dic[@"debug"] boolValue];
    NSString *normalFontType = dic[@"normalFontType"];
    NSString *readFontType = dic[@"readFontType"];
    //日志
    [[LogUtil sharedInstance] debug:debug];
    [BDNovelPublicConfig startWithConfig:^(BDNovelPublicConfig * _Nonnull makeConfig) {
        makeConfig.configPath = [[NSBundle mainBundle] pathForResource:@"pangrowthconfig" ofType:@"json"];//pathForResource为SDK动态下发json配置文件的路径
        makeConfig.appName = dic[@"appName"];
        makeConfig.appId = dic[@"iosAppId"];
        makeConfig.personalRecommendEnabled = [dic[@"personalRecommendContent"] boolValue];
        makeConfig.autoConfigTrack = YES; //如果原本app已经接入DataRanges,请设置NO
        
        makeConfig.logger = ^(NSString * _Nullable log) {
            [[LogUtil sharedInstance] print:(@"makeConfig---->%@", log)];
        };
        makeConfig.naviCallback = ^{
            UIApplication *app=[UIApplication sharedApplication];
            return app.delegate.window.rootViewController.navigationController;
        };
        //全局字体大小
        if([@"large" isEqualToString:normalFontType]){
            makeConfig.novelCoverFontSize = BDNovelFontSizeLarge;
        }else{
            makeConfig.novelCoverFontSize = BDNovelFontSizeNormal;
        }
        //阅读字体大小
        if([@"one" isEqualToString:readFontType]){
            makeConfig.novelContentFontSize = BDNovelContentFontSizeSmall;
        }else if ([@"there" isEqualToString:readFontType]){
            makeConfig.novelContentFontSize = BDNovelContentFontSizeLarge;
        }else if ([@"four" isEqualToString:readFontType]){
            makeConfig.novelContentFontSize = BDNovelContentFontSizeXL;
        }else if ([@"five" isEqualToString:readFontType]){
            makeConfig.novelContentFontSize = BDNovelContentFontSizeXXL;
        }else if ([@"six" isEqualToString:readFontType]){
            makeConfig.novelContentFontSize = BDNovelContentFontSizeXXXL;
        }else{
            makeConfig.novelContentFontSize = BDNovelContentFontSizeNormal;
        }
    } completion:^(NSString * _Nullable error) {
        //log以【Tomato-Novel】开头
        [[LogUtil sharedInstance] print:(@"completion---->%@", error)];
    }];
    result(@YES);
}

# pragma mark - 打开小说主页
-(void)openNovelPage:(NSDictionary *)dic result:(FlutterResult)result{
    UIViewController *channel = [BDNovelPublicConfig novelViewControllerWithType:BDNovelPublicEnTranceTypeChannelPage userInfo:nil];
    /*userInfo，NSDictionary结构，传入参数配置小说首页:
     kBDNovelPageUserInfoFullScreen = YES, 隐藏导航栏，获得全屏小说首页vc（只限小说首页）
     */
    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:channel];
    if (@available(iOS 13.0, *)) {
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [viewController presentViewController:nav animated:YES completion:nil];
    result(@YES);
}

# pragma mark - 获取阅读历史，单本
-(void)getNovelHistory:(NSDictionary *)dic result:(FlutterResult)result{
    BDNovelPublicReadConfigRequestParam *param = [BDNovelPublicReadConfigRequestParam new];
    param.readConfigType = BDNovelPublicReadConfigTypeHistory;
    //阅读历史支持1本，
    param.count = [dic[@"size"] intValue];
    [BDNovelPublicConfig getReadConfigWithParam:param completion:^(NSError * _Nullable err, NSArray<BDNovelPublicReadConfig *> * _Nullable configs) {
        //BDNovelPulicReadConfig是基类，需要根据readConfigType自行转换BDNovelPulicReadConfigHistory || BDNovelPulicReadConfigRecommedV1 || BDNovelPulicReadConfigRecommendFeed
        
        NovelEntity *entity = [[NovelEntity alloc] init];
        if(err == nil){
            [entity setCode:@YES];
            [entity setMsg:@""];
            NSMutableArray *nsarr = [[NSMutableArray alloc]init];
            for (BDNovelPublicReadConfigHistory *config in configs) {
                NovelData *data = [[NovelData alloc] init];
                [data setType:@0];
                [data setReadUrl:@""];
                [data setBookName:config.bookName];
                [data setThumbUrl:config.thumbUrl];
                [data setNovelDetail:[self dictionaryToJson:config.mj_keyValues]];
                [nsarr addObject:data];
            }
            [entity setData:nsarr];
        }else{
            [entity setCode:@NO];
            [entity setMsg:(err.userInfo.description)];
        }
        result(entity.mj_keyValues);
    }];
}

# pragma mark - 字典转json格式字符串：
- (NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

# pragma mark - 获取启动后推荐书列表，信息较少
-(void)getNovelRecommendV1:(NSDictionary *)dic result:(FlutterResult)result{
    BDNovelPublicReadConfigRequestParam *param = [BDNovelPublicReadConfigRequestParam new];
    param.readConfigType = BDNovelPublicReadConfigTypeRecommendV1;
    //阅读历史支持1本，
    param.count = [dic[@"size"] intValue];
    [BDNovelPublicConfig getReadConfigWithParam:param completion:^(NSError * _Nullable err, NSArray<BDNovelPublicReadConfig *> * _Nullable configs) {
        //BDNovelPulicReadConfig是基类，需要根据readConfigType自行转换BDNovelPulicReadConfigHistory || BDNovelPulicReadConfigRecommedV1 || BDNovelPulicReadConfigRecommendFeed
        
        NovelEntity *entity = [[NovelEntity alloc] init];
        if(err == nil){
            [entity setCode:@YES];
            [entity setMsg:@""];
            NSMutableArray *nsarr = [[NSMutableArray alloc]init];
            for (BDNovelPublicReadConfigRecommedV1 *config in configs) {
                NovelData *data = [[NovelData alloc] init];
                [data setType:@1];
                [data setReadUrl:@""];
                [data setBookName:config.bookName];
                [data setThumbUrl:config.thumbUrl];
                [data setNovelDetail:[self dictionaryToJson:config.mj_keyValues]];
                [nsarr addObject:data];
            }
            [entity setData:nsarr];
        }else{
            [entity setCode:@NO];
            [entity setMsg:(err.userInfo.description)];
        }
        result(entity.mj_keyValues);
    }];
}


# pragma mark - 获取Feed推荐书列表，信息较多
-(void)getNovelRecommendFeed:(NSDictionary *)dic result:(FlutterResult)result{
    BDNovelPublicReadConfigRequestParam *param = [BDNovelPublicReadConfigRequestParam new];
    param.readConfigType = BDNovelPublicReadConfigTypeRecommendFeed;
    param.count = [dic[@"size"] intValue];
    [BDNovelPublicConfig getReadConfigWithParam:param completion:^(NSError * _Nullable err, NSArray<BDNovelPublicReadConfig *> * _Nullable configs) {
        NovelEntity *entity = [[NovelEntity alloc] init];
        NSLog(@"%@",configs);
        if(err == nil){
            [entity setCode:@YES];
            [entity setMsg:@""];
            NSMutableArray *nsarr = [[NSMutableArray alloc]init];
            for (BDNovelPublicReadConfigRecommendFeed *config in configs) {
                NovelData *data = [[NovelData alloc] init];
                [data setType:@1];
                [data setReadUrl:@""];
                [data setBookName:config.bookName];
                [data setThumbUrl:config.thumbUrl];
                [data setNovelDetail:[self dictionaryToJson:config.mj_keyValues]];
                [nsarr addObject:data];
            }
            [entity setData:nsarr];
        }else{
            [entity setCode:@NO];
            [entity setMsg:(err.userInfo.description)];
        }
        result(entity.mj_keyValues);
    }];
}

# pragma mark - 为了更精准推荐书籍，当显示getReadConfigWithParam获得的书时，调用此接口,上报埋点增强推荐能力
-(void)reportRecentNovelShow:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger type = [dic[@"type"] intValue];
    NSString *book = dic[@"book"];
    if(type == 0){
        BDNovelPublicReadConfigHistory *novel = [BDNovelPublicReadConfigHistory mj_objectWithKeyValues: book];
        [BDNovelPublicConfig showBookEvent:novel];
    }else if (type ==1){
        BDNovelPublicReadConfigRecommedV1 *novel = [BDNovelPublicReadConfigRecommedV1 mj_objectWithKeyValues: book];
        [BDNovelPublicConfig showBookEvent:novel];
    }else if(type == 2){
        BDNovelPublicReadConfigRecommendFeed *novel = [BDNovelPublicReadConfigRecommendFeed mj_objectWithKeyValues: book];
        [BDNovelPublicConfig showBookEvent:novel];
    }
    result(@YES);
}

# pragma mark - 打开小说页面
-(void)openNovelPageWithConfig:(NSDictionary *)dic result:(FlutterResult)result{
    NSInteger type = [dic[@"type"] intValue];
    NSString *book = dic[@"book"];
    //先打开首页 不然无法找到UINavigationController
//    UIViewController *channel = [BDNovelPublicConfig novelViewControllerWithType:BDNovelPublicEnTranceTypeChannelPage userInfo:nil];
//    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:channel];
//    if (@available(iOS 13.0, *)) {
//        nav.modalPresentationStyle = UIModalPresentationFullScreen;
//    }
//    [viewController presentViewController:nav animated:YES completion:nil];
    //跳转具体书籍
    if(type == 0){
        BDNovelPublicReadConfigHistory *novel = [BDNovelPublicReadConfigHistory mj_objectWithKeyValues: book];
        [BDNovelPublicConfig openNovelPageWithConfig:novel];
    }else if (type ==1){
        BDNovelPublicReadConfigRecommedV1 *novel = [BDNovelPublicReadConfigRecommedV1 mj_objectWithKeyValues: book];
        [BDNovelPublicConfig openNovelPageWithConfig:novel];
    }else if(type == 2){
        BDNovelPublicReadConfigRecommendFeed *novel = [BDNovelPublicReadConfigRecommendFeed mj_objectWithKeyValues: book];
        [BDNovelPublicConfig openNovelPageWithConfig:novel];
    }
    result(@YES);
}

# pragma mark - 打开小说页面url
-(void)openNovelPageWithUrl:(NSDictionary *)dic result:(FlutterResult)result{
    NSString *url = dic[@"url"];
    //先打开首页 不然无法找到UINavigationController
//    UIViewController *channel = [BDNovelPublicConfig novelViewControllerWithType:BDNovelPublicEnTranceTypeChannelPage userInfo:nil];
//    UINavigationController *viewController =[UIApplication sharedApplication].keyWindow.rootViewController;
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:channel];
//    if (@available(iOS 13.0, *)) {
//        nav.modalPresentationStyle = UIModalPresentationFullScreen;
//    }
//    [viewController presentViewController:nav animated:YES completion:nil];
    //跳转具体书籍
    [BDNovelPublicConfig openNovelReader:url];
    result(@YES);
}


# pragma mark - 小说搜索推荐
-(void)searchNovelSuggestions:(NSDictionary *)dic result:(FlutterResult)result{
    NSString *queryContent = dic[@"queryContent"];
    BDNovelSearchSuggestionParams *params = [[BDNovelSearchSuggestionParams alloc] init];
    params.query = queryContent;
    params.needDetail = YES;
    [BDNovelPublicConfig searchSuggestionsWithParams:params completeHandler:^(NSArray<BDNovelSearchSuggestion *> * _Nullable suggestions, NSError * _Nullable error) {
        NovelEntity *entity = [[NovelEntity alloc] init];
        if(error == nil){
            [entity setCode:@YES];
            [entity setMsg:@""];
            NSMutableArray *nsarr = [[NSMutableArray alloc]init];
            for (BDNovelSearchSuggestion *suggestion in suggestions) {
                NovelData *data = [[NovelData alloc] init];
                [data setType:@3];
                [data setReadUrl:suggestion.book_detail_info.item_schema_url];
                [data setBookName:suggestion.book_detail_info.book_name];
                [data setThumbUrl:suggestion.book_detail_info.thumb_url];
                [data setNovelDetail:[self dictionaryToJson:suggestion.mj_keyValues]];
                [nsarr addObject:data];
            }
            [entity setData:nsarr];
        }else{
            [entity setCode:@NO];
            [entity setMsg:(error.userInfo.description)];
        }
        result(entity.mj_keyValues);
    }];
}

# pragma mark - 小说搜索结果
-(void)searchNovelResults:(NSDictionary *)dic result:(FlutterResult)result{
    NSString *queryContent = dic[@"queryContent"];
    NSInteger offset = [dic[@"offset"] intValue];
    NSInteger limit = [dic[@"limit"] intValue];
    BDNovelSearchResultsParams *params = [[BDNovelSearchResultsParams alloc] init];
    params.query = queryContent;
    params.offset = offset;
    params.limit = limit;
    [BDNovelPublicConfig searchResultsWithParams:params completeHandler:^(NSArray<BDNovelSearchBookInfo *> * _Nullable results, NSError * _Nullable error) {
        
        NovelEntity *entity = [[NovelEntity alloc] init];
        if(error == nil){
            [entity setCode:@YES];
            [entity setMsg:@""];
            NSMutableArray *nsarr = [[NSMutableArray alloc]init];
            for (BDNovelSearchBookInfo *searchBook in results) {
                NovelData *data = [[NovelData alloc] init];
                [data setType:@4];
                [data setReadUrl:searchBook.item_schema_url];
                [data setBookName:searchBook.book_name];
                [data setThumbUrl:searchBook.thumb_url];
                [data setNovelDetail:[self dictionaryToJson:searchBook.mj_keyValues]];
                [nsarr addObject:data];
            }
            [entity setData:nsarr];
        }else{
            [entity setCode:@NO];
            [entity setMsg:(error.userInfo.description)];
        }
        result(entity.mj_keyValues);
        
    }];
}


@end
