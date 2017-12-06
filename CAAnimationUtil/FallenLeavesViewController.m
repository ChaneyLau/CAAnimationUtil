//
//  FallenLeavesViewController.m
//  CAAnimationUtil
//
//  Created by LEA on 2017/12/6.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "FallenLeavesViewController.h"

@interface FallenLeavesViewController ()
{
    NSTimer *flowTimer;
}
@end

@implementation FallenLeavesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"落叶动画";
    
    // 背景
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"leaf_bg"];
    [self.view addSubview:imageView];
    
    // 动画定时器
    flowTimer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(downLeaf) userInfo:nil repeats:YES];
}

// 落叶
- (void)downLeaf
{
    // 使用落叶图片的角标
    NSInteger leafNumber = random() % 5;
    // 起始位置随机
    NSInteger startX = self.view.bounds.size.width;
    startX = random() % startX;
    // 结束位置随机
    NSInteger endX = self.view.bounds.size.height;
    endX = random() % endX;
    // 叶子大小随机
    CGFloat scale = 1 / (random() % 10 + 1) + 1.0;
    // 叶子下落速度随机
    CGFloat speed = 1 / (random() % 10 + 1) + 1.0;
    // 创建叶子imageView
    UIImageView *leafImageView = [[UIImageView alloc] initWithFrame:CGRectMake(startX, -30.0* scale, 30.0 * scale, 30.0 * scale)];
    leafImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"leaf_%ld",(long)leafNumber]];
    leafImageView.alpha = 0.8;
    [self.view addSubview:leafImageView];
    // 开始动画
    [UIView beginAnimations:@"leaf" context:(__bridge void * _Nullable)(leafImageView)];
    [UIView setAnimationDuration:10 * speed];
    leafImageView.frame = CGRectMake(endX, self.view.bounds.size.height, 35.0 * scale, 35.0 * scale);
    leafImageView.alpha = 1.0;
    [UIView setAnimationDidStopSelector:@selector(animationCompletion:finished:context:)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

//下落到底部，移除
- (void)animationCompletion:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    UIImageView *leafImageView = (__bridge UIImageView *)(context);
    [leafImageView removeFromSuperview];
}

#pragma mark - 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
