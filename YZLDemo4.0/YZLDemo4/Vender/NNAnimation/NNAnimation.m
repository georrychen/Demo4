//
//  NNAnimation.m
//  Demo_268EDU
//
//  Created by 刘朋坤 on 2018/8/10.
//  Copyright © 2018年 Magic. All rights reserved.
//

#import "NNAnimation.h"
 #define angle2Radio(angle) ((angle) * M_PI / 180.0)

@implementation NNAnimation

#pragma mark - 帧动画
/** 抖动动画 */
+ (void)addShakeAnimationWithLayer:(CALayer *)layer {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.values = @[@(angle2Radio(-10)), @(angle2Radio(10)), @(angle2Radio(-10))];
    animation.repeatCount = MAXFLOAT;
    [layer addAnimation:animation forKey:nil];
}

/** 缩放动画 */
+ (void)addAnimationWithCALayer:(CALayer *)layer interval:(CFTimeInterval)interval repeatCount:(NSInteger)repeatCount fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:fromValue];
    scaleAnimation.toValue = [NSNumber numberWithFloat:toValue];
    scaleAnimation.duration = interval;
    scaleAnimation.repeatCount = repeatCount;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:scaleAnimation forKey:nil];
}

@end
