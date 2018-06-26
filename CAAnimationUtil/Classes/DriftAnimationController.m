//
//  DriftAnimationController.m
//  CAAnimationUtil
//
//  Created by LEA on 2018/6/26.
//  Copyright © 2018年 LEA. All rights reserved.
//

#import "DriftAnimationController.h"

@interface DriftAnimationController ()
{
    NSTimer *fallTimer;
}
@end

@implementation DriftAnimationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"漂移动画";
    self.view.backgroundColor = [UIColor whiteColor];
    // 动画定时器
    fallTimer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(fallAction) userInfo:nil repeats:YES];
}

// 下落
- (void)fallAction
{
    // 起始位置随机
    NSInteger startX = self.view.bounds.size.width;
    startX = random() % startX;
    // 结束位置随机
    NSInteger endX = self.view.bounds.size.height;
    endX = random() % endX;
    // 下落速度随机
    CGFloat speed = 1 / (random() % 10 + 1) + 1.0;
    // 创建视图
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(startX, -30.0, 30.0, 30.0)];
    downView.backgroundColor = [UIColor redColor];
    [self.view addSubview:downView];
    // 开始动画
    [UIView beginAnimations:@"drift" context:(__bridge void * _Nullable)(downView)];
    [UIView setAnimationDuration:10 * speed];
    downView.frame = CGRectMake(endX, self.view.bounds.size.height, 30.0, 30.0);
    [UIView setAnimationDidStopSelector:@selector(animationCompletion:finished:context:)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

// 下落到底部，移除
- (void)animationCompletion:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    // PS：多个动画的时候，可通过animationID区分
    UIView *downView = (__bridge UIView *)(context);
    [downView removeFromSuperview];
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
