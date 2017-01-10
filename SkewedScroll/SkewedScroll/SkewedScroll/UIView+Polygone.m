//
//  UIView+Polygone.m
//  SkewedScroll
//
//  Created by Admin on 09/01/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "UIView+Polygone.h"

@implementation UIView (Polygone)


- (void) formShapeUp:(CGRect) parentRect {
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0, 0)];
    [linePath addLineToPoint:CGPointMake(parentRect.size.width / 2 + parentRect.size.width / 4, 0)];
    [linePath addLineToPoint:CGPointMake(parentRect.size.width / 2 - parentRect.size.width / 4, parentRect.size.height)];
    [linePath addLineToPoint:CGPointMake(0, parentRect.size.height)];
    [linePath addLineToPoint:CGPointMake(0, 0)];
    [linePath closePath];
    layer.path = [linePath CGPath];
    [self.layer setMask:layer];
}

- (void) formShapeDown: (CGRect) parentRect {
    CAShapeLayer *layerBottom = [CAShapeLayer layer];
    UIBezierPath *linePathBottom = [UIBezierPath bezierPath];
    [linePathBottom moveToPoint:CGPointMake(parentRect.size.width, parentRect.size.height)];
    [linePathBottom addLineToPoint:CGPointMake(parentRect.size.width / 2 - parentRect.size.width / 4, parentRect.size.height)];
    [linePathBottom addLineToPoint:CGPointMake(parentRect.size.width / 2 + parentRect.size.width / 4, 0)];
    [linePathBottom addLineToPoint:CGPointMake(parentRect.size.width, 0)];
    [linePathBottom addLineToPoint:CGPointMake(parentRect.size.width, parentRect.size.height)];
    [linePathBottom closePath];
    layerBottom.path = linePathBottom.CGPath;
    [self.layer setMask:layerBottom];
}

@end
