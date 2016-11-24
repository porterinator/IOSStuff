//
//  GradientView.m
//  AssetGrid
//
//  Created by Admin on 11/10/16.
//
//
#import <QuartzCore/QuartzCore.h>
#import "AlphaGradientView.h"

@implementation AlphaGradientView
{
    CGPoint startPoint;
    CGPoint endPoint;
    float _alpha;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _alpha = 1;
        self.userInteractionEnabled = false;
        self.backgroundColor = [UIColor clearColor];
        self.color = [UIColor blackColor];
        self.direction = GRADIENT_UP;
    }
    
    return self;
}


-(void) setAlpha:(CGFloat)alpha
{
    _alpha = alpha;
    [self setNeedsDisplay];    
}

-(void) setColor:(UIColor *)value
{
    _color = value;
    [self setNeedsDisplay];
}

-(void) setDirection:(GradientDirection)value
{
    _direction = value;
    [self setNeedsDisplay];
}

-(void) calculateStartAndEndPoints
{
    switch (self.direction)
    {
        case GRADIENT_UP:
            startPoint  = CGPointMake( 0, self.frame.size.height);
            endPoint    = CGPointMake( 0, 0);
            break;
            
        case GRADIENT_DOWN:
            startPoint  = CGPointMake( 0, 0);
            endPoint    = CGPointMake( 0, self.frame.size.height);
            break;
            
        case GRADIENT_LEFT:
            startPoint  = CGPointMake( self.frame.size.width, 0);
            endPoint    = CGPointMake( 0, 0);
            break;
            
        case GRADIENT_RIGHT:
            startPoint  = CGPointMake( 0, 0);
            endPoint    = CGPointMake( self.frame.size.width, 0);
            break;
    }
   
}

- (void)drawRect:(CGRect)rect
{
    [self drawGradient:rect];
}

-(void) drawGradient:(CGRect)rect
{
    CGFloat maskColors[] =
    {
        0.9f, 0.9f, 0.9f, 0.9f,
        0.9f, 0.75f, 0.75f, 0.75f
    };
    
    // Задаем начальные и конечные точки градиента
    [self calculateStartAndEndPoints];
    
    // Создаем черную заглушку
    CGRect frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self.color colorWithAlphaComponent:_alpha].CGColor);
    CGContextFillRect( UIGraphicsGetCurrentContext(), frame);
    CGImageRef colorRef = UIGraphicsGetImageFromCurrentImageContext().CGImage;
    
    // Созадем градиент от черного к белому
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(rgb, maskColors, NULL, sizeof(maskColors) / (sizeof(maskColors[0]) * 4));
    CGColorSpaceRelease(rgb);
    CGContextDrawLinearGradient( context, gradientRef, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGImageRef maskRef = UIGraphicsGetImageFromCurrentImageContext().CGImage;
    UIGraphicsEndImageContext();
    
    //Накладываем маску
    CGImageRef tmpMask = CGImageMaskCreate(
                                           CGImageGetWidth(maskRef),
                                           CGImageGetHeight(maskRef),
                                           CGImageGetBitsPerComponent(maskRef),
                                           CGImageGetBitsPerPixel(maskRef),
                                           CGImageGetBytesPerRow(maskRef),
                                           CGImageGetDataProvider(maskRef),
                                           NULL,
                                           false);
    
    // Рисуем результат наложения
    context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rect, CGImageCreateWithMask(colorRef, tmpMask));
    UIGraphicsEndImageContext();
}

@end
