//
//  NovelPlugin.h
//  flutter_pangrowth
//
//  Created by gstory on 2023/10/10.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface NovelPlugin : NSObject

# pragma mark - 初始化短小说
+(void)registerNovel:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 打开短小说聚合页
+(void)openNovelAggregatePage:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 打开短故事阅读器
+(void)openMiniStory:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 查询类目列表
+(void)requestNovelCategoryList:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 短故事搜素
+(void)requestStoryListWithSearchWord:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 短故事按照book_id查询
+(void)requestStoryListWithBookId:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 查询所有短故事
+(void)requestAllStoryListPage:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 根据排序方式，查询短故事列表
+(void)requestAllStoryListWithOrder:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 根据类目id查询短故事列表
+(void)requestCategoryStoryListWithCategoryId:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 查询历史记录列表
+(void)requestHistoryStoryList:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 收藏短故事
+(void)requestCollectStory:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 取消收藏短故事
+(void)requestCancelCollectStory:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 获取短故事的收藏列表
+(void)requestStoryCollectionList:(NSDictionary *)dic result:(FlutterResult)result;


@end

NS_ASSUME_NONNULL_END
