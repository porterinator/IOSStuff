//
//  PreloaderView.m
//  AnimatedPreloader
//
//  Created by Admin on 25/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "PreloaderView.h"
#import "BoxView.h"

@interface PreloaderView ()
{
    NSMutableArray *boxArray;
}
@end


@implementation PreloaderView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        boxArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) commonInit
{
    for (int i = 0; i < [boxArray count]; i++) {
        UIView *view = (UIView *)boxArray[i];
        [view removeFromSuperview];
    }
    [boxArray removeAllObjects];
    CGFloat unit = self.frame.size.width / 9;
    [boxArray addObject:[[BoxView alloc] initWithFrame:CGRectMake(unit * 3, unit, unit, unit) andIndex:0]];
    [self addSubview:[boxArray objectAtIndex:0]];
    
    [boxArray addObject:[[BoxView alloc] initWithFrame:CGRectMake(unit * 5, unit, unit, unit) andIndex:1]];
    [self addSubview:[boxArray objectAtIndex:1]];
    
    [boxArray addObject:[[BoxView alloc] initWithFrame:CGRectMake(unit * 3, unit * 3, unit, unit) andIndex:2]];
    [self addSubview:[boxArray objectAtIndex:2]];
    
    
    [boxArray addObject:[[BoxView alloc] initWithFrame:CGRectMake(unit * 5, unit * 3, unit, unit) andIndex:3]];
    [self addSubview:[boxArray objectAtIndex:3]];
    [boxArray addObject:[[BoxView alloc] initWithFrame:CGRectMake(unit * 5, unit * 3, unit, unit) andIndex:4]];
    [self addSubview:[boxArray objectAtIndex:4]];
    
    
    [boxArray addObject:[[BoxView alloc] initWithFrame:CGRectMake(unit * 3, unit * 5, unit, unit) andIndex:5]];
    [self addSubview:[boxArray objectAtIndex:5]];
    
    [boxArray addObject:[[BoxView alloc] initWithFrame:CGRectMake(unit * 5, unit * 5, unit, unit) andIndex:6]];
    [self addSubview:[boxArray objectAtIndex:6]];
    
    [boxArray addObject:[[BoxView alloc] initWithFrame:CGRectMake(unit * 5, unit * 5, unit, unit) andIndex:7]];
    [self addSubview:[boxArray objectAtIndex:7]];
    
    for (int i = 0; i < 8; i++) {
        UIView *view = (UIView *)boxArray[i];
        [view setBackgroundColor:[UIColor whiteColor]];
    }
    
    
    
    
}

- (void) animate
{
    if (boxArray == nil || [boxArray count] == 0) return;
    [self.layer removeAllAnimations];
    for (int i = 0; i < [boxArray count]; i ++) {
        UIView *view = (UIView *)boxArray[i];
        [view.layer removeAllAnimations];
    }
    CGFloat unit = self.frame.size.width / 9;
    double step = 1.0 / 11.0;
    [UIView animateKeyframesWithDuration:3 delay:0.0 options:UIViewKeyframeAnimationOptionRepeat | UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:step animations:^{
                             
                             //верние 5 боксов в право
                             for (int i = 0; i < 5; i++) {
                                 UIView *view = (UIView *)boxArray[i];
                                 CGRect oldFrame = view.frame;
                                 oldFrame.origin.x += unit;
                                 view.frame = oldFrame;
                             }
                             //нижние 3 влево
                             for (int i = 5; i < 8; i++) {
                                 UIView *view = (UIView *)boxArray[i];
                                 CGRect oldFrame = view.frame;
                                 oldFrame.origin.x -= unit;
                                 view.frame = oldFrame;
                             }
                         }];
        [UIView addKeyframeWithRelativeStartTime:step relativeDuration:step animations:^{
                             //верхние 2 вниз
                             for (int i = 0; i < 2; i++) {
                                 UIView *view = (UIView *)boxArray[i];
                                 CGRect oldFrame = view.frame;
                                 oldFrame.origin.y += 2*unit;
                                 view.frame = oldFrame;
                             }
                             //пятый вверх
                             UIView *view = (UIView *)boxArray[5];
                             CGRect oldFrame = view.frame;
                             oldFrame.origin.y -= 2 * unit;
                             view.frame = oldFrame;
                             
                             //дублирующий 6 вправо
                             view = (UIView *)boxArray[7];
                             oldFrame = view.frame;
                             oldFrame.origin.x += 2 * unit;
                             view.frame = oldFrame;
                         }];
        [UIView addKeyframeWithRelativeStartTime:2*step relativeDuration:step animations:^{
                             //первый вверх
                             UIView *view = (UIView *)boxArray[0];
                             CGRect oldFrame = view.frame;
                             oldFrame.origin.y -= 2 * unit;
                             view.frame = oldFrame;
                             
                             //пятый вправо
                             view = (UIView *)boxArray[5];
                             oldFrame = view.frame;
                             oldFrame.origin.x += 2 *unit;
                             view.frame = oldFrame;
                         }];
        [UIView addKeyframeWithRelativeStartTime:4*step relativeDuration:step animations:^{
                             UIView *view = (UIView *)boxArray[5];
                             CGRect oldFrame = view.frame;
                             oldFrame.origin.x -= 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[7];
                             oldFrame = view.frame;
                             oldFrame.origin.x -= 2 *unit;
                             view.frame = oldFrame;
                         }];
        //на этом шаге нарисован крест
        [UIView addKeyframeWithRelativeStartTime:3*step relativeDuration:step animations:^{
                             UIView *view = (UIView *)boxArray[1];
                             CGRect oldFrame = view.frame;
                             oldFrame.origin.y -= 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[4];
                             oldFrame = view.frame;
                             oldFrame.origin.y += 2 *unit;
                             view.frame = oldFrame;
                         }];
        [UIView addKeyframeWithRelativeStartTime:4*step relativeDuration:step animations:^{
                             //верхние 2 влево
                             for (int i = 0; i < 2; i++) {
                                 UIView *view = (UIView *)boxArray[i];
                                 CGRect oldFrame = view.frame;
                                 oldFrame.origin.x -= 2*unit;
                                 view.frame = oldFrame;
                             }
                             UIView *view = (UIView *)boxArray[3];
                             CGRect oldFrame = view.frame;
                             oldFrame.origin.y -= 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[5];
                             oldFrame = view.frame;
                             oldFrame.origin.y += 2 *unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[4];
                             oldFrame = view.frame;
                             oldFrame.origin.x -= 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[7];
                             oldFrame = view.frame;
                             oldFrame.origin.x -= 2 *unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[6];
                             oldFrame = view.frame;
                             oldFrame.origin.y -= 2 *unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[2];
                             oldFrame = view.frame;
                             oldFrame.origin.x += 2 *unit;
                             view.frame = oldFrame;
                         }];
        [UIView addKeyframeWithRelativeStartTime:5*step relativeDuration:step animations:^{
            UIView *view = (UIView *)boxArray[0];
                             CGRect oldFrame = view.frame;
                             oldFrame.origin.y += 2 * unit;
                             view.frame = oldFrame;
                             
                             
                             view = (UIView *)boxArray[1];
                             oldFrame = view.frame;
                             oldFrame.origin.x -= 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[3];
                             oldFrame = view.frame;
                             oldFrame.origin.x -= 2 * unit;
                             view.frame = oldFrame;
                             
                             
                             view = (UIView *)boxArray[4];
                             oldFrame = view.frame;
                             oldFrame.origin.y -= 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[2];
                             oldFrame = view.frame;
                             oldFrame.origin.y += 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[7];
                             oldFrame = view.frame;
                             oldFrame.origin.x += 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[5];
                             oldFrame = view.frame;
                             oldFrame.origin.x += 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[6];
                             oldFrame = view.frame;
                             oldFrame.origin.x += 2 * unit;
                             view.frame = oldFrame;
                             
                         }];
        [UIView addKeyframeWithRelativeStartTime:6*step relativeDuration:step animations:^{
                             UIView *view = (UIView *)boxArray[3];
                             CGRect oldFrame = view.frame;
                             oldFrame.origin.y += 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[1];
                             oldFrame = view.frame;
                             oldFrame.origin.x += 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[0];
                             oldFrame = view.frame;
                             oldFrame.origin.x += 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[7];
                             oldFrame = view.frame;
                             oldFrame.origin.x -= 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[2];
                             oldFrame = view.frame;
                             oldFrame.origin.x -= 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[6];
                             oldFrame = view.frame;
                             oldFrame.origin.y += 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[4];
                             oldFrame = view.frame;
                             oldFrame.origin.x += 2 * unit;
                             view.frame = oldFrame;
                             
                         }];
        [UIView addKeyframeWithRelativeStartTime:7*step relativeDuration:step animations:^{
                             UIView *view = (UIView *)boxArray[1];
                             CGRect oldFrame = view.frame;
                             oldFrame.origin.x -= 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[3];
                             oldFrame = view.frame;
                             oldFrame.origin.x -= 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[7];
                             oldFrame = view.frame;
                             oldFrame.origin.x += 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[6];
                             oldFrame = view.frame;
                             oldFrame.origin.x -= 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[2];
                             oldFrame = view.frame;
                             oldFrame.origin.y -= 4 * unit;
                             view.frame = oldFrame;
                             
                             
                         }];
        [UIView addKeyframeWithRelativeStartTime:8*step relativeDuration:step animations:^{
                             UIView *view = (UIView *)boxArray[7];
                             CGRect oldFrame = view.frame;
                             oldFrame.origin.x -= 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[4];
                             oldFrame = view.frame;
                             oldFrame.origin.x -= 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[1];
                             oldFrame = view.frame;
                             oldFrame.origin.x += 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[2];
                             oldFrame = view.frame;
                             oldFrame.origin.x += 2 * unit;
                             view.frame = oldFrame;
                             
                             
                             
                         }];
        [UIView addKeyframeWithRelativeStartTime:9*step relativeDuration:step animations:^{
                             UIView *view = (UIView *)boxArray[6];
                             CGRect oldFrame = view.frame;
                             oldFrame.origin.x += 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[3];
                             oldFrame = view.frame;
                             oldFrame.origin.y -= 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[7];
                             oldFrame = view.frame;
                             oldFrame.origin.y -= 2 * unit;
                             view.frame = oldFrame;
                             
                             view = (UIView *)boxArray[2];
                             oldFrame = view.frame;
                             oldFrame.origin.x -= 2 * unit;
                             view.frame = oldFrame;
                             
                             
                             
                         }];
        [UIView addKeyframeWithRelativeStartTime:10*step relativeDuration:step animations:^{
                             UIView *view = (UIView *)boxArray[0];
                             view.frame = CGRectMake(unit * 3, unit, unit, unit);
                             view = (UIView *)boxArray[1];
                             view.frame = CGRectMake(unit * 5, unit, unit, unit);
                             view = (UIView *)boxArray[2];
                             view.frame = CGRectMake(unit * 3, unit * 3, unit, unit);
                             view = (UIView *)boxArray[3];
                             view.frame = CGRectMake(unit * 5, unit * 3, unit, unit);
                             view = (UIView *)boxArray[4];
                             view.frame = CGRectMake(unit * 5, unit * 3, unit, unit);
                             view = (UIView *)boxArray[5];
                             view.frame = CGRectMake(unit * 3, unit * 5, unit, unit);
                             view = (UIView *)boxArray[6];
                             view.frame = CGRectMake(unit * 5, unit * 5, unit, unit);
                             view = (UIView *)boxArray[7];
                             view.frame = CGRectMake(unit * 5, unit * 5, unit, unit);
                         }];
    } completion:nil];
    
    
    
}

- (void)layoutSubviews
{
    [self commonInit];
    [self animate];
    
}



@end

