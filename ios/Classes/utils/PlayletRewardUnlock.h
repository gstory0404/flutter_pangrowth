//
//  PlayletRewardUnlock.h
//  flutter_pangrowth
//
//  Created by gstory on 2024/11/21.
//

#import <Foundation/Foundation.h>
#import <PangrowthDJX/DJXSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayletRewardUnlock: NSObject<DJXPlayletInterfaceProtocol>

//单次广告解锁多少集
@property(nonatomic,assign) NSInteger unlockCount;

@end

NS_ASSUME_NONNULL_END
