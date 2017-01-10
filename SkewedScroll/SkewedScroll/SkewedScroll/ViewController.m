//
//  ViewController.m
//  SkewedScroll
//
//  Created by Admin on 28/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Polygone.h"

@interface ViewController () {
    int current;
    BOOL forward;
}
@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        current = 0;
        forward = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

-(void)viewWillAppear:(BOOL)animated
{

    [self.image1 formShapeUp: self.view.frame];
    [self.view1 formShapeDown: self.view.frame];
    
    [self.Image2 formShapeDown:self.view.frame];
    [self.view2 formShapeUp:self.view.frame];
    
    [self.image3 formShapeUp: self.view.frame];
    [self.view3 formShapeDown: self.view.frame];
    
    
    /*[UIView animateWithDuration:2.0f animations:^{
        CGRect i2f = self.view1.bounds;
        i2f.origin.y += self.view.frame.size.height + 1;
        i2f.origin.x -= self.view.frame.size.width / 2;
        self.view1.bounds = i2f;
        CGRect i1f = self.image1.bounds;
        i1f.origin.y -= self.view.frame.size.height;
        i1f.origin.x += self.view.frame.size.width / 2;
        self.image1.bounds = i1f;
    }];*/
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(switchToNext:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) switchToNext: (NSTimer*)timer {
    switch (current) {
        case 0:
        {
            /*[self.view bringSubviewToFront:self.view3];
            [self.view bringSubviewToFront:self.image3];*/
            if (forward) {
                [UIView animateWithDuration:2.0f animations:^{
                    CGRect i2f = self.view3.bounds;
                    i2f.origin.y += self.view.frame.size.height + 1;
                    i2f.origin.x -= self.view.frame.size.width / 2;
                    self.view3.bounds = i2f;
                    CGRect i1f = self.image3.bounds;
                    i1f.origin.y -= self.view.frame.size.height;
                    i1f.origin.x += self.view.frame.size.width / 2;
                    self.image3.bounds = i1f;
                }];
            } else {
                [UIView animateWithDuration:2.0f animations:^{
                    CGRect i2f = self.view1.bounds;
                    i2f.origin.y -= self.view.frame.size.height + 1;
                    i2f.origin.x += self.view.frame.size.width / 2;
                    self.view1.bounds = i2f;
                    CGRect i1f = self.image1.bounds;
                    i1f.origin.y += self.view.frame.size.height;
                    i1f.origin.x -= self.view.frame.size.width / 2;
                    self.image1.bounds = i1f;
                }];
            }
            current++;
        }
            break;
        case 1:
        {
            /*[self.view bringSubviewToFront:self.view2];
            [self.view bringSubviewToFront:self.Image2];*/
            if (forward) {
                [UIView animateWithDuration:2.0f animations:^{
                    CGRect i2f = self.view2.bounds;
                    i2f.origin.y -= self.view.frame.size.height + 1;
                    i2f.origin.x += self.view.frame.size.width / 2;
                    self.view2.bounds = i2f;
                    CGRect i1f = self.Image2.bounds;
                    i1f.origin.y += self.view.frame.size.height;
                    i1f.origin.x -= self.view.frame.size.width / 2;
                    self.Image2.bounds = i1f;
                }];
            } else {
                [UIView animateWithDuration:2.0f animations:^{
                    CGRect i2f = self.view2.bounds;
                    i2f.origin.y += self.view.frame.size.height + 1;
                    i2f.origin.x -= self.view.frame.size.width / 2;
                    self.view2.bounds = i2f;
                    CGRect i1f = self.Image2.bounds;
                    i1f.origin.y -= self.view.frame.size.height;
                    i1f.origin.x += self.view.frame.size.width / 2;
                    self.Image2.bounds = i1f;
                }];
            }
            current++;
            break;
            
        }
        case 2:
        {
            /*[self.view bringSubviewToFront:self.view1];
            [self.view bringSubviewToFront:self.image1];*/
            if (forward) {
                [UIView animateWithDuration:2.0f animations:^{
                    CGRect i2f = self.view1.bounds;
                    i2f.origin.y += self.view.frame.size.height + 1;
                    i2f.origin.x -= self.view.frame.size.width / 2;
                    self.view1.bounds = i2f;
                    CGRect i1f = self.image1.bounds;
                    i1f.origin.y -= self.view.frame.size.height;
                    i1f.origin.x += self.view.frame.size.width / 2;
                    self.image1.bounds = i1f;
                }];
            } else {
                [UIView animateWithDuration:2.0f animations:^{
                    CGRect i2f = self.view3.bounds;
                    i2f.origin.y -= self.view.frame.size.height + 1;
                    i2f.origin.x += self.view.frame.size.width / 2;
                    self.view3.bounds = i2f;
                    CGRect i1f = self.image3.bounds;
                    i1f.origin.y += self.view.frame.size.height;
                    i1f.origin.x -= self.view.frame.size.width / 2;
                    self.image3.bounds = i1f;
                }];
            }
            current = 0;
            forward = !forward;
            break;
            
        }
            
        default:
            break;
    }
    
}

@end
