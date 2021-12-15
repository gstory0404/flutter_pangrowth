//
//  MyView.m
//  flutter_pangrowth
//
//  Created by gstory on 2021/12/14.
//

#import "DrawVideoFullView.h"
#import <LCDSDK/LCDSDK.h>

@implementation DrawVideoFullViewFactory{
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
    DrawVideoFullView *view = [[DrawVideoFullView alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    return view;
}

@end

@interface DrawVideoFullView()
@property(nonatomic,strong) UIView *container;
@property(nonatomic,assign) NSInteger viewId;
@property(nonatomic,strong) FlutterMethodChannel *channel;
@property(nonatomic,assign) double width;
@property(nonatomic,assign) double height;
@property(nonatomic,strong) UIViewController *uvc;
@end

@implementation DrawVideoFullView

- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    if ([super init]) {
        NSLog(@"%@",args);
        NSDictionary *nsd = args;
        _viewId = viewId;
        NSNumber *viewWidth = nsd[@"viewWidth"];
        NSNumber *viewHeight = nsd[@"viewHeight"];
        _width =[viewWidth doubleValue];
        _height =[viewHeight doubleValue];
        NSString* channelName = [NSString stringWithFormat:@"com.gstory.flutter_pangrowth/DrawVideoFullView_%lld", viewId];
        _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        _container= [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
        LCDDrawVideoViewController *vc = [[LCDDrawVideoViewController alloc] initWithConfigBuilder:^(LCDDrawVideoVCConfig * _Nonnull config) {
    //        lcs_strongify(self)
            config.showCloseButton = NO;
    //        config.out_bottomOffset = LCS_bottomHeight + 20;
    //        config.delegate = self;
    //        config.adDelegate = self;
            config.viewSize = CGSizeMake(_width, _height);
            }];
        _uvc = [[UIViewController alloc] init];
        [_uvc addChildViewController:vc];
//        vc.view.frame = CGRectMake(0, 0, _width, _height);
//        _uvc.view.frame = CGRectMake(0, 0, _width, _height);
        [_uvc.view removeFromSuperview];
        [_uvc.view addSubview:vc.view];
    }
    return self;
}

- (nonnull UIView *)view {
    return _uvc.view;
}

@end
