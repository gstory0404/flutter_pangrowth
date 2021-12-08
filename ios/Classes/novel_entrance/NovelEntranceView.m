//
//  NovelEntranceView.m
//  flutter_pangrowth
//
//  Created by gstory on 2021/12/7.
//

#import "NovelEntranceView.h"
#import "BDNovelEntrance.h"

@implementation NovelEntranceViewFactory{
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
    NovelEntranceView * novelEntranceView = [[NovelEntranceView alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    
    return novelEntranceView;
    
}

@end

@interface NovelEntranceView()
@property(nonatomic,strong) BDNovelEntrance *bdNovelEntrance;
@property(nonatomic,strong) UIView *container;
@property(nonatomic,assign) NSInteger viewId;
@property(nonatomic,strong) FlutterMethodChannel *channel;
@property(nonatomic,strong) NSNumber *type;
@property(nonatomic,strong) NSNumber *width;
@property(nonatomic,strong) NSNumber *height;
@end

@implementation NovelEntranceView

- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    if ([super init]) {
        NSLog(@"%@",args);
        _viewId = viewId;
        _type = args[@"type"];
        _width =args[@"viewWidth"];
        _height =args[@"viewWidth"];
        NSString* channelName = [NSString stringWithFormat:@"com.gstory.flutter_pangrowth/NovelEntranceView_%lld", viewId];
               _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        self.container= [[UIView alloc] initWithFrame:frame];
        [self loadBdNovelEntrance];
    }
    return self;
}

- (nonnull UIView *)view {
    return _container;
}

-(void) loadBdNovelEntrance{
    _bdNovelEntrance = [[BDNovelEntrance alloc] init];
    BDNovelEntranceConfig *config = [[BDNovelEntranceConfig alloc] init];
    config.frame = CGRectMake(0, 0, [_width floatValue], [_height floatValue]);
    config.entranceKind = BDNovelEntranceKindKingKong;
    _bdNovelEntrance.config = config;
    [_container addSubview:_bdNovelEntrance];
    [_bdNovelEntrance entranceShow];
}


@end
