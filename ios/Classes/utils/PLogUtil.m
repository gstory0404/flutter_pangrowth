//
//  LogUtil.m
//  flutter_tencentad
//
//  Created by gstory on 2021/12/1.
//

#import <Foundation/Foundation.h>
#import "PLogUtil.h"

@interface PLogUtil()
@property(nonatomic,assign) BOOL isDebug;
@end


@implementation PLogUtil

+ (instancetype)sharedInstance{
    static PLogUtil *myInstance = nil;
    if(myInstance == nil){
        myInstance = [[PLogUtil alloc]init];
    }
    return myInstance;
}

- (void)debug:(BOOL)isDebug{
    _isDebug = isDebug;
}

- (void)print:(NSString *)message{
    if(_isDebug){
        NSLog(@"%@", message);
    }
}

@end
