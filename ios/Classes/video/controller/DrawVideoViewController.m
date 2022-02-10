//
//  DrawVideoViewController.m
//  flutter_pangrowth
//
//  Created by 郭维佳 on 2022/2/10.
//

#import "DrawVideoViewController.h"
#import <LCDSDK/LCDSDK.h>

@interface DrawVideoViewController ()<UIGestureRecognizerDelegate>

@end

@implementation DrawVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0) {
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.enabled = YES;
                self.navigationController.interactivePopGestureRecognizer.delegate = self;
            }
        }
 
    LCDDrawVideoViewController *vc = [[LCDDrawVideoViewController alloc] initWithConfigBuilder:^(LCDDrawVideoVCConfig * _Nonnull config) {
//        lcs_strongify(self)
        config.showCloseButton = YES;
//        config.out_bottomOffset = LCS_bottomHeight + 20;
//        config.delegate = self;
//        config.adDelegate = self;
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
