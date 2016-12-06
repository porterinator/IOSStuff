//
//  ViewController.m
//  SkewedScroll
//
//  Created by Admin on 28/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0, 0)];
    [linePath addLineToPoint:CGPointMake(self.view.frame.size.width / 2 + self.view.frame.size.width / 4, 0)];
    [linePath addLineToPoint:CGPointMake(self.view.frame.size.width / 2 - self.view.frame.size.width / 4, self.view.frame.size.height)];
    [linePath addLineToPoint:CGPointMake(0, self.view.frame.size.height)];
    [linePath addLineToPoint:CGPointMake(0, 0]);
    layer.path = [linePath CGPath];
    [layer setLineWidth:1];
    [layer setFillColor:[[UIColor clearColor] CGColor]];
    [layer setStrokeColor:[[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6f] CGColor]];
                                         _image1.layer = layer;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
