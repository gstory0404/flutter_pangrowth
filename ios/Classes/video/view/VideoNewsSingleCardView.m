//
//  VideoNewsSingleCardView.m
//  flutter_pangrowth
//  信息流单卡片
//  Created by gstory on 2021/12/15.
//

#import "VideoNewsSingleCardView.h"
#import <LCDSDK/LCDSDK.h>
#import "UIViewController+getCurrentVC.h"

@implementation VideoNewsSingleCardViewFactory{
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
    VideoNewsSingleCardView *view = [[VideoNewsSingleCardView alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    return view;
}

@end

@interface VideoNewsSingleCardView()
@property(nonatomic,strong) UIView<LCDNewsVideoSingleCardView> *videoNewsSingleCardView;
@property(nonatomic,strong) LCDNativeDataHolder *dataHolder;
@property(nonatomic,strong) UIView *container;
@property(nonatomic,assign) NSInteger viewId;
@property(nonatomic,strong) FlutterMethodChannel *channel;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,assign) double width;
@property(nonatomic,assign) double height;
@property (nonatomic) id<LCDViewCustomElement> element;
@end

@implementation VideoNewsSingleCardView

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
        NSString* channelName = [NSString stringWithFormat:@"com.gstory.flutter_pangrowth/VideoNewsSingleCardView_%lld", viewId];
        _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        _container= [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
        [self loadVideoNewsCard];
    }
    return self;
}

- (nonnull UIView *)view {
    return _container;
}

-(void)loadVideoNewsCard{
    [_container removeFromSuperview];
    //    LCDNewsVideoSingleCardProvider.sharedProvider.delegate = self;
    //    LCDNewsVideoSingleCardProvider.sharedProvider.adDelegate = self;
    _videoNewsSingleCardView = [LCDNewsVideoSingleCardProvider.sharedProvider buildView];
    _videoNewsSingleCardView.frame = CGRectMake(0, 0, _width, _height);
    LCDNewsVideoSingleCardProvider.sharedProvider.rootViewController = [UIViewController jsd_getCurrentViewController];
    _element  = [LCDNewsVideoSingleCardProvider.sharedProvider buildViewElement];
    [_element loadDataWithCompletion:^(id<LCDViewElement>  _Nonnull element, NSError * _Nonnull error) {
        if (error) {
            // 错误处理
            NSLog(@"%@",error.userInfo);
        } else {
            [_videoNewsSingleCardView refreshData:element];
            [_container addSubview:_videoNewsSingleCardView];
            [LCDNativeTrackManager.shareInstance trackShowEventForComponent:_videoNewsSingleCardView];
            
        }
    }];
    
    
}

@end
