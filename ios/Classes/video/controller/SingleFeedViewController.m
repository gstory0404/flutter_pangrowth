//
//  SingleFeedViewController.m
//  flutter_pangrowth
//
//  Created by 郭维佳 on 2022/2/10.
//

#import "SingleFeedViewController.h"
#import <LCDSDK/LCDSDK.h>

@interface SingleFeedViewController ()<UIGestureRecognizerDelegate>

@end

@implementation SingleFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LCDSingleFeedViewController *vc = [[LCDSingleFeedViewController alloc] initWithConfigBuilder:^(LCDSingleFeedVCConfig * _Nonnull config) {
        config.category = @"__all__";
//        config.delegate = self;
//        config.adDelegate = self;
        config.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    }];
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0) {
            if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.navigationController.interactivePopGestureRecognizer.enabled = YES;
                self.navigationController.interactivePopGestureRecognizer.delegate = self;
            }
        }
 
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
