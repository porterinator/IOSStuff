//
//  AnimationHelper.m
//  LoginAnimations
//
//  Created by Admin on 15/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "AnimationHelper.h"

@implementation AnimationHelper

+ (CABasicAnimation *) getStrokeAnimation
{
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 2.0;
    drawAnimation.repeatCount         = 1.0;
    
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return drawAnimation;
}

+ (CABasicAnimation *)getBiggerAnimation: (CALayer *)layer oldBounds:(CGRect) oldBounds newBounds: (CGRect)newBounds
{
    CABasicAnimation *biggerAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    biggerAnimation.duration            = .5;
    biggerAnimation.repeatCount         = 1.0;
    biggerAnimation.beginTime = [layer convertTime:CACurrentMediaTime() toLayer:nil] + 0.3;
    
    biggerAnimation.fromValue = [NSValue valueWithCGRect:oldBounds];
    biggerAnimation.toValue   = [NSValue valueWithCGRect:newBounds];
    
    biggerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return biggerAnimation;
}

+ (CABasicAnimation *) getCornerRadiusAnimation: (CALayer *) layer newBounds:(CGRect) newBounds
{
    CABasicAnimation *cornerRadiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerRadiusAnimation.duration = .5;
    cornerRadiusAnimation.repeatCount = 1;
    cornerRadiusAnimation.beginTime = [layer convertTime:CACurrentMediaTime() toLayer:nil] + 0.3;
    cornerRadiusAnimation.fromValue = [NSNumber numberWithFloat: 15.0f];
    cornerRadiusAnimation.toValue = [NSNumber numberWithFloat:newBounds.size.width / 2];
    cornerRadiusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return cornerRadiusAnimation;
}

@end
