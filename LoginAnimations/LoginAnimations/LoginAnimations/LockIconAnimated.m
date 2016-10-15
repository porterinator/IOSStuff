//
//  LockIconAnimated.m
//  LoginAnimations
//
//  Created by Admin on 12/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "LockIconAnimated.h"
#import "AnimationHelper.h"

@implementation LockIconAnimated


- (void)commonInit: (CGRect) frame
{
    CAShapeLayer *box = [CAShapeLayer layer];
    CGFloat unit = frame.size.width / 8;
    box.path = CGPathCreateWithRect(CGRectMake(unit, unit * 3, unit * 6, unit * 3), NULL);
    box.fillColor = [UIColor clearColor].CGColor;
    box.strokeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6f].CGColor;
    box.lineWidth = 1;
    [self.layer addSublayer:box];
    
    CABasicAnimation *drawAnimation = [AnimationHelper getStrokeAnimation];
    [box addAnimation:drawAnimation forKey:@"drawAnimation"];
    
    CAShapeLayer *arc = [CAShapeLayer layer];
    CGFloat a = unit * 4;
    CGFloat b = a;
    CGFloat c = unit * 4;
    CGFloat d = (a * b) / c;
    CGFloat arcRaidus = d / 2;
    CGPoint center = CGPointMake(unit * 4, unit + arcRaidus);
    UIBezierPath * arcPath = [UIBezierPath bezierPathWithArcCenter:center radius:arcRaidus startAngle:M_PI endAngle:2*M_PI clockwise:YES];
    [arc setPath:[arcPath CGPath]];
    [arc setLineWidth:1];
    [arc setFillColor:[[UIColor clearColor] CGColor]];
    [arc setStrokeColor:[[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6f] CGColor]];
    [self.layer addSublayer:arc];
    
    [arc addAnimation:drawAnimation forKey:@"drawAnimation"];
    
    CAShapeLayer *line = [CAShapeLayer layer];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(unit * 4, unit * 4)];
    [linePath addLineToPoint:CGPointMake(unit * 4, unit * 5)];
    line.path = [linePath CGPath];
    [line setLineWidth:1];
    [line setFillColor:[[UIColor clearColor] CGColor]];
    [line setStrokeColor:[[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6f] CGColor]];
    [self.layer addSublayer:line];
    
    [line addAnimation:drawAnimation forKey:@"drawAnimation"];
}

- (void)layoutSubviews
{
    [self commonInit:self.frame];
}

@end
