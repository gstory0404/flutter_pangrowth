//
//  PlayletCardView.h
//  flutter_pangrowth
//
//  Created by 郭维佳 on 2023/10/10.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN


@interface PlayletCardViewFactory : NSObject<FlutterPlatformViewFactory>

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messager;

@end

@interface PlayletCardView : NSObject

- (instancetype)initWithWithFrame:(CGRect)frame
                   viewIdentifier:(int64_t)viewId
                        arguments:(id _Nullable)args
                  binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;

@end

NS_ASSUME_NONNULL_END
