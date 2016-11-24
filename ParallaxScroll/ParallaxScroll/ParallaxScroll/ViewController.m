//
//  ViewController.m
//  ParallaxScroll
//
//  Created by Admin on 23/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView.scrollEnabled = YES;
    int scrollWidth = 100;
    _scrollView.backgroundColor=[UIColor blackColor];
    
    int xOffset = 0;
    
    CGRect rect = self.view.frame;
    rect.origin.x = xOffset;
    CityView *cityView = [[CityView alloc] initWithFrame:rect];
    cityView.cityImage = [UIImage imageNamed:@"amsterdam"];
    cityView.leftText = @"AMST";
    cityView.backText = @"ER";
    cityView.rightText = @"DAM";
    [_scrollView addSubview:cityView];
    xOffset+=self.view.frame.size.width;
    
    rect = self.view.frame;
    rect.origin.x = xOffset;
    cityView = [[CityView alloc] initWithFrame:rect];
    cityView.cityImage = [UIImage imageNamed:@"rome"];
    cityView.leftText = @"R";
    cityView.backText = @"OM";
    cityView.rightText = @"E";
    [_scrollView addSubview:cityView];
    xOffset+=self.view.frame.size.width;
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width*2,_scrollView.frame.size.height);
    
    rect = self.view.frame;
    rect.origin.x = xOffset;
    cityView = [[CityView alloc] initWithFrame:rect];
    cityView.cityImage = [UIImage imageNamed:@"newyork"];
    cityView.leftText = @"NE";
    cityView.backText = @"W-Y";
    cityView.rightText = @"ORK";
    [_scrollView addSubview:cityView];
    xOffset+=self.view.frame.size.width;
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3,_scrollView.frame.size.height);

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
