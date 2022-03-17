//
//  GridVideoViewController.m
//  flutter_pangrowth
//
//  Created by 郭维佳 on 2022/2/10.
//

#import "GridVideoViewController.h"
#import <LCDSDK/LCDSDK.h>

@interface GridVideoViewController ()<UIGestureRecognizerDelegate>

@end

@implementation GridVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LCDGridVideoViewController *vc = [[LCDGridVideoViewController alloc] initWithConfigBuilder:^(LCDGridVideoVCConfig * _Nonnull config) {
        config.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        config.viewSize = CGSizeMake(_width, _height);
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
