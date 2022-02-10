//
//  AccessUserCenterViewController.m
//  flutter_pangrowth
//
//  Created by 郭维佳 on 2022/2/10.
//

#import "AccessUserCenterViewController.h"
#import <LCDSDK/LCDSDK.h>

@interface AccessUserCenterViewController ()<UIGestureRecognizerDelegate>

@end

@implementation AccessUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0) {
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.enabled = YES;
                self.navigationController.interactivePopGestureRecognizer.delegate = self;
            }
        }
    LCDAccessUserCenterViewController *vc = [[LCDAccessUserCenterViewController alloc] initWithConfigBuilder:^(LCDAccessUserCenterVCConfig * _Nonnull config) {
//        lcs_strongify(self)
//        config.delegate = self;
//        config.viewSize = CGSizeMake(LCSScreenWidth, LCSScreenHeight-LCS_tabBarHeight);
    }];
 
    [self addChildViewController:vc];
    [self.view removeFromSuperview];
    [self.view addSubview:vc.view];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([self.navigationController.viewControllers count] == 1) {
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return true;
}

@end
