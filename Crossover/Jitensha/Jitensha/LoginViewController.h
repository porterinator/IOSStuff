//
//  ViewController.h
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewModel.h"
#import "MBProgressHUD.h"
#import "KeyboardViewController.h"

@interface LoginViewController : KeyboardViewController

@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UITextField *tfLogin;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btSignIn;
@property (weak, nonatomic) IBOutlet UIButton *btRegister;


-(void) setViewModel:(LoginViewModel *)loginViewModel;


@end

