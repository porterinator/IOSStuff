//
//  RentController.h
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RentViewModel.h"
#import "MBProgressHUD.h"
#import "KeyboardViewController.h"

@interface RentController : KeyboardViewController

@property (weak, nonatomic) IBOutlet UITextField *cardNumber;
@property (weak, nonatomic) IBOutlet UITextField *expired;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UIButton *btRent;
@property (weak, nonatomic) IBOutlet UIButton *btCancel;
//- (IBAction)cancelPressed:(id)sender;
- (void) setViewModel:(RentViewModel *) rentViewModel;

@end
