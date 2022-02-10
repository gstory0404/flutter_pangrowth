//
//  FeedExploreViewController.m
//  flutter_pangrowth
//
//  Created by 郭维佳 on 2022/2/10.
//

#import "FeedExploreViewController.h"
#import <LCDSDK/LCDSDK.h>

@interface FeedExploreViewController ()<UIGestureRecognizerDelegate>

@end

@implementation FeedExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LCDFeedExploreViewController *vc = [[LCDFeedExploreViewController  alloc] initWithConfigBuilder:^(LCDFeedExploreVCConfig * _Nonnull config) {
        
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
