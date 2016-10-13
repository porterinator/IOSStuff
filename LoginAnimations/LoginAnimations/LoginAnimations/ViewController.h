//
//  ViewController.h
//  LoginAnimations
//
//  Created by Admin on 11/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *etLogin;

@property (weak, nonatomic) IBOutlet UITextField *etPassword;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)loginClick:(id)sender;

@end

