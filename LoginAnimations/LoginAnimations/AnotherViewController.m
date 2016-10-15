//
//  AnotherViewController.m
//  LoginAnimations
//
//  Created by Admin on 13/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "AnotherViewController.h"
#import "UIColorHex.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
         CABasicAnimation *biggerAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
         biggerAnimation.duration            = .5; // "animate over 10 seconds or so.."
         biggerAnimation.repeatCount         = 1.0;  // Animate only once..
         biggerAnimation.beginTime = [self.offButton.layer convertTime:CACurrentMediaTime() toLayer:nil] + 0.3;
         
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
         cornerRadiusAnimation.beginTime = [self.offButton.layer convertTime:CACurrentMediaTime() toLayer:nil] + 0.3;
         cornerRadiusAnimation.fromValue = [NSNumber numberWithFloat: 15.0f];
         cornerRadiusAnimation.toValue = [NSNumber numberWithFloat:newBounds.size.width / 2];
         cornerRadiusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
         
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
