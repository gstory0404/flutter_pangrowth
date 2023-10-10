//
//  PlayletCardView.m
//  flutter_pangrowth
//
//  Created by 郭维佳 on 2023/10/10.
//

#import "PlayletCardView.h"
#import <LCDSDK/LCDSDK.h>
#import "UIViewController+getCurrentVC.h"

@implementation PlayletCardViewFactory{
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
    PlayletCardView *view = [[PlayletCardView alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    return view;
}

@end

@interface PlayletCardView()<LCDPlayletCardDelegate>
@property(nonatomic,strong) UIView *container;
@property(nonatomic,strong) LCDPlayletCard *playletCard;
@property(nonatomic,strong) FlutterMethodChannel *channel;
@property(nonatomic,assign) double width;
@property(nonatomic,assign) double height;
@property(nonatomic,assign) bool autoPlay;
@property(nonatomic,assign) bool loop;
@property(nonatomic,assign) bool mute;
@property(nonatomic,strong) UIViewController *uvc;
@end

@implementation PlayletCardView

- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    if ([super init]) {
        NSLog(@"%@",args);
        NSDictionary *nsd = args;
        _autoPlay =[nsd[@"autoPlay"] boolValue];
        _loop =[nsd[@"loop"] boolValue];
        _mute =[nsd[@"mute"] boolValue];
        NSNumber *viewWidth = nsd[@"width"];
        NSNumber *viewHeight = nsd[@"height"];
        _width =[viewWidth doubleValue];
        _height =[viewHeight doubleValue];
        NSString* channelName = [NSString stringWithFormat:@"com.gstory.flutter_pangrowth/PlayletCardView_%lld", viewId];
        _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        _container= [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
        [self loadCardView];
    }
    return self;
}

- (nonnull UIView *)view {
    return _container;
}

-(void)loadCardView{
    NSLog(@"短剧卡片准备加载");
    _playletCard = [[LCDPlayletCard alloc] initWithConfig:^(LCDPlayletCardConfig * _Nonnull cardConfig) {
        cardConfig.skit_id = 16;
        cardConfig.frame = CGRectMake(0, 0, 160, 100);
        //是否自动播放，默认YES
        cardConfig.autoPlay = _autoPlay;
        //是否是否循环播放播放，默认YES
        cardConfig.loop = _loop;
        //是否静音，默认YES
        cardConfig.mute = _mute;
        cardConfig.hidePlayButton = NO;
        cardConfig.hideMuteButton = NO;
    }];
    _playletCard.delegate = self;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapPlayletCard:)];
    [_playletCard addGestureRecognizer:tapGestureRecognizer];
    [_container removeFromSuperview];
    [_container addSubview:_playletCard];
}

- (void)onTapPlayletCard:(UITapGestureRecognizer *)sender {
    LCDPlayletConfig *config = [[LCDPlayletConfig alloc] init];
    config.entranceType = LCDPlayletEntranceTypeCard;
    config.groupId = _playletCard.playletInfo.group_id;
    config.skitId = _playletCard.playletInfo.skit_id;
    config.episode = _playletCard.playletInfo.current_episode;
    config.playletMode = LCDPlayletModeOptions_Interface;
    LCDDrawVideoViewController *vc = [[LCDPlayletManager shareInstance] playletViewControllerWithParams:config];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [[UIViewController jsd_getCurrentViewController] presentViewController:vc animated:YES completion:^{}];
}

#pragma mark - 卡片加载delegate
/// 短剧卡片加载数据，成功playletData有值，失败error有值
/// - Parameters:
///   - playletCard: 短剧卡片
///   - playletData: 短剧卡片数据
///   - error: 失败原因
- (void)playletCard:(LCDPlayletCard *)playletCard didLoadData:(LCDPlayletInfoModel *)playletData error:(nullable NSError *)error{
    NSLog(@"短剧卡片加载结束%@",error);
    if(error == nil){
        NSDictionary *dictionary = @{@"width": @(playletCard.frame.size.width),@"height":@(playletCard.frame.size.height)};
        [_channel invokeMethod:@"onShow" arguments:dictionary result:nil];
    }else{
        NSDictionary *dictionary = @{@"code":@(-1),@"message":@"短剧卡片加载失败"};
        [_channel invokeMethod:@"onFail" arguments:dictionary result:nil];
    }
}

/// 播放器回调
/// 第一帧回调
- (void)playletCardReadyToDisplay:(LCDPlayletCard *)playletCard{
    NSLog(@"短剧卡片播放第一帧");
}
/// 即将开始播放
- (void)playletCardReadyToPlay:(LCDPlayletCard *)playletCard{
    NSLog(@"短剧卡片即将开始播放");
}
/// 播放状态切换
- (void)playletCard:(LCDPlayletCard *)playletCard playbackStateDidChanged:(LCDPlayletCardPlaybackState)playbackState{
    NSLog(@"短剧卡片播放状态切换");
}
/// 手动stop
- (void)playletCardUserStopped:(LCDPlayletCard *)playletCard{
    NSLog(@"短剧卡片播放手动停止");
}
/// finish，正常结束，异常结束error或者statusCode会有值
- (void)playletCardDidFinish:(LCDPlayletCard *)playletCard error:(nullable NSError *)error videoStatusException:(NSInteger)statusCode{
    NSLog(@"短剧卡片播放结束%@%@",error,statusCode);
}

@end
