//
//  VideoTextChainView.m
//  flutter_pangrowth
//
//  Created by gstory on 2021/12/15.
//

#import "VideoTextChainView.h"
#import <LCDSDK/LCDSDK.h>
#import "UIViewController+getCurrentVC.h"

@implementation VideoTextChainViewFactory{
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
    VideoTextChainView *view = [[VideoTextChainView alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    return view;
}

@end

@interface VideoTextChainView()
@property(nonatomic,strong) LCDHotNewsTextGuideView *textChainView;
@property(nonatomic,strong) LCDNativeDataHolder *dataHolder;
@property(nonatomic,strong) UIView *container;
@property(nonatomic,assign) NSInteger viewId;
@property(nonatomic,strong) FlutterMethodChannel *channel;
@property(nonatomic,assign) double width;
@property(nonatomic,assign) double height;
@end

@implementation VideoTextChainView

- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    if ([super init]) {
        NSLog(@"%@",args);
        NSDictionary *nsd = args;
        _viewId = viewId;
        NSNumber *viewWidth = nsd[@"viewWidth"];
        NSNumber *viewHeight = nsd[@"viewHeight"];
        _width =[viewWidth doubleValue];
        _height =[viewHeight doubleValue];
        NSString* channelName = [NSString stringWithFormat:@"com.gstory.flutter_pangrowth/VideoTextChainView_%lld", viewId];
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
    _textChainView = [[LCDHotNewsTextGuideView alloc] initWithFrame:CGRectMake(0, 0, _width, _height) configBlock:^(LCDHotNewsTextGuideViewConfig * _Nullable config) {
        // -[LCDNativeTrackManager trackShowEventForComponent:]需要使用的参数
        config.trackComponentPosition = LCDTrackComponentPosition_home;
        config.rootVC = [UIViewController jsd_getCurrentViewController];
    }];
    [_container removeFromSuperview];
    [_container addSubview:_textChainView];
    _dataHolder = [LCDNativeDataHolder dataHolderWithSceneType:LCDNativeDataHolderSceneType_textChain];
//    _dataHolder.smartCropSize = _textChainView.smartCropSize;
    [_dataHolder loadDataWithCompletion:^(NSArray<LCDNativeDataModel *> * _Nullable models, NSDictionary * _Nullable extra, NSError * _Nullable error) {
            if (self) {
                if (models.count > 0) {
                    // 使用dataHolder填充组件
                    [_textChainView reloadDataWithDataHolder:_dataHolder];
                    // 这里可以通过LCDSDK完成组件的show埋点
                    [LCDNativeTrackManager.shareInstance trackShowEventForComponent:_textChainView];
                }
            }
        }];
}

@end
