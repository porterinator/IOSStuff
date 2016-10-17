//
//  ViewController.m
//  SectionsAnimated
//
//  Created by Admin on 17/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+BackgroundContentMode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.Image1 setBackgroundImage:[UIImage imageNamed:@"Image"] forState:UIControlStateNormal];
    self.Image1.backgroundContentMode = UIViewContentModeScaleAspectFill;
    [self.Image2 setBackgroundImage:[UIImage imageNamed:@"Image-1"] forState:UIControlStateNormal];
    self.Image2.backgroundContentMode = UIViewContentModeScaleAspectFill;
    [self.Image3 setBackgroundImage:[UIImage imageNamed:@"Image-2"] forState:UIControlStateNormal];
    self.Image3.backgroundContentMode = UIViewContentModeScaleAspectFill;
    [self.Image4 setBackgroundImage:[UIImage imageNamed:@"Image-3"] forState:UIControlStateNormal];
    self.Image4.backgroundContentMode = UIViewContentModeScaleAspectFill;
    [self.Image5 setBackgroundImage:[UIImage imageNamed:@"Image-4"] forState:UIControlStateNormal];
    self.Image5.backgroundContentMode = UIViewContentModeScaleAspectFill;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)image1Click:(id)sender {
    UIButton *button = (UIButton *)sender;
    oldZPosition = button.layer.zPosition;
    button.layer.zPosition = 1;
    [self.view layoutIfNeeded];
    if ([self.view.constraints containsObject:self.image1WidthContraint]){
        [self.view removeConstraint:self.image1WidthContraint];
        
        NSLayoutConstraint *width =[NSLayoutConstraint
                                    constraintWithItem:self.view
                                    attribute:NSLayoutAttributeWidth
                                    relatedBy:0
                                    toItem:self.Image1
                                    attribute:NSLayoutAttributeWidth
                                    multiplier:1.0
                                    constant:0];
        [self.view addConstraint:width];
        [UIView animateWithDuration:1.0 animations:^{
            // Animate the changes
            [self.view layoutIfNeeded];
        }];
    } else {
        [self.view addConstraint:self.image1WidthContraint];
        [UIView animateWithDuration:1.0 animations:^{
            // Animate the changes
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            button.layer.zPosition = oldZPosition;
        }];
    }
    
}

- (IBAction)image2Click:(id)sender {
    [self animate:sender widthConstraint:_image2WidthConstraint leadingConstraint:_image2Leading image:self.Image2];
}

- (IBAction)image3Click:(id)sender {
    [self animate:sender widthConstraint:_Image3WidthConstraint leadingConstraint:_image3Leading image:self.Image3];
}

- (IBAction)image4Click:(id)sender {
    [self animate:sender widthConstraint:_image4WidthConstraint leadingConstraint:_image4Leading image:self.Image4];
}

- (IBAction)image5Click:(id)sender {
    [self animate:sender widthConstraint:_image5WidthConstraint leadingConstraint:_image5Leading image:self.Image5];
}

- (void) animate:(id) sender widthConstraint: (NSLayoutConstraint *) widthConstraint leadingConstraint: (NSLayoutConstraint *)leadingConstraint image:(UIButton *)image
{
    UIButton *button = (UIButton *)sender;
    if ([self.view.constraints containsObject:widthConstraint]) {
        oldZPosition = button.layer.zPosition;
        button.layer.zPosition = 1;
        [self.view layoutIfNeeded];
        [self.view removeConstraint:leadingConstraint];
        leadingToLeftEdge =[NSLayoutConstraint
                            constraintWithItem:self.view
                            attribute:NSLayoutAttributeLeading
                            relatedBy:0
                            toItem:image
                            attribute:NSLayoutAttributeLeading
                            multiplier:1.0
                            constant:0];
        [self.view addConstraint:leadingToLeftEdge];
        [UIView animateWithDuration:1.0 animations:^{
            // Animate the changes
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self.view layoutIfNeeded];
            [self.view removeConstraint:widthConstraint];
            NSLayoutConstraint *width =[NSLayoutConstraint
                                        constraintWithItem:self.view
                                        attribute:NSLayoutAttributeWidth
                                        relatedBy:0
                                        toItem:image
                                        attribute:NSLayoutAttributeWidth
                                        multiplier:1.0
                                        constant:0];
            [self.view addConstraint:width];
            [UIView animateWithDuration:1.0 animations:^{
                // Animate the changes
                [self.view layoutIfNeeded];
            }];
        }];
    } else {
        
        [self.view addConstraint:widthConstraint];
        [UIView animateWithDuration:1.0 animations:^{
            // Animate the changes
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self.view layoutIfNeeded];
            [self.view removeConstraint:leadingToLeftEdge];
            [self.view addConstraint:leadingConstraint];
            [UIView animateWithDuration:1.0 animations:^{
                // Animate the changes
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                button.layer.zPosition = oldZPosition;
            }];
        }];
    }
}

@end
