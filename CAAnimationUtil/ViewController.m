//
//  ViewController.m
//  CAAnimationUtil
//
//  Created by LEA on 2017/11/2.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "ViewController.h"
#import "BasicAnimationController.h"
#import "TransitionAnimationController.h"
#import "DriftAnimationController.h"
#import "CommonAnimationController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"基础动画";
    } else if (indexPath.row == 1){
        cell.textLabel.text = @"转场动画";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"漂移动画";
    } else {
        cell.textLabel.text = @"常见动画";
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        BasicAnimationController *controller = [[BasicAnimationController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    } else if (indexPath.row == 1) {
        TransitionAnimationController *controller = [[TransitionAnimationController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    } else if (indexPath.row == 2) {
        DriftAnimationController *controller = [[DriftAnimationController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        CommonAnimationController *controller = [[CommonAnimationController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
