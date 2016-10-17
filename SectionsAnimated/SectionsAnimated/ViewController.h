//
//  ViewController.h
//  SectionsAnimated
//
//  Created by Admin on 17/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    CGRect oldRect;
    CGRect newRect;
    NSLayoutConstraint *leadingToLeftEdge;
    CGFloat oldZPosition;
}

@property (weak, nonatomic) IBOutlet UIButton *Image1;
@property (weak, nonatomic) IBOutlet UIButton *Image2;
@property (weak, nonatomic) IBOutlet UIButton *Image3;
@property (weak, nonatomic) IBOutlet UIButton *Image4;
@property (weak, nonatomic) IBOutlet UIButton *Image5;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image1WidthContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image2Leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image2WidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image3Leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Image3WidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image4WidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image4Leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image5Leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image5WidthConstraint;
- (IBAction)image1Click:(id)sender;
- (IBAction)image2Click:(id)sender;
- (IBAction)image3Click:(id)sender;
- (IBAction)image4Click:(id)sender;
- (IBAction)image5Click:(id)sender;

@end

