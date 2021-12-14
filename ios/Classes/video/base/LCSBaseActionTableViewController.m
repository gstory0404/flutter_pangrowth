//
//  LCSBaseActionTableViewController.m
//  flutter_pangrowth
//
//  Created by 郭维佳 on 2021/12/14.
//

#import "LCSBaseActionTableViewController.h"
#import "UIView+LCSAddition.h"

@interface LCSBaseActionTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LCSBaseActionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buidTableView];
    [self buildCells];
}

- (void)buidTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[LCSActionCellView class] forCellReuseIdentifier:@"LCSActionCellView"];
    [self.view addSubview:self.tableView];
}

- (void)buildCells {
    NSAssert(0, @"子类必须重写buildCells");
}

- (UIButton *)createCloseButtonWithRelatedVC:(UIViewController *)relatedVC {
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.relatedViewController = relatedVC;
    closeButton.frame = CGRectMake(15, LCS_stautsBarHeight, 24, 24);
    [closeButton setImage:[UIImage imageNamed:@"LCS_closeButton_black"] forState:UIControlStateNormal];
    [closeButton setImage:[UIImage imageNamed:@"LCS_closeButton_black"] forState:UIControlStateSelected];
    [closeButton addTarget:self action:@selector(didClickCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    return closeButton;
}

- (void)didClickCloseButton:(UIButton *)button {
    [button.relatedViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionItems = self.items[section];
    return sectionItems.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sectionItems = self.items[indexPath.section];
    LCSActionModel *model = sectionItems[indexPath.row];
    LCSActionCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"LCSActionCellView" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LCSActionCellView *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell execute];
}

@end
