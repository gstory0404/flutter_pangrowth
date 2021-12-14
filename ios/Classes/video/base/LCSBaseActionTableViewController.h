//
//  LCSBaseActionTableViewController.h
//  flutter_pangrowth
//
//  Created by 郭维佳 on 2021/12/14.
//

#import <Foundation/Foundation.h>

#import "LCSActionCellView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCSBaseActionTableViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSMutableArray *> *items;

- (void)buildCells;
- (UIButton *)createCloseButtonWithRelatedVC:(UIViewController *)relatedVC;

@end

NS_ASSUME_NONNULL_END
