//
//  RentController.m
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "RentController.h"



@interface RentController ()

@property(weak, nonatomic) RentViewModel *viewModel;

@end

@implementation RentController

- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) setViewModel:(RentViewModel *) rentViewModel {
    _viewModel = rentViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.cardNumber becomeFirstResponder];
}

-(void) bindViewModel {
    [self.cardNumber setPlaceholder:NSLocalizedString(@"CARD NUMBER", nil)];
    [self.expired setPlaceholder:NSLocalizedString(@"Month / Year", nil)];
    [self.name setPlaceholder:NSLocalizedString(@"NAME SURNAME", nil)];
    [self.btCancel setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    
    RAC(self.viewModel, cardNumber) = self.cardNumber.rac_textSignal;
    RAC(self.viewModel, expired) = self.expired.rac_textSignal;
    RAC(self.viewModel, code) = self.code.rac_textSignal;
    RAC(self.viewModel, name) = self.name.rac_textSignal;
    self.btRent.rac_command = self.viewModel.rentCommand;
    [[[self.viewModel.rentCommand executionSignals] concat] subscribeNext:^(id x) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //[self.view addSubview:hud];
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.label.text = self.viewModel.message;
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hideAnimated:YES afterDelay:3];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.cardNumber resignFirstResponder];
            [self.expired resignFirstResponder];
            [self.code resignFirstResponder];
            [self.name resignFirstResponder];
            [self dismissViewControllerAnimated:YES completion:nil];
        });
        //
    }];
    
    [self.viewModel.rentCommand.errors subscribeNext:^(NSError *error) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"There was a problem renting a bike";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hideAnimated:YES afterDelay:3];
    }];
}

@end
