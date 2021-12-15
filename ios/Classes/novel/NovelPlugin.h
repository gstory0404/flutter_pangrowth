//
//  NovelPlugin.h
//  flutter_pangrowth
//
//  Created by gstory on 2021/12/13.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface NovelPlugin : NSObject

# pragma mark - 字典转json格式字符串：
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

# pragma mark - 初始化小说
+(void)registerNovel:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 打开小说主页
+(void)openNovelPage:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 获取阅读历史，单本
+(void)getNovelHistory:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 获取启动后推荐书列表，信息较少
+(void)getNovelRecommendV1:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 获取Feed推荐书列表，信息较多
+(void)getNovelRecommendFeed:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 为了更精准推荐书籍，当显示getReadConfigWithParam获得的书时，调用此接口,上报埋点增强推荐能力
+(void)reportRecentNovelShow:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 打开小说页面
+(void)openNovelPageWithConfig:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 打开小说页面url
+(void)openNovelPageWithUrl:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 小说搜索推荐
+(void)searchNovelSuggestions:(NSDictionary *)dic result:(FlutterResult)result;

# pragma mark - 小说搜索结果
+(void)searchNovelResults:(NSDictionary *)dic result:(FlutterResult)result;
    
@end

NS_ASSUME_NONNULL_END
