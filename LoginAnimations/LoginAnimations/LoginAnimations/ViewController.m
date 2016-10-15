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
#import "AnimationHelper.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *targetColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6f];
    self.etLogin.backgroundColor = [UIColor clearColor];
    self.etLogin.layer.borderColor = [UIColor clearColor].CGColor;
    self.etLogin.textColor = targetColor;
    [self.etLogin setTintColor:targetColor];
    [self.etLogin becomeFirstResponder];
    
    self.etPassword.backgroundColor = [UIColor clearColor];
    self.etPassword.layer.borderColor = [UIColor clearColor].CGColor;
    self.etPassword.textColor = targetColor;
    [self.etPassword setTintColor:targetColor];
    
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
    toCircleAnimation.duration            = .1;
    toCircleAnimation.repeatCount         = 1.0;
    
    toCircleAnimation.fromValue = [NSValue valueWithCGRect:oldBounds];
    toCircleAnimation.toValue   = [NSValue valueWithCGRect:newBounds];
    
    toCircleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    self.loginButton.layer.bounds = newBounds;
    
    [CATransaction setCompletionBlock:^{
        //make bigger
        [CATransaction begin];
        oldBounds = newBounds;
        newBounds.origin = CGPointMake(self.view.frame.size.width * -1, self.view.frame.size.width * -1);
        newBounds.size = self.view.frame.size;
        newBounds.size.width = newBounds.size.width * 3;
        newBounds.size.height = newBounds.size.height * 3;
        CABasicAnimation *biggerAnimation = [AnimationHelper getBiggerAnimation: self.loginButton.layer oldBounds:oldBounds newBounds:newBounds];
        
        
        CABasicAnimation *cornerRadiusAnimation = [AnimationHelper getCornerRadiusAnimation:self.loginButton.layer newBounds:newBounds];
        
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
