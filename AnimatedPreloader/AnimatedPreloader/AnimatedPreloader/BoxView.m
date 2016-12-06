//
//  BoxView.m
//  AnimatedPreloader
//
//  Created by Admin on 06/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "BoxView.h"

@interface BoxView ()

@property(nonatomic, copy) NSString *index;

@end

@implementation BoxView


- (instancetype)initWithFrame:(CGRect)frame andIndex:(int) index
{
    CGRect rect = frame;
    /*rect.origin.x += 5;
    rect.origin.y += 5;
    rect.size.width -= 5;
    rect.size.height -= 5;*/
    self = [super initWithFrame:rect];
    if (self) {
        self.index = [NSString stringWithFormat:@"%i", index];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //[_index drawAtPoint:CGPointMake(0,0) withAttributes:nil];
}


@end
