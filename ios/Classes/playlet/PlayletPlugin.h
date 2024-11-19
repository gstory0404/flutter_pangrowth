//
//  PlayletPlugin.h
//  flutter_pangrowth
//
//  Created by gstory on 2023/10/10.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayletPlugin : NSObject

# pragma mark - 初始化视频
+(void)registerPlaylet:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 打开短剧聚合页
+(void)openPlayletAggregatePage:(NSDictionary *)arguments;

# pragma mark - 分页拉取所有短剧
+(void)requestAllPlayletListPage:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 短剧推荐列表
+(void)requestRecommendedPlayletListPage:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 短剧全部列表
+(void)requestAllPlayletListWithOrder:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 短剧列表(根据短剧id获取)
+(void)requestPlayletListWithPlayletId:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 根据搜索关键词获取列表
+(void)requestCategoryPlayletLisWithSearchWord:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 短剧分类列表
+(void)requestCategoryList:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 根据分类获取列表
+(void)requestCategoryPlayletLisWithCategory:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 进入播放页
+(void)enterPlayletPlayer:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 短剧历史记录列表
+(void)requestPlayletHistoryListWithPage:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 短剧历史记录清除
+(void)requestPlayletHistoryCleanWithCompletion:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 点赞某一集短剧
+(void)likeShortplay:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 取消点赞某一集短剧
+(void)cancelLikeShortplay:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 收藏某部剧
+(void)collectShortplay:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 取消收藏某部剧
+(void)cancelCollectShortplay:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 短剧收藏列表
+(void)requestCollectionList:(NSDictionary *)dic result:(FlutterResult)result;

@end

NS_ASSUME_NONNULL_END
