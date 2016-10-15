//
//  AnimationHelper.h
//  LoginAnimations
//
//  Created by Admin on 15/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AnimationHelper : NSObject


+ (CABasicAnimation *) getStrokeAnimation;
+ (CABasicAnimation *)getBiggerAnimation: (CALayer *)layer oldBounds:(CGRect) oldBounds newBounds: (CGRect)newBounds;
+ (CABasicAnimation *) getCornerRadiusAnimation: (CALayer *) layer newBounds:(CGRect) newBounds;

@end
