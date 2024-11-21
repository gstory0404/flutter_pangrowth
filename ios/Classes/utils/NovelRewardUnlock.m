//
//  NovelRewardUnlock.m
//  flutter_pangrowth
//
//  Created by 郭维佳 on 2024/11/21.
//

#import "NovelRewardUnlock.h"

@implementation NovelRewardUnlock

/// 开始阅读
/// - Parameter sessionContext: 内容SDK和宿主交互的上下文数据
- (void)mns_startReading:(MNStorySessionContext *)sessionContext{
    NSLog(@"短小说开始阅读");
}

/// 是否要展示激励入口
/// - Parameter sessionContext: 内容SDK和宿主交互的上下文数据
- (BOOL)mns_shouldShowEntryView:(MNStorySessionContext *)sessionContext{
    return NO;
}

/// 激励解锁流程开始，激励入口点击后，SDK会调用此回调接口
/// - Parameter sessionContext: 内容SDK和宿主交互的上下文数据
- (void)mns_onUnlockFlowStart:(MNStorySessionContext *)sessionContext{
    NSLog(@"短小说开始广告解锁");
}

/// 自定义激励广告
/// - Parameter sessionContext: 内容SDK和宿主交互的上下文数据
/// - Parameter onADWillShow: 开始显示广告，调用通知SDK
/// - Parameter onADRewardDidVerified: 开发者激励广告结束，将激励结果告知内容SDK
- (void)mns_showCustomAD:(MNStorySessionContext *)sessionContext
            onADWillShow:(void (^)(NSString * cpm))onADWillShow
   onADRewardDidVerified:(void (^)(MNStoryRewardADResult *rewardResult))onADRewardDidVerified{
    NSLog(@"短小说自定义广告");
}

/// 解锁流程结束
/// - Parameter sessionContext: 内容SDK和宿主交互的上下文数据
- (void)mns_onUnlockFlowEnd:(MNStorySessionContext *)sessionContext success:(BOOL)success error:(NSError * _Nullable)error{
    NSLog(@"短小说广告解锁结束");
}




@end
