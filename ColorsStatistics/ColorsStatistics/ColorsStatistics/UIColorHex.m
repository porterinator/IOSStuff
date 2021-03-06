//
//  UIColorHex.m
//  LoginAnimations
//
//  Created by Admin on 15/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "UIColorHex.h"

@implementation UIColor (UIColorHex)

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; 
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
