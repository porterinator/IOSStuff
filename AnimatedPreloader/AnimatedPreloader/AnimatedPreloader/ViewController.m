//
//  ViewController.m
//  AnimatedPreloader
//
//  Created by Admin on 25/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) animatePreloader
{
    [self.prealoder commonInit];
    [self.prealoder animate];
}

@end
