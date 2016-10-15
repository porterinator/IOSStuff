//
//  ViewController.m
//  LoginAnimations
//
//  Created by Admin on 11/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewController.h"
#import "HumanIconAnimated.h"
#import "UIColorHex.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.etLogin.backgroundColor = [UIColor clearColor];
    self.etLogin.layer.borderColor = [UIColor clearColor].CGColor;
    UIColor *targetColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6f];
    self.etLogin.textColor = targetColor;
    [self.etLogin setTintColor:targetColor];
    self.etPassword.backgroundColor = [UIColor clearColor];
    self.etPassword.layer.borderColor = [UIColor clearColor].CGColor;
    self.etPassword.textColor = targetColor;
    [self.etPassword setTintColor:targetColor];
    [self.etLogin becomeFirstResponder];
    
    self.loginButton.backgroundColor = [UIColor colorFromHexString:@"#FF3366"];
    self.loginButton.layer.cornerRadius = 15.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClick:(id)sender
{
    [self.loginButton.titleLabel removeFromSuperview];
    [CATransaction begin];
    __block CGRect oldBounds = self.loginButton.layer.bounds;
    __block CGRect newBounds = oldBounds;
    newBounds.size.width = 30.0f;
    CABasicAnimation *toCircleAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    toCircleAnimation.duration            = .1; // "animate over 10 seconds or so.."
    toCircleAnimation.repeatCount         = 1.0;  // Animate only once..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    toCircleAnimation.fromValue = [NSValue valueWithCGRect:oldBounds];
    toCircleAnimation.toValue   = [NSValue valueWithCGRect:newBounds];
    
    // Experiment with timing to get the appearence to look the way you want
    toCircleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    self.loginButton.layer.bounds = newBounds;
    // Add the animation to the circle
    
    [CATransaction setCompletionBlock:^{
        //make bigger
        [CATransaction begin];
        oldBounds = newBounds;
        newBounds.origin = CGPointMake(self.view.frame.size.width * -1, self.view.frame.size.width * -1);
        newBounds.size = self.view.frame.size;
        newBounds.size.width = newBounds.size.width * 3;
        newBounds.size.height = newBounds.size.height * 3;
        CABasicAnimation *biggerAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
        biggerAnimation.duration            = .5; // "animate over 10 seconds or so.."
        biggerAnimation.repeatCount         = 1.0;  // Animate only once..
        biggerAnimation.beginTime = [self.loginButton.layer convertTime:CACurrentMediaTime() toLayer:nil] + 0.3;
        
        // Animate from no part of the stroke being drawn to the entire stroke being drawn
        biggerAnimation.fromValue = [NSValue valueWithCGRect:oldBounds];
        biggerAnimation.toValue   = [NSValue valueWithCGRect:newBounds];
        
        // Experiment with timing to get the appearence to look the way you want
        biggerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        //
        // Add the animation to the circle
        
        
        CABasicAnimation *cornerRadiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
        cornerRadiusAnimation.duration = .5;
        cornerRadiusAnimation.repeatCount = 1;
        cornerRadiusAnimation.beginTime = [self.loginButton.layer convertTime:CACurrentMediaTime() toLayer:nil] + 0.3;
        cornerRadiusAnimation.fromValue = [NSNumber numberWithFloat: 15.0f];
        cornerRadiusAnimation.toValue = [NSNumber numberWithFloat:newBounds.size.width / 2];
        cornerRadiusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        
        [CATransaction setCompletionBlock:^{
            self.loginButton.layer.bounds = newBounds;
            [self performSegueWithIdentifier:@"SignedIn" sender:self];
        }];
        [self.loginButton.layer addAnimation:biggerAnimation forKey:@"bounds"];
        [self.loginButton.layer addAnimation:cornerRadiusAnimation forKey:@"cornerRadius"];
        [CATransaction commit];
    }];
    

    [self.loginButton.layer addAnimation:toCircleAnimation forKey:@"bounds"];
    [CATransaction commit];
}
@end
