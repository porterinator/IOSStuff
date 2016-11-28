//
//  WaveScrollView.m
//  WaveScroll
//
//  Created by Admin on 27/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "WaveScrollView.h"

@interface WaveScrollView ()
{
    NSMutableArray *stripes1;
    NSMutableArray *stripes2;
    BOOL forwardStop;
    BOOL backwardStop;
}

@end

@implementation WaveScrollView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        backwardStop = YES;
        forwardStop = NO;
    }
    return self;
}

- (CABasicAnimation *)getMoveAnimation: (CALayer *)layer oldPosition:(CGPoint) oldPosition newPosition: (CGPoint)newPosition delay: (float) delay
{
    
    CABasicAnimation *biggerAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    biggerAnimation.duration            = 5.0;
    biggerAnimation.repeatCount         = 1.0;
    biggerAnimation.beginTime = 0.0;//[layer convertTime:CACurrentMediaTime() toLayer:layer] + delay;
    
    biggerAnimation.fromValue = [NSValue valueWithCGPoint:oldPosition];
    biggerAnimation.toValue   = [NSValue valueWithCGPoint:newPosition];
    
    biggerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return biggerAnimation;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);
    [[UIImage imageNamed:@"Image1"] drawInRect:rect];
    //CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, [UIImage imageNamed:@"Image1"].CGImage);
    CGImageRef resizedImage = CGImageCreateWithImageInRect(UIGraphicsGetImageFromCurrentImageContext().CGImage, rect);
    UIGraphicsEndImageContext();
    CGRect stripeRect = rect;
    stripeRect.size.width = stripeRect.size.width / 10;
    stripes1 = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        UIButton *view = [[UIButton alloc] init];
        CGImageRef stripeImage = CGImageCreateWithImageInRect(resizedImage, stripeRect);
        view.layer.contents = (__bridge id)stripeImage;
        view.frame = stripeRect;
        [stripes1 addObject:view];
        stripeRect.origin.x += stripeRect.size.width;
        [self addSubview:view];
        [view addTarget:self action:@selector(nextImage) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);
    [[UIImage imageNamed:@"Image2"] drawInRect:rect];
    //CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, [UIImage imageNamed:@"Image2"].CGImage);
    CGImageRef resizedImage2 = CGImageCreateWithImageInRect(UIGraphicsGetImageFromCurrentImageContext().CGImage, rect);
    UIGraphicsEndImageContext();
    CGRect stripeRect2 = rect;
    stripeRect2.size.width = stripeRect2.size.width / 10;
    stripes2 = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        UIButton *view = [[UIButton alloc] init];
        CGImageRef stripeImage = CGImageCreateWithImageInRect(resizedImage2, stripeRect2);
        view.layer.contents = (__bridge id)stripeImage;
        CGRect fr = stripeRect2;
        fr.origin.y = rect.size.height;
        view.frame = fr;
        [stripes2 addObject:view];
        stripeRect2.origin.x += stripeRect.size.width;
        [self addSubview:view];
        [view addTarget:self action:@selector(nextImage) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void) step: (BOOL) forward
{
    float delay = 0;
    float duration = .3;
    float delayStep = .03;
    for (int i = 0; i < 10; i++) {
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseIn animations:^{
            int indexes[] = {4,3,5,2,6,1,7,0,8,9};
            UIView *view = (UIView *)[stripes1 objectAtIndex:indexes[i]];
            CGRect newBounds = view.frame;
            if (forward)
                newBounds.origin.y -= view.frame.size.height;
            else
                newBounds.origin.y += view.frame.size.height;
            view.frame = newBounds;
            
        } completion:nil];
        delay += delayStep;
    }
    
    delay = 0;
    for (int i = 0; i < 10; i++) {
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseIn animations:^{
            int indexes[] = {4,3,5,2,6,1,7,0,8,9};
            UIView *view = (UIView *)[stripes2 objectAtIndex:indexes[i]];
            CGRect newBounds = view.frame;
            if (forward)
                newBounds.origin.y -= view.frame.size.height;
            else
                newBounds.origin.y += view.frame.size.height;
            view.frame = newBounds;
            
        } completion:nil];
        delay += delayStep;
    }

}

-(void) nextImage
{
    if (!forwardStop)
        [self step:YES];
    forwardStop = YES;
    backwardStop = NO;
}

-(void) prevImage
{
    if (!backwardStop)
        [self step:NO];
    backwardStop = YES;
    forwardStop = NO;
}

@end
