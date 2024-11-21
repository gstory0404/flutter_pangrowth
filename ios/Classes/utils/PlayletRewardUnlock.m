//
//  PlayletRewardUnlock.m
//  flutter_pangrowth
//
//  Created by gstory on 2024/11/21.
//

#import "PlayletRewardUnlock.h"

@implementation PlayletRewardUnlock

/// 解锁流程开始，开发者可以做一些弹框交互，比如让用户选择是否看广告等
/// - Parameters:
/// - infoModel: 短剧详情信息
/// - unlockInfoHandler: 解锁信息回传
/// - extraInfo: 附加信息(1180新增), isContinuityUnlock 是否连续解锁流程 current_unlock_episode 当前需要解锁的集
- (void)playletDetailUnlockFlowStart:(DJXPlayletInfoModel *)infoModel unlockInfoHandler:(void (^)(DJXPlayletUnlockModel * _Nonnull))unlockInfoHandler extraInfo:(NSDictionary *)extraInfo{
    NSLog(@"短剧开始解锁");
    DJXPlayletUnlockModel *unlockInfo = [[DJXPlayletUnlockModel alloc] init];
    unlockInfo.playletId = infoModel.shortplay_id;
    unlockInfo.unlockEpisodeCount = self.unlockCount;
    unlockInfo.unlockModeType = DJXPlayletUnlockModeType_Default;
    unlockInfoHandler(unlockInfo);
}

/// 显示自定义广告流程
/// - Parameters:
///   - infoModel: 短剧详情信息
///   - onADWillShow: 开始显示广告，调用通知SDK，1180及以上版本建议在广告曝光之后回传cpm
///   - onADRewardDidVerified: 激励完成，调用通知SDK
- (void)playletDetailUnlockFlowShowCustomAD:(DJXPlayletInfoModel *)infoModel onADWillShow:(void (^)(NSString * _Nonnull))onADWillShow onADRewardDidVerified:(void (^)(DJXRewardAdResult * _Nonnull))onADRewardDidVerified{
    NSLog(@"短剧自定义解锁");
}


///// 解锁流程结束，回调解锁结果
///// - Parameters:
/////   - infoModel: 短剧详情信息
/////   - success: 是否解锁成功
/////   - error: 解锁失败错误信息
////   - extraInfo: 1180新增
- (void)playletDetailUnlockFlowEnd:(DJXPlayletInfoModel *)infoModel success:(BOOL)success error:(NSError *)error extraInfo:(NSDictionary *)extraInfo{
    NSLog(@"短剧解锁完成 %@ %@ %@ %@",infoModel,success,error,extraInfo);
}

@end
