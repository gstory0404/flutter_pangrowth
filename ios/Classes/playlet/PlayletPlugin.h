//
//  PlayletPlugin.h
//  flutter_pangrowth
//
//  Created by gstory on 2023/10/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayletPlugin : NSObject

# pragma mark - 打开短剧聚合页
+(void)openPlayletAggregatePage:(NSDictionary *)arguments;

# pragma mark - 打开短剧混排
+(void)openPlayletDrawVideoPage:(NSDictionary *)arguments;

# pragma mark - 打开短剧搜索
+(void)openPlayletSearchPage:(NSDictionary *)arguments;

@end

NS_ASSUME_NONNULL_END
