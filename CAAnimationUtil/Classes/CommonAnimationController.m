//
//  CommonAnimationController.m
//  CAAnimationUtil
//
//  Created by LEA on 2018/6/26.
//  Copyright © 2018年 LEA. All rights reserved.
//

#import "CommonAnimationController.h"
#import <UUButton.h>

@interface CommonAnimationController ()

@end

@implementation CommonAnimationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"常见动画示例";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 100) / 2.0, 50, 100, 40)];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@"效果一" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(touchUpInsideAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)touchUpInsideAction
{
    PopupView *popupView = [[PopupView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [popupView show];
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

@implementation PopupView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
        [self createAnimation];
    }
    return self;
}

#pragma mark - 示例动画
- (void)createAnimation
{
    // 一行4个，2行
    CGFloat width = 60;
    CGFloat height = 90;
    CGFloat spacing = ([UIScreen mainScreen].bounds.size.width - 4 * width) / 5.0;
    CGFloat x = spacing, y = [UIScreen mainScreen].bounds.size.height - 270;
    NSArray *titles = @[@"文字",@"拍摄",@"相册",@"直播",@"光影秀",@"提问",@"签到",@"点评"];
    for (int i = 0; i < 8; i ++)  {
        UUButton *btn = [[UUButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        btn.spacing = 5;
        btn.contentAlignment = UUContentAlignmentCenterImageTop;
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"am_%d",i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(touchDragInsideAction:) forControlEvents:UIControlEventTouchDragInside];
        [btn addTarget:self action:@selector(touchDragOutsideAction:) forControlEvents:UIControlEventTouchDragOutside];
        [self addSubview:btn];
        
        x += width + spacing;
        if (i != 0 && (i + 1) % 4 == 0) {
            y += height + spacing;
            x = spacing;
        }
    }
}

// 选中
- (void)touchUpInsideAction:(UUButton *)sender
{
    // 选中的按钮
    [UIView animateWithDuration:0.25 animations:^{
        sender.transform = CGAffineTransformMakeScale(1.7,1.7);
        sender.alpha = 0;
    }];
    // 其他按钮
    NSArray *subViews = self.subviews;
    [subViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UUButton *btn = obj;
        if (btn != sender) {
            [UIView animateWithDuration:0.25 animations:^{
                btn.transform = CGAffineTransformMakeScale(0.3,0.3);
                btn.alpha = 0;
            }];
        }
    }];
    // 背景
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// 变大
- (void)touchDragInsideAction:(UUButton *)sender
{
    [UIView animateWithDuration:0.15 animations:^{
        sender.transform = CGAffineTransformMakeScale(1.2,1.2);
    }];
}

// 恢复
- (void)touchDragOutsideAction:(UUButton *)sender
{
    [UIView animateWithDuration:0.15 animations:^{
        sender.transform = CGAffineTransformMakeScale(1.0,1.0);
    }];
}

// 显示
- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    NSArray *subViews = self.subviews;
    [subViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UUButton *btn = obj;
        CGFloat top = btn.top;
        btn.alpha = 0.0;
        btn.top = [UIScreen mainScreen].bounds.size.height;
        // 加延时
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(idx * 0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.25
                                  delay:0
                 usingSpringWithDamping:0.8
                  initialSpringVelocity:30
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 btn.alpha = 1.0;
                                 btn.top = top;
                                 self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0];
                             } completion:nil];
        });
    }];
}

// 隐藏
- (void)hide
{
    // 按钮
    NSArray *subViews = self.subviews;
    NSUInteger count = [subViews count];
    [subViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UUButton *btn = obj;
        // 加延时
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((count - idx) * 0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:5.0
                                  delay:0
                 usingSpringWithDamping:0.9
                  initialSpringVelocity:5
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 btn.alpha = 0;
                                 // 移除屏幕
                                 btn.top = [UIScreen mainScreen].bounds.size.height + 50;
                             } completion:nil];
        });
    }];
    // 背景
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 点击隐藏
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hide];
}

@end
