//
//  HumanIconAnimated.m
//  LoginAnimations
//
//  Created by Admin on 11/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "HumanIconAnimated.h"
#import "AnimationHelper.h"

@implementation HumanIconAnimated

- (void)commonInit: (CGRect) frame
{

    int radius = frame.size.width / 8;
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    circle.position = CGPointMake(self.frame.size.width / 2- radius,
                                  self.frame.size.height / 2 - radius * 2);
    
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6f].CGColor;
    circle.lineWidth = 1;
    
    [self.layer addSublayer:circle];
    
    CABasicAnimation* drawAnimation = [AnimationHelper getStrokeAnimation];
    [circle addAnimation:drawAnimation forKey:@"strokeEnd"];
    
    
    CAShapeLayer *arc = [CAShapeLayer layer];
    CGFloat a = frame.size.width / 8 * 3;
    CGFloat b = a;
    CGFloat c = frame.size.height / 8 * 2;
    CGFloat d = (a * b) / c;
    CGFloat arcRaidus = d / 2;
    CGPoint center = CGPointMake(frame.size.width / 2, frame.size.height - frame.size.height / 8 * 3 + arcRaidus);
    UIBezierPath * arcPath = [UIBezierPath bezierPathWithArcCenter:center radius:arcRaidus startAngle:1.1*M_PI endAngle:1.9*M_PI clockwise:YES];
    [arcPath addLineToPoint:CGPointMake(frame.size.width / 8 * 1.9, frame.size.height / 8 * 6.55)];
    [arc setPath:[arcPath CGPath]];
    [arc setLineWidth:1];
    [arc setFillColor:[[UIColor clearColor] CGColor]];
    [arc setStrokeColor:[[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6f] CGColor]];
    [self.layer addSublayer:arc];
    [arc addAnimation:drawAnimation forKey:@"drawArcAnimation"];
}

- (void)layoutSubviews
{
    [self commonInit:self.frame];
}

@end
