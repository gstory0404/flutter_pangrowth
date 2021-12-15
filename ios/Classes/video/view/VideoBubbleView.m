//
//  VideoBubbleView.m
//  flutter_pangrowth
//
//  Created by gstory on 2021/12/15.
//

#import "VideoBubbleView.h"
#import <LCDSDK/LCDSDK.h>
#import "UIViewController+getCurrentVC.h"

@implementation VideoBubbleViewFactory{
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
    VideoBubbleView *view = [[VideoBubbleView alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    return view;
}

@end

@interface VideoBubbleView()
@property(nonatomic,strong) LCDHotNewsBubbleView *bubbleView;
@property(nonatomic,strong) LCDNativeDataHolder *dataHolder;
@property(nonatomic,strong) UIView *container;
@property(nonatomic,assign) NSInteger viewId;
@property(nonatomic,strong) FlutterMethodChannel *channel;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,assign) double width;
@property(nonatomic,assign) double height;
@end

@implementation VideoBubbleView

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
        NSString* channelName = [NSString stringWithFormat:@"com.gstory.flutter_pangrowth/VideoBubbleView_%lld", viewId];
        _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        _container= [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
        [self loadTextChain];
    }
    return self;
}

- (nonnull UIView *)view {
    return _container;
}

-(void)loadTextChain{
    _bubbleView = [[LCDHotNewsBubbleView alloc] initWithFrame:CGRectMake(0, 0, _width, _height) configBlock:^(LCDHotNewsBubbleViewConfig * _Nonnull config) {
        config.trackComponentPosition = LCDTrackComponentPosition_tab2;
        config.rootVC = [UIViewController jsd_getCurrentViewController];
        config.customDataHolderBlock = ^(LCDNativeDataHolder * _Nonnull dataHolder) {
//            dataHolder.delegate = [UIViewController jsd_getCurrentViewController];
//            dataHolder.adDelegate = self;
        };
        config.contentAlignment = LCDHotNewsBubbleContentAlignment_left;
        // 内容左边距或右边距
        config.horizontalPadding = 10;
        config.cornerRadius = 6;
        config.maskCorners = UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
        config.customTitleLabelBlock = ^(UILabel * _Nonnull label){
            // 标题内容
            label.text = _title;
//            // 设置标题颜色
//            label.textColor = UIColor.blackColor;
//            // 设置标题字体大小
//            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
        };
    }];
    [_container removeFromSuperview];
    [_container addSubview:_bubbleView];
    [LCDNativeTrackManager.shareInstance trackShowEventForComponent:_bubbleView];
}

@end

