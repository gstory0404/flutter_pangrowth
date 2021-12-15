//
//  VideoBannerView.m
//  flutter_pangrowth
//
//  Created by gstory on 2021/12/15.
//

#import "VideoBannerView.h"
#import <LCDSDK/LCDSDK.h>
#import "UIViewController+getCurrentVC.h"

@implementation VideoBannerViewFactory{
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
    VideoBannerView *view = [[VideoBannerView alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    return view;
}

@end

@interface VideoBannerView()
@property(nonatomic,strong) LCDHotNewsBannerView *bannerView;
@property(nonatomic,strong) LCDNativeDataHolder *bannerDataHolder;
@property(nonatomic,strong) UIView *container;
@property(nonatomic,assign) NSInteger viewId;
@property(nonatomic,strong) FlutterMethodChannel *channel;
@property(nonatomic,assign) double width;
@property(nonatomic,assign) double height;
@end

@implementation VideoBannerView

- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    if ([super init]) {
        NSLog(@"%@",args);
        NSDictionary *nsd = args;
        _viewId = viewId;
        NSNumber *viewWidth = nsd[@"viewWidth"];
        NSNumber *viewHeight = nsd[@"viewHeight"];
        _width =[viewWidth doubleValue];
        _height =[viewHeight doubleValue];
        NSString* channelName = [NSString stringWithFormat:@"com.gstory.flutter_pangrowth/VideoBannerView_%lld", viewId];
        _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        _container= [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
        [self loadBanner];
    }
    return self;
}

- (nonnull UIView *)view {
    return _container;
}

-(void)loadBanner{
    _bannerView = [[LCDHotNewsBannerView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)
                                                                           configBlock:^(LCDHotNewsBannerViewConfig * _Nullable config) {
            // -[LCDNativeTrackManager trackShowEventForComponent:]需要使用的参数
            config.trackComponentPosition = LCDTrackComponentPosition_tab3;
            config.rootVC = [UIViewController jsd_getCurrentViewController];
        }];
    [_container removeFromSuperview];
    [_container addSubview:_bannerView];
    _bannerDataHolder = [LCDNativeDataHolder dataHolderWithSceneType:LCDNativeDataHolderSceneType_banner];
    _bannerDataHolder.smartCropSize = _bannerView.smartCropSize;
    [_bannerDataHolder loadDataWithCompletion:^(NSArray<LCDNativeDataModel *> * _Nullable models, NSDictionary * _Nullable extra, NSError * _Nullable error) {
            if (self) {
                if (models.count > 0) {
                    // 使用dataHolder填充组件
                    [_bannerView reloadDataWithDataHolder:_bannerDataHolder];
                    // 这里可以通过LCDSDK完成组件的show埋点
                    [LCDNativeTrackManager.shareInstance trackShowEventForComponent:_bannerView];
                }
            }
        }];
}

@end
