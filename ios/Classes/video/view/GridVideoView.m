//
//  GridVideoView.m
//  flutter_pangrowth
//
//  Created by gstory on 2021/12/15.
//

#import "GridVideoView.h"
#import <LCDSDK/LCDSDK.h>

@implementation GridVideoViewFactory{
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
    GridVideoView *view = [[GridVideoView alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    return view;
}

@end

@interface GridVideoView()
@property(nonatomic,strong) UIView *container;
@property(nonatomic,assign) NSInteger viewId;
@property(nonatomic,strong) FlutterMethodChannel *channel;
@property(nonatomic,assign) double width;
@property(nonatomic,assign) double height;
@property(nonatomic,strong) UIViewController *uvc;
@end

@implementation GridVideoView

- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    if ([super init]) {
        NSLog(@"%@",args);
        NSDictionary *nsd = args;
        _viewId = viewId;
        NSNumber *viewWidth = nsd[@"viewWidth"];
        NSNumber *viewHeight = nsd[@"viewHeight"];
        _width =[viewWidth doubleValue];
        _height =[viewHeight doubleValue];
        NSString* channelName = [NSString stringWithFormat:@"com.gstory.flutter_pangrowth/GridVideoView_%lld", viewId];
        _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        _container= [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
        LCDGridVideoViewController *vc = [[LCDGridVideoViewController alloc] initWithConfigBuilder:^(LCDGridVideoVCConfig * _Nonnull config) {
            config.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            config.viewSize = CGSizeMake(_width, _height);
        }];
        _uvc = [[UIViewController alloc] init];
        [_uvc addChildViewController:vc];
        [_uvc.view removeFromSuperview];
        [_uvc.view addSubview:vc.view];
    }
    return self;
}

- (nonnull UIView *)view {
    return _uvc.view;
}

@end
