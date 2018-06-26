//
//  TransitionAnimationController.m
//  CAAnimationUtil
//
//  Created by LEA on 2018/6/26.
//  Copyright © 2018年 LEA. All rights reserved.
//

#import "TransitionAnimationController.h"

// 全局常量
NSString * const kCATransitionCube = @"cube";
NSString * const kCATransitionSuckEffect = @"suckEffect";
NSString * const kCATransitionOglFlip = @"oglFlip";
NSString * const kCATransitionRippleEffect = @"rippleEffect";
NSString * const kCATransitionPageCurl = @"pageCurl";
NSString * const kCATransitionPageUnCurl = @"pageUnCurl";
NSString * const kCATransitionCameraIrisHollowOpen = @"cameraIrisHollowOpen";
NSString * const kCATransitionCameraIrisHollowClose = @"cameraIrisHollowClose";

@interface TransitionAnimationController ()

// 视图
@property (nonatomic, strong) UIImageView *imageView;
// subtype
@property (nonatomic, assign) NSInteger subtype;
// 更换图片
@property (nonatomic, assign) BOOL pageAble;

@end

@implementation TransitionAnimationController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"转场动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _imageView.image = [UIImage imageNamed:@"bg_0.jpeg"];
    [self.view addSubview:_imageView];
    
    NSArray *array = [NSArray arrayWithObjects:
                      @"淡入淡出效果",
                      @"覆盖效果",
                      @"推挤效果",
                      @"揭开效果",
                      @"3D立方体效果",
                      @"吮吸效果",
                      @"翻转效果",
                      @"波纹效果",
                      @"翻页效果",
                      @"反翻页效果",
                      @"开镜头效果",
                      @"关镜头效果",
                      @"下翻页效果",
                      @"上翻页效果",
                      @"左翻转效果",
                      @"右翻转效果",nil];
    
    NSInteger count = [array count];
    CGFloat margin = 30.0;
    CGFloat btWidth = (self.view.bounds.size.width-3*margin)/2.0;
    CGFloat btHeight = 40.0;
    CGFloat x = margin,y = (self.view.bounds.size.height-64.0-7*(btHeight+20.0))/2.0;
    for (NSInteger i = 0; i < count; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, btWidth, btHeight)];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        button.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        x += btWidth + margin;
        if (i != 1 && i % 2 == 1) {
            x = margin;
            y += btHeight + 20.0;
        }
    }
    
    _subtype = 0;
    _pageAble = 0;
}

#pragma mark - 点击
- (void)btClicked:(UIButton *)sender
{
    // type
    AnimationType type = sender.tag;
    // subtype
    NSString *subtypeString = nil;
    if (_subtype == 0) {
        subtypeString = kCATransitionFromLeft;
    } else if (_subtype == 1) {
        subtypeString = kCATransitionFromBottom;
    } else if (_subtype == 2) {
        subtypeString = kCATransitionFromRight;
    } else {
        subtypeString = kCATransitionFromTop;
        _subtype = -1;
    }
    _subtype ++;
    // animation
    switch (type)
    {
        case kAnimationTypeFade:
            [self transitionWithType:kCATransitionFade subtype:subtypeString];
            break;
            
        case kAnimationTypeMoveIn:
            [self transitionWithType:kCATransitionMoveIn subtype:subtypeString];
            break;
            
        case kAnimationTypePush:
            [self transitionWithType:kCATransitionPush subtype:subtypeString];
            break;
            
        case kAnimationTypeReveal:
            [self transitionWithType:kCATransitionReveal subtype:subtypeString];
            break;
            
        case kAnimationTypeCube:
            [self transitionWithType:kCATransitionCube subtype:subtypeString];
            break;
            
        case kAnimationTypeSuckEffect:
            [self transitionWithType:kCATransitionSuckEffect subtype:subtypeString];
            break;
            
        case kAnimationTypeOglFlip:
            [self transitionWithType:kCATransitionOglFlip subtype:subtypeString];
            break;
            
        case kAnimationTypeRippleEffect:
            [self transitionWithType:kCATransitionRippleEffect subtype:subtypeString];
            break;
            
        case kAnimationTypePageCurl:
            [self transitionWithType:kCATransitionPageCurl subtype:subtypeString];
            break;
            
        case kAnimationTypePageUnCurl:
            [self transitionWithType:kCATransitionPageUnCurl subtype:subtypeString];
            break;
            
        case kAnimationTypeCameraIrisHollowOpen:
            [self transitionWithType:kCATransitionCameraIrisHollowOpen subtype:subtypeString];
            break;
            
        case kAnimationTypeCameraIrisHollowClose:
            [self transitionWithType:kCATransitionCameraIrisHollowClose subtype:subtypeString];
            break;
            
        case kAnimationTypeCurlDown:
            [self animationWithTransition:UIViewAnimationTransitionCurlDown];
            break;
            
        case kAnimationTypeCurlUp:
            [self animationWithTransition:UIViewAnimationTransitionCurlUp];
            break;
            
        case kAnimationTypeFlipFromLeft:
            [self animationWithTransition:UIViewAnimationTransitionFlipFromLeft];
            break;
            
        case kAnimationTypeFlipFromRight:
            [self animationWithTransition:UIViewAnimationTransitionFlipFromRight];
            break;
            
        default:
            break;
    }
    // image
    _pageAble = !_pageAble;
    _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg_%d.jpeg",_pageAble]];
}

#pragma mark - CATransition
- (void)transitionWithType:(NSString *)type subtype:(NSString *)subtype
{
    CATransition *animation = [CATransition animation];
    // 动画时间
    animation.duration = DURATION;
    // 动画类型
    animation.type = type;
    // 动画子类型
    if (subtype) {
        animation.subtype = subtype;
    }
    // 动画缓冲|速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [self.view.layer addAnimation:animation forKey:@"animation"];
}

#pragma mark - UIView
- (void)animationWithTransition:(UIViewAnimationTransition)transition
{
    [UIView animateWithDuration:DURATION animations:^{
        // 详见UIViewAnimationCurve
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:self.view cache:YES];
    }];
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
