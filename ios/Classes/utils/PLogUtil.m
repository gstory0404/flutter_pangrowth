//
//  LogUtil.m
//  flutter_tencentad
//
//  Created by gstory on 2021/12/1.
//

#import <Foundation/Foundation.h>
#import "PLogUtil.h"

@interface LogUtil()
@property(nonatomic,assign) BOOL isDebug;
@end


@implementation LogUtil

+ (instancetype)sharedInstance{
    static LogUtil *myInstance = nil;
    if(myInstance == nil){
        myInstance = [[LogUtil alloc]init];
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
