//
//  GradientView.h
//  AssetGrid
//
//  Created by Admin on 11/10/16.
//
//
#import <UIKit/UIKit.h>

@interface AlphaGradientView : UIView

typedef enum gradientDirections
{
    GRADIENT_UP,
    GRADIENT_DOWN,
    GRADIENT_LEFT,
    GRADIENT_RIGHT
} GradientDirection;

@property (nonatomic) UIColor* color;
@property (nonatomic) GradientDirection direction;

@end
