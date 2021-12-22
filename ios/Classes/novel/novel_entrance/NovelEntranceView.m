//
//  NovelEntranceView.m
//  flutter_pangrowth
//
//  Created by gstory on 2021/12/7.
//

#import "NovelEntranceView.h"
#import "BDNovelEntrance.h"
#import "BDNovelPublicReadConfig.h"
#import "BDNovelPublicConfig+ReadConfig.h"

@implementation NovelEntranceViewFactory{
    NSObject<FlutterBinaryMessenger>*_messenger;
}

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messager{
    self = [super init];
    if (self) {
        _messenger = messager;
    }
    return self;
}

-(NSObject<FlutterMessageCodec> *)createArgsCodec{
    return [FlutterStandardMessageCodec sharedInstance];
}

-(NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args{
    NovelEntranceView *novelEntranceView = [[NovelEntranceView alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    return novelEntranceView;
}

@end

@interface NovelEntranceView()
@property(nonatomic,strong) BDNovelEntrance *entrance;
@property(nonatomic,strong) UIView *container;
@property(nonatomic,assign) NSInteger viewId;
@property(nonatomic,strong) FlutterMethodChannel *channel;
@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSString *style;
@property(nonatomic,assign) double width;
@property(nonatomic,assign) double height;
@end

@implementation NovelEntranceView

- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    if ([super init]) {
        NSLog(@"%@",args);
        NSDictionary *nsd = args;
        _viewId = viewId;
        _type = nsd[@"type"];
        _style = nsd[@"style"];
        NSNumber *viewWidth = nsd[@"viewWidth"];
        NSNumber *viewHeight = nsd[@"viewHeight"];
        _width =[viewWidth doubleValue];
        _height =[viewHeight doubleValue];
        NSString* channelName = [NSString stringWithFormat:@"com.gstory.flutter_pangrowth/NovelEntranceView_%lld", viewId];
        _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        _container= [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
//                _container= [[UIView alloc] initWithFrame:frame];
        [self loadBdNovelEntrance];
    }
    return self;
}

- (nonnull UIView *)view {
    return _container;
}

-(void) loadBdNovelEntrance{
    //金刚位
    if ([@"icon" isEqualToString:_type]) {
        [self loadIcon];
        //悬浮球
    }else if ([@"floatBall" isEqualToString:_type]) {
        [self loadFloatBall];
        //banner
    }else if ([@"banner" isEqualToString:_type]) {
        [self loadBanner];
        //window
    }else if ([@"window" isEqualToString:_type]) {
        [self loadWindow];
        //Feed单本
    }else if ([@"feedSingle" isEqualToString:_type]) {
        [self loadFeedSingle];
        //Feed列表
    }else if ([@"feedList" isEqualToString:_type]) {
        [self loadFeedList];
    }
    
}

# pragma mark - 加载金刚位
-(void) loadIcon{
    [_container removeFromSuperview];
    BDNovelEntranceConfig *config = [BDNovelEntranceConfig configWithKind:BDNovelEntranceKindKingKong];
    config.frame = CGRectMake(0, 0, _width, _height);
    _entrance = [BDNovelEntrance entranceWithConfig:config];
    if ([@"circle" isEqualToString:_style]) {
        [_entrance setKingKongType:BDNovelEntranceKingKongCycle];
    }else{
        [_entrance setKingKongType:BDNovelEntranceKingKongSquare];
    }
    [_container addSubview:_entrance];
    [_entrance entranceShow];
}

# pragma mark - 加载悬浮球
-(void) loadFloatBall{
    [_container removeFromSuperview];
    BDNovelEntranceConfig *config = [BDNovelEntranceConfig configWithKind:BDNovelEntranceKindFloatBall];
    config.frame = CGRectMake(0, 0, _width, _height);
    _entrance = [BDNovelEntrance entranceWithConfig:config];
    [_container addSubview:_entrance];
    [_entrance entranceShow];
}

# pragma mark - 加载Banner
-(void) loadBanner{
    [_container removeFromSuperview];
    BDNovelEntranceConfig *config = [BDNovelEntranceConfig configWithKind:BDNovelEntranceKindBanner];
    config.frame = CGRectMake(0, 0, _width, _height);
    _entrance = [BDNovelEntrance entranceWithConfig:config];
    if ([@"large" isEqualToString:_style]) {
        [_entrance setBannerType:BDNovelEntranceBannerLarge];
    }else if([@"medium" isEqualToString:_style]){
        [_entrance setBannerType:BDNovelEntranceBannerMedium];
    }else{
        [_entrance setBannerType:BDNovelEntranceBannerSmall];
    }
    [_container addSubview:_entrance];
    [_entrance entranceShow];
}

# pragma mark - 加载Window
-(void) loadWindow{
    [_container removeFromSuperview];
    BDNovelEntranceConfig *config = [BDNovelEntranceConfig configWithKind:BDNovelEntranceKindShowCase];
    config.frame = CGRectMake(0, 0, _width, _height);
    _entrance = [BDNovelEntrance entranceWithConfig:config];
    if ([@"color1" isEqualToString:_style]) {
        [_entrance setShowCaseType:BDNovelEntranceShowCaseColor0];
    }else{
        [_entrance setShowCaseType:BDNovelEntranceShowCaseColor1];
    }
    [_container addSubview:_entrance];
    [_entrance entranceShow];
}

# pragma mark - 加载Feed单本
-(void) loadFeedSingle{
    [_container removeFromSuperview];
    BDNovelPublicReadConfigRequestParam *param = [BDNovelPublicReadConfigRequestParam new];
    param.readConfigType = BDNovelPublicReadConfigTypeRecommendFeed;
    param.count = 1;
    [BDNovelPublicConfig getReadConfigWithParam:param completion:^(NSError * _Nullable err, NSArray<BDNovelPublicReadConfig *> * _Nullable configs) {
        if(err == nil){
            BDNovelEntranceConfig *config = [BDNovelEntranceConfig configWithKind:BDNovelEntranceKindFeedSmall];
            config.frame = CGRectMake(0, 0, _width, _height);
            _entrance = [BDNovelEntrance entranceWithConfig:config];
            if([@"male" isEqualToString:_style]){
                [_entrance setFeedLargeImageBookBackground:BDNovelEntranceFeedSmallImageMale];
            }else if([@"female" isEqualToString:_style]){
                [_entrance setFeedLargeImageBookBackground:BDNovelEntranceFeedSmallImageFeMale];
            }else{
                [_entrance setFeedLargeImageBookBackground:BDNovelEntranceFeedSmallImageDefault];
            }
            [_entrance setFeedLargeImageData:configs[0]];
            [_container addSubview:_entrance];
            [_entrance entranceShow];
        }
    }];
}

# pragma mark - 加载Feed列表
-(void) loadFeedList{
    [_container removeFromSuperview];
    BDNovelPublicReadConfigRequestParam *param = [BDNovelPublicReadConfigRequestParam new];
    param.readConfigType = BDNovelPublicReadConfigTypeRecommendFeed;
    param.count = 3;
    [BDNovelPublicConfig getReadConfigWithParam:param completion:^(NSError * _Nullable err, NSArray<BDNovelPublicReadConfig *> * _Nullable configs) {
        if(err == nil){
            BDNovelEntranceConfig *config = [BDNovelEntranceConfig configWithKind:BDNovelEntranceKindHotNovel];
            config.frame = CGRectMake(0, 0, _width, _height);
            _entrance = [BDNovelEntrance entranceWithConfig:config];
            [_entrance setHotNovelData:configs];
            [_container addSubview:_entrance];
            [_entrance entranceShow];
        }
    }];
}

@end
