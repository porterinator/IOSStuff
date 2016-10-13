//
//  HumanIconAnimated.m
//  LoginAnimations
//
//  Created by Admin on 11/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "HumanIconAnimated.h"

@implementation HumanIconAnimated

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect) frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)commonInit: (CGRect) frame
{
    // Set up the shape of the circle
    int radius = frame.size.width / 8;
    CAShapeLayer *circle = [CAShapeLayer layer];
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    // Center the shape in self.view
    circle.position = CGPointMake(self.frame.size.width / 2- radius,
                                  self.frame.size.height / 2 - radius * 2);
    
    // Configure the apperence of the circle
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6f].CGColor;
    circle.lineWidth = 1;
    
    // Add to parent layer
    [self.layer addSublayer:circle];
    
    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 2.0; // "animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // Add the animation to the circle
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    
    
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
    
    CABasicAnimation *drawArcAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawArcAnimation.duration = 2.0;
    drawArcAnimation.repeatCount = 1.0;
    drawArcAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawArcAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    drawArcAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [arc addAnimation:drawArcAnimation forKey:@"drawArcAnimation"];
}

- (void)layoutSubviews
{
    [self commonInit:self.frame];
}

@end
