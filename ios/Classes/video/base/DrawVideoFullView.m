//
//  MyView.m
//  flutter_pangrowth
//
//  Created by 郭维佳 on 2021/12/14.
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
//@property(nonatomic,strong) BDNovelEntrance *entrance;
@property(nonatomic,strong) UIView *container;
@property(nonatomic,assign) NSInteger viewId;
@property(nonatomic,strong) FlutterMethodChannel *channel;
@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSString *style;
@property(nonatomic,assign) double width;
@property(nonatomic,assign) double height;
@end

@implementation DrawVideoFullView

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
        NSString* channelName = [NSString stringWithFormat:@"com.gstory.flutter_pangrowth/DrawVideoFullView_%lld", viewId];
        _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        _container= [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
    }
    return self;
}

- (nonnull UIView *)view {
    LCDDrawVideoViewController *vc = [[LCDDrawVideoViewController alloc] init];
    [_container removeFromSuperview];
    vc.view.frame = CGRectMake(0, 0, _width, _height);
    [_container addSubview:vc.view];
    return _container;
}

@end
