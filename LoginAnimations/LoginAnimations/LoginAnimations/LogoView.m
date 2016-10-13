//
//  LogoView.m
//  LoginAnimations
//
//  Created by Admin on 12/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "LogoView.h"

@implementation LogoView

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

- (void)drawRect:(CGRect)rect {
    CGFloat unit = rect.size.width / 8;
    CAShapeLayer *box1 = [CAShapeLayer layer];
    UIBezierPath *rect1 = [UIBezierPath bezierPath];
    [rect1 moveToPoint:CGPointMake(unit * 3, unit * 5)];
    [rect1 addLineToPoint:CGPointMake(unit * 7, unit)];
    [rect1 addLineToPoint:CGPointMake(unit * 8, unit * 2)];
    [rect1 addLineToPoint:CGPointMake(unit * 4, unit * 6)];
    [rect1 addLineToPoint:CGPointMake(unit * 3, unit * 5)];
    box1.path = rect1.CGPath;
    
    box1.fillColor = [UIColor whiteColor].CGColor;
    box1.strokeColor = [UIColor whiteColor].CGColor;
    box1.lineWidth = 1;
    
    // Add to parent layer
    [self.layer addSublayer:box1];
    
    
    
    
    CAShapeLayer *box2 = [CAShapeLayer layer];
    UIBezierPath *rect2 = [UIBezierPath bezierPath];
    [rect2 moveToPoint:CGPointMake(unit * 1.5, unit * 3.5)];
    [rect2 addLineToPoint:CGPointMake(unit * 2.5, unit * 2.5)];
    [rect2 addLineToPoint:CGPointMake(unit * 4, unit * 4)];
    [rect2 addLineToPoint:CGPointMake(unit * 3, unit * 5)];
    [rect2 addLineToPoint:CGPointMake(unit * 1.5, unit * 3.5)];
    box2.path = rect2.CGPath;
    
    box2.fillColor = [UIColor whiteColor].CGColor;
    box2.strokeColor = [UIColor blackColor].CGColor;
    box2.lineWidth = 1;
    
    // Add to parent layer
    //[self.layer addSublayer:box2];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    
    
    NSArray *gradientColors = [NSArray arrayWithObjects:
                               (id)[self colorFromHexString:@"#F5F5F5"].CGColor,
                               (id)[self colorFromHexString:@"#F3F3F2"].CGColor,
                               //(id)[self colorFromHexString:@"#D8D8D8"].CGColor,
                               (id)[self colorFromHexString:@"#CECDCD"].CGColor,
                               nil];
    CGFloat gradientLocations[] = {0, 0.5, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)gradientColors, gradientLocations);
    
    CGContextSaveGState(context);
    [rect2 fill];
    [rect2 addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(unit, unit * 3), CGPointMake(unit * 3, unit * 5), 0);
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}


@end
