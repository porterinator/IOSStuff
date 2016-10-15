//
//  OffButton.m
//  LoginAnimations
//
//  Created by Admin on 15/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "OffButton.h"
#import "UIColorHex.h"

@implementation OffButton

@synthesize box, arc;

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self =  [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void) setup
{
    [self.layer setCornerRadius:30.0f];
    self.backgroundColor = [UIColor colorFromHexString:@"#FF3366"];
    [self.layer setMasksToBounds:YES];
    [self.titleLabel removeFromSuperview];
}


- (void)drawRect:(CGRect)rect {
    arc = [CAShapeLayer layer];
    arc.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2) radius:rect.size.width / 2 - 10 startAngle: 1.7 * M_PI endAngle: 3.3 * M_PI clockwise:YES].CGPath;
    arc.strokeColor = [UIColor whiteColor].CGColor;
    arc. fillColor = [UIColor clearColor].CGColor;
    arc.lineWidth = 10;
    [self.layer addSublayer:arc];
    
    
    box = [CAShapeLayer layer];
    box.path = CGPathCreateWithRect(CGRectMake(rect.size.width / 2 - 5, 5, 10, rect.size.height / 2.5), NULL);
    box.fillColor = [UIColor whiteColor].CGColor;
    box.strokeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6f].CGColor;
    box.lineWidth = 1;
    
    [self.layer addSublayer:box];
    
    [super drawRect:rect];
}


@end
