//
//  VideoCardView.m
//  flutter_pangrowth
//  视频卡片
//  Created by gstory on 2021/12/15.
//

#import "VideoCardView.h"
#import <LCDSDK/LCDSDK.h>
#import "UIViewController+getCurrentVC.h"

@implementation VideoCardViewFactory{
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
    VideoCardView *view = [[VideoCardView alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    return view;
}

@end

@interface VideoCardView()
@property(nonatomic,strong) UIView<LCDVideoCardView> *videoCardView;
@property(nonatomic,strong) LCDNativeDataHolder *dataHolder;
@property(nonatomic,strong) UIView *container;
@property(nonatomic,assign) NSInteger viewId;
@property(nonatomic,strong) FlutterMethodChannel *channel;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,assign) double width;
@property(nonatomic,assign) double height;
@property (nonatomic) id<LCDViewElement> element;
@property (nonatomic) LCDVideoCardProvider *cardProvider;
@end

@implementation VideoCardView

- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    if ([super init]) {
        NSLog(@"%@",args);
        NSDictionary *nsd = args;
        _viewId = viewId;
        _title = nsd[@"title"];
        NSNumber *viewWidth = nsd[@"viewWidth"];
        NSNumber *viewHeight = nsd[@"viewHeight"];
        _width =[viewWidth doubleValue];
        _height =[viewHeight doubleValue];
        NSString* channelName = [NSString stringWithFormat:@"com.gstory.flutter_pangrowth/VideoCardView_%lld", viewId];
        _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        _container= [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
        [self loadVideoCard];
    }
    return self;
}

- (nonnull UIView *)view {
    return _container;
}

-(void)loadVideoCard{
    [_container removeFromSuperview];
    _cardProvider = [LCDVideoCardProvider new];
    _cardProvider.cardType = LCDVideoCardTypeCustom;
//    _cardProvider.delegate = self;
//    _cardProvider.adDelegate = self;
    _cardProvider.rootViewController = [UIViewController jsd_getCurrentViewController];
    _cardProvider.viewWidth = _width;
    _cardProvider.viewHeight = _height;
    _element = [_cardProvider buildViewElement];
    _videoCardView = [_cardProvider buildView];
    [_container addSubview:_videoCardView];
    [_element loadDataWithCompletion:^(id<LCDViewElement>  _Nonnull element, NSError * _Nonnull error) {
        [_videoCardView refreshData:element];
        [LCDNativeTrackManager.shareInstance trackShowEventForComponent:_videoCardView];
    }];
}

@end
