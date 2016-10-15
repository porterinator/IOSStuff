//
//  AnotherViewController.h
//  LoginAnimations
//
//  Created by Admin on 13/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OffButton.h"

@interface AnotherViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet OffButton *offButton;
- (IBAction)offButtonClick:(id)sender;
@end
