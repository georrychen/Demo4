//
//  NNAnimation.h
//  Demo_268EDU
//
//  Created by 刘朋坤 on 2018/8/10.
//  Copyright © 2018年 Magic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NNAnimation : NSObject

#pragma mark - 帧动画

/** 抖动动画 */
+ (void)addShakeAnimationWithLayer:(CALayer *)layer;
/** 缩放动画 */
+ (void)addAnimationWithCALayer:(CALayer *)layer interval:(CFTimeInterval)interval repeatCount:(NSInteger)repeatCount fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue;

@end
