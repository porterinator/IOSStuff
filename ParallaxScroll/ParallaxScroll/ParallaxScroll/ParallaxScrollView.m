//
//  MyScrollView.m
//  ParallaxScroll
//
//  Created by Admin on 24/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ParallaxScrollView.h"
#import "CityView.h"

@interface ParallaxScrollView ()
{
    int currentIndex;
    int previousIndex;
}
@end

@implementation ParallaxScrollView

-(void)setContentOffset:(CGPoint)contentOffset
{
    [super setContentOffset:contentOffset];
    NSUInteger subViewsCount = [self.subviews count];
    if ( subViewsCount> 0) {
        
        int j = 0;
        while (j < subViewsCount) {
            if (contentOffset.x >= (j*self.bounds.size.width) && contentOffset.x < (j*self.bounds.size.width + 100)) {
                previousIndex = currentIndex;
                currentIndex = j;
                break;
            }
            j++;
        }
        //NSLog(@"currentIndex=%i, prevIndex=%i", currentIndex, previousIndex);
        if ([self.subviews[currentIndex] class] == [CityView class]) {
            CityView *cityView = (CityView *)self.subviews[currentIndex];
            cityView->offset = contentOffset.x - self.bounds.size.width * currentIndex;
            [cityView setNeedsDisplayInRect];
        }
        if ([self.subviews[previousIndex] class] == [CityView class] && previousIndex != currentIndex) {
            CityView *cityView = (CityView *)self.subviews[previousIndex];
            cityView->offset = 0;
            [cityView setNeedsDisplayInRect];
        }
    }
}


@end
