//
//  CityView.m
//  ParallaxScroll
//
//  Created by Admin on 24/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "CityView.h"

@interface CityView (){
    CGImageRef colorRef;
    CGImageRef maskRef;
    CGImageRef darkLayer;
    CGImageRef imageStripe;
    CGImageRef darkStripe;
    CGRect stripeRect;
    NSDictionary *textAttributes;
    CGSize backSize;
    CGSize leftSize;
    CGSize rightSize;
    float parallaxMultiplier;
}

@end

@implementation CityView

@synthesize cityImage, leftText, backText, rightText;

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        offset = 0.0;
        parallaxMultiplier = 1.3;
        textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                          [UIFont fontWithName:@"HelveticaNeue-Bold" size:154], NSFontAttributeName,
                          [UIColor whiteColor], NSForegroundColorAttributeName,
                          nil];
        backSize = [backText sizeWithAttributes:textAttributes];
        leftSize = [leftText sizeWithAttributes:textAttributes];
        rightSize = [rightText sizeWithAttributes:textAttributes];
    }
    return self;
}

-(void) setLeftText:(NSString *)leftText
{
    self->leftText = leftText;
    leftSize = [leftText sizeWithAttributes:textAttributes];
}

-(void) setRightText:(NSString *)rightText
{
    self->rightText = rightText;
    rightSize = [rightText sizeWithAttributes:textAttributes];
}

-(void) setBackText:(NSString *)backText
{
    self->backText = backText;
    backSize = [backText sizeWithAttributes:textAttributes];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //рисуем картинку
    if (!imageStripe) {
        //готовим фон
        [cityImage drawInRect:rect];
        //готовим узкую полоску которая будет менятся при скролле, ее надо перерисовывать т.к текст будет постоянно в разных местах
        stripeRect = rect;
        stripeRect.origin.y = (rect.size.height - backSize.height) / 2;
        stripeRect.size.height = backSize.height;
        //ресайзим картинку до размеров окна
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);
        CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, cityImage.CGImage);
        //собственно вырезаем полоску
        imageStripe = CGImageCreateWithImageInRect(UIGraphicsGetImageFromCurrentImageContext().CGImage, stripeRect);
        UIGraphicsEndImageContext();
    } else {
        //если есть полоска это значит что первичная отрисовка изображения города уже была и можем затереть только полоску
        CGContextDrawImage(context, stripeRect, imageStripe);
    }
    //рисуем текст за большой буквой
    CGRect backRect = CGRectMake(rect.origin.x + (rect.size.width - backSize.width - offset * parallaxMultiplier) / 2.0,
                          rect.origin.y + (rect.size.height - backSize.height) / 2.0,
                          rect.size.width,
                          backSize.height);
    [[UIColor whiteColor] setFill];
    [backText drawInRect:backRect withAttributes:textAttributes];
    //::~
    
    //делаем темный полупрозрачный фон
    //для начала делаем картику с черным фоном по размеру окна
    if (!colorRef) {
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);
        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextFillRect( UIGraphicsGetCurrentContext(), rect);
        colorRef = UIGraphicsGetImageFromCurrentImageContext().CGImage;
        UIGraphicsEndImageContext();
    }
    
    //готовим серую маску на который белым написана первая буква города. на месте белого цвета полная прозрачность на месте серого полупрозрачность.
    if (!maskRef) {
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [UIColor grayColor].CGColor);
        CGContextFillRect( UIGraphicsGetCurrentContext(), rect);
        CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0, rect.size.height);
        CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1.0, -1.0);
        [[UIColor whiteColor] setFill];
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont fontWithName:@"HelveticaNeue-Bold" size:1000], NSFontAttributeName,
                                nil];
        NSString *firstLetter = [leftText substringToIndex:1];
        CGSize size = [firstLetter sizeWithAttributes:attributes];
        CGRect r = CGRectMake(rect.origin.x + (rect.size.width - size.width) / 2.0,
                          rect.origin.y + (rect.size.height - size.height) / 2.0,
                          rect.size.width,
                          size.height);
        [firstLetter drawInRect:r withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:1000]];
        maskRef = UIGraphicsGetImageFromCurrentImageContext().CGImage;
        UIGraphicsEndImageContext();
    
        CGImageRef tmpMask = CGImageMaskCreate(
                                           CGImageGetWidth(maskRef),
                                           CGImageGetHeight(maskRef),
                                           CGImageGetBitsPerComponent(maskRef),
                                           CGImageGetBitsPerPixel(maskRef),
                                           CGImageGetBytesPerRow(maskRef),
                                           CGImageGetDataProvider(maskRef),
                                           NULL,
                                           false);
        darkLayer = CGImageCreateWithMask(colorRef, tmpMask);
        
    }
    //::~
    //рисуем полупрозрачный фон
    if (!darkStripe) {
        //полностью если у нас первая отрисовка
        CGContextDrawImage(context, rect, darkLayer);
        darkStripe = CGImageCreateWithImageInRect(darkLayer, stripeRect);
    } else {
        //только полоску для оптимизации если это последующие отрисовки
        CGContextDrawImage(context, stripeRect, darkStripe);
    }
    //::~
    
    //рисукм левую часть текста
    CGRect r = CGRectMake(rect.origin.x + (rect.size.width - leftSize.width * 2.0 - backSize.width - offset * parallaxMultiplier)/2.0,
                          rect.origin.y + (rect.size.height - leftSize.height) / 2.0,
                          rect.size.width,
                          leftSize.height);
    [[UIColor whiteColor] setFill];
    [leftText drawInRect:r withAttributes:textAttributes];
    //::~
    //рисуем правую часть текста
    r = CGRectMake(rect.origin.x + (rect.size.width  + backSize.width  - offset * parallaxMultiplier) / 2.0,
                   rect.origin.y + (rect.size.height - rightSize.height) / 2.0,
                   rect.size.width - offset,
                   rightSize.height);
    [[UIColor whiteColor] setFill];
    [rightText drawInRect:r withAttributes:textAttributes];
    //::~
}

- (void)setNeedsDisplayInRect
{
    [self setNeedsDisplayInRect:stripeRect];
}


@end
