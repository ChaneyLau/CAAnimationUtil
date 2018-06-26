//
//  BasicAnimationController.m
//  CAAnimationUtil
//
//  Created by LEA on 2018/6/26.
//  Copyright © 2018年 LEA. All rights reserved.
//

#import "BasicAnimationController.h"

@interface BasicAnimationController ()

@property (nonatomic, strong) UIView *moveView;
@property (nonatomic, strong) UIView *rotateView;
@property (nonatomic, strong) UIView *zoomView;
@property (nonatomic, strong) UIView *groupView;
@property (nonatomic, strong) UIView *springView;

@end

@implementation BasicAnimationController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"基础动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = 70.0;
    CGFloat margin = (self.view.bounds.size.width - 70.0)/2.0;
    CGFloat top = (self.view.bounds.size.height- 5 * 100.0 - 70.0)/2.0;
    
    // 显示移动效果
    _moveView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, top, width, width)];
    _moveView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_moveView];
    [self move];
    
    // 显示旋转效果
    _rotateView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, top + 100, width, width)];
    _rotateView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_rotateView];
    [self rotate];
    
    // 显示缩放效果
    _zoomView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, top + 200, width, width)];
    _zoomView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_zoomView];
    [self zoom];
    
    // 显示组合动画效果
    _groupView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, top + 300, width, width)];
    _groupView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_groupView];
    [self group];
    
    // 显示弹框效果
    _springView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, top + 400, width, width)];
    _springView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_springView];
    [self spring];
}

#pragma mark - 动画效果<移动、旋转、缩放、组合动画、弹簧>

// 移动
- (void)move
{
    // 位置移动
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 1秒后执行
    animation.beginTime = CACurrentMediaTime() + 1;
    // 持续时间
    animation.duration = 2.5;
    // 重复次数
    animation.repeatCount = 2;
    // 起始位置
    animation.fromValue = [NSValue valueWithCGPoint:_moveView.layer.position];
    // 终止位置
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(_moveView.layer.position.x + 100, _moveView.layer.position.y)];
    // 添加动画
    [_moveView.layer addAnimation:animation forKey:@"move"];
}

// 旋转
- (void)rotate
{
    // 对Y轴进行旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    // 1秒后执行
    animation.beginTime = CACurrentMediaTime() + 1;
    // 持续时间
    animation.duration = 2.5;
    // 重复次数
    animation.repeatCount = 2;
    // 起始角度
    animation.fromValue = @(0.0);
    // 终止角度
    animation.toValue = @(2 * M_PI);
    // 添加动画
    [_rotateView.layer addAnimation:animation forKey:@"rotate"];
}

// 缩放
- (void)zoom
{
    // 比例缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 1秒后执行
    animation.beginTime = CACurrentMediaTime() + 1;
    // 持续时间
    animation.duration = 2.5;
    // 重复次数
    animation.repeatCount = 2;
    // 起始scale
    animation.fromValue = @(1.0);
    // 终止scale
    animation.toValue = @(1.5);
    // 添加动画
    [_zoomView.layer addAnimation:animation forKey:@"zoom"];
}

// 组合动画
- (void)group
{
    // x方向平移
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    // 平移100
    animation1.toValue = @(100);
    
    // 绕Z轴中心旋转
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 起始角度
    animation2.fromValue = [NSNumber numberWithFloat:0.0];
    // 终止角度
    animation2.toValue = [NSNumber numberWithFloat:2 * M_PI];
    
    // 比例缩放
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 终止scale
    animation3.toValue = @(0.5);
    
    // 动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    // 1秒后执行
    group.beginTime = CACurrentMediaTime() + 1;
    // 持续时间
    group.duration = 2.5;
    // 重复次数
    group.repeatCount = 2;
    // 动画结束是否恢复原状
    group.removedOnCompletion = YES;
    // 添加动画
    group.animations = [NSArray arrayWithObjects:animation1, animation2, animation3, nil];
    // 添加动画
    [_groupView.layer addAnimation:group forKey:@"group"];
}

// 弹簧
- (void)spring
{
    // 位置移动
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"position"];
    // 1秒后执行
    animation.beginTime = CACurrentMediaTime() + 1;
    // 阻尼系数（此值越大弹框效果越不明显）
    animation.damping = 2;
    // 刚度系数（此值越大弹框效果越明显）
    animation.stiffness = 50;
    // 质量大小（越大惯性越大）
    animation.mass = 1;
    // 初始速度
    animation.initialVelocity = 10;
    // 开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:_springView.layer.position]];
    // 终止位置
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(_springView.layer.position.x, _springView.layer.position.y + 50)]];
    // 持续时间
    animation.duration = animation.settlingDuration;
    // 添加动画
    [_springView.layer addAnimation:animation forKey:@"spring"];
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
