//
//  CityView.h
//  ParallaxScroll
//
//  Created by Admin on 24/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityView : UIView
{
@public
    float offset;
}


@property(nonatomic, strong) UIImage *cityImage;
@property(nonatomic, copy) NSString *leftText;
@property(nonatomic, copy) NSString *backText;
@property(nonatomic, copy) NSString *rightText;

- (void)setNeedsDisplayInRect;

@end
