//
//  PangrowthManager.m
//  flutter_pangrowth
//
//  Created by gstory on 2021/12/3.
//

#import "PangrowthManager.h"

@interface PangrowthManager()
@property (nonatomic, strong) UINavigationController *nav;
@end

@implementation PangrowthManager

+ (instancetype)sharedInstance{
    static PangrowthManager *myInstance = nil;
    if(myInstance == nil){
        myInstance = [[PangrowthManager alloc]init];
    }
    return myInstance;
}

@end
