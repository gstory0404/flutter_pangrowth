//
//  VideoSingleCardView.m
//  flutter_pangrowth
//
//  Created by gstory on 2021/12/15.
//

#import "VideoSingleCardView.h"
#import <LCDSDK/LCDSDK.h>
#import "UIViewController+getCurrentVC.h"

@implementation VideoSingleCardViewFactory{
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
    VideoSingleCardView *view = [[VideoSingleCardView alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    return view;
}

@end

@interface VideoSingleCardView()
@property(nonatomic,strong) UIView<LCDVideoSingleCardView> *videoSingleCardView;
@property(nonatomic,strong) LCDNativeDataHolder *dataHolder;
@property(nonatomic,strong) UIView *container;
@property(nonatomic,assign) NSInteger viewId;
@property(nonatomic,strong) FlutterMethodChannel *channel;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,assign) double width;
@property(nonatomic,assign) double height;
@property (nonatomic) id<LCDViewCustomElement, LCDSmartCroppableElement> element;
@end

@implementation VideoSingleCardView

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
        NSString* channelName = [NSString stringWithFormat:@"com.gstory.flutter_pangrowth/VideoSingleCardView_%lld", viewId];
        _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        _container= [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
        [self loadVideoCard];
    }
    return self;
}

- (nonnull UIView *)view {
    return _container;
}

-(void) loadVideoCard{
    [_container removeFromSuperview];
    LCDVideoSingleCardProvider.sharedProvider.shouldShowPlayIcon = YES;
    LCDVideoSingleCardProvider.sharedProvider.shouldShowTitle = NO;//不展示标题
    _element = [LCDVideoSingleCardProvider.sharedProvider buildViewElement];
    CGSize cardSize = CGSizeMake(_width, _height); // 需要和-[LCDVideoSingleCardView smartCropSize]的值一致
    [_element configSmartCropSize:cardSize];
    [_element loadDataWithCompletion:^(id<LCDViewElement>  _Nonnull element, NSError * _Nonnull error) {
        
        if (error) {
            // 错误处理
            NSLog(@"%@",error.userInfo);
        } else {
            _videoSingleCardView = [LCDVideoSingleCardProvider.sharedProvider buildView];
            _videoSingleCardView.frame = CGRectMake(0, 0, cardSize.width, cardSize.height);
            [_videoSingleCardView refreshData:element];
            [_container addSubview:_videoSingleCardView];
            [LCDNativeTrackManager.shareInstance trackShowEventForComponent:_videoSingleCardView];
            
        }
    }];
}
@end
