//
//  NovelEntity.h
//  flutter_pangrowth
//
//  Created by gstory on 2021/12/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NovelData : NSObject

@property(nonatomic, strong) NSString *readUrl;

@property(nonatomic, strong) NSString *bookName;

@property(nonatomic, strong) NSString *thumbUrl;

@property(nonatomic, strong) NSNumber *type;

@property(nonatomic, strong) NSString *novelDetail;

@end



@interface NovelEntity : NSObject

@property(nonatomic, strong) NSNumber *code;

@property(nonatomic, strong) NSString *msg;

@property(nonatomic, strong) NSArray *data;

@end

NS_ASSUME_NONNULL_END
