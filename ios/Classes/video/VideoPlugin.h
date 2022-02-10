//
//  VideoPlugin.h
//  flutter_pangrowth
//
//  Created by gstory on 2021/12/13.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <LCDSDK/LCDSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlugin : NSObject

# pragma mark - 初始化视频
+(void)registerVideo:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 打开沉浸式小视频场景展示：全屏样式
+(void)openDrawVideoFull;

# pragma mark - 打开宫格小视频 全屏样式
+(void)openGridVideo;

# pragma mark - 打开新闻 多列表 全屏样式
+(void)openNewsTabs;

# pragma mark - 打开新闻 单列表 全屏样式
+(void)openNewsTabOne;

# pragma mark - 打开个人主页
+(void)openUserCenter;

# pragma mark - 信息流数据获取
+(void)getFeedNativeData:(NSDictionary *)dic result:(FlutterResult)result;
    
@end

NS_ASSUME_NONNULL_END
