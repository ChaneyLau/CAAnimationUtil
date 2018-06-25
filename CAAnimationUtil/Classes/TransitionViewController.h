//
//  TransitionViewController.h
//  CAAnimationUtil
//
//  Created by LEA on 2017/11/3.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DURATION 0.7f

// 类型枚举
typedef NS_ENUM(NSInteger,AnimationType) {
    kAnimationTypeFade,                         //淡入淡出
    kAnimationTypeMoveIn,                       //覆盖
    kAnimationTypePush,                         //推挤
    kAnimationTypeReveal,                       //揭开
    kAnimationTypeCube,                         //3D立方体
    kAnimationTypeSuckEffect,                   //吮吸
    kAnimationTypeOglFlip,                      //翻转
    kAnimationTypeRippleEffect,                 //波纹
    kAnimationTypePageCurl,                     //翻页
    kAnimationTypePageUnCurl,                   //反翻页
    kAnimationTypeCameraIrisHollowOpen,         //开镜头
    kAnimationTypeCameraIrisHollowClose,        //关镜头
    kAnimationTypeCurlDown,                     //下翻页
    kAnimationTypeCurlUp,                       //上翻页
    kAnimationTypeFlipFromLeft,                 //左翻转
    kAnimationTypeFlipFromRight                 //右翻转
} ;

@interface TransitionViewController : UIViewController

@end

/**
 
 # 常用翻页动画
 
 */
