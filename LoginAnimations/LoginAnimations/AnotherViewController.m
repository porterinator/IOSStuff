//
//  AnotherViewController.m
//  LoginAnimations
//
//  Created by Admin on 13/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "AnotherViewController.h"
#import "UIColorHex.h"
#import "AnimationHelper.h"

@interface AnotherViewController ()

@end

@implementation AnotherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.imgAvatar.layer setCornerRadius:75.0f];
    [self.imgAvatar.layer setMasksToBounds:YES];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)offButtonClick:(id)sender {
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^
     {
         CGRect frame = self.offButton.frame;
         frame.origin.y = self.view.frame.size.height / 2 - 30.0f;
         frame.origin.x = self.view.frame.size.width / 2 - 30.0f;
         self.offButton.frame = frame;
     }
                     completion:^(BOOL finished)
     {
         //make bigger
         [CATransaction begin];
         __block CGRect oldBounds = self.offButton.layer.bounds;
         __block CGRect newBounds = oldBounds;
         newBounds.origin = CGPointMake(self.view.frame.size.width * -1, self.view.frame.size.width * -1);
         newBounds.size = self.view.frame.size;
         newBounds.size.width = newBounds.size.width * 3;
         newBounds.size.height = newBounds.size.height * 3;
         CABasicAnimation *biggerAnimation = [AnimationHelper getBiggerAnimation:self.offButton.layer oldBounds:oldBounds newBounds:newBounds];
         
         
         CABasicAnimation *cornerRadiusAnimation = [AnimationHelper getCornerRadiusAnimation:self.offButton.layer newBounds:newBounds];
         
         CABasicAnimation *toCenterAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
         toCenterAnimation.duration = .5;
         toCenterAnimation.repeatCount = 1;
         toCenterAnimation.beginTime = [self.offButton.layer convertTime:CACurrentMediaTime() toLayer:nil] + 0.3;
         CGRect oldPosition = self.offButton.arc.bounds;
         CGRect newPosition =  oldPosition;
         newPosition.origin.x = newBounds.origin.x + newBounds.size.width / 2 - 30;
         newPosition.origin.y = newBounds.origin.y + newBounds.size.height / 2 - 30;
         toCenterAnimation.fromValue = [NSValue valueWithCGRect:oldPosition];
         toCenterAnimation.toValue = [NSValue valueWithCGRect:newPosition];
         toCenterAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
         
         
         [CATransaction setCompletionBlock:^{
             self.offButton.layer.bounds = newBounds;
             self.offButton.arc.bounds = newPosition;
             self.offButton.box.bounds = newPosition;
             [self performSegueWithIdentifier:@"BackToLogin" sender:self];
         }];
         [self.offButton.layer addAnimation:biggerAnimation forKey:@"bounds"];
         [self.offButton.layer addAnimation:cornerRadiusAnimation forKey:@"cornerRadius"];
         [self.offButton.box addAnimation:toCenterAnimation forKey:@"position"];
         [self.offButton.arc addAnimation:toCenterAnimation forKey:@"position"];
         [CATransaction commit];
         
     }];
}

@end
