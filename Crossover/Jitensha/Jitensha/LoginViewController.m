//
//  ViewController.m
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "LoginViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PlacesViewModel.h"
#import "PlacesViewController.h"
#import "ViewModelServicesImpl.h"


@interface LoginViewController ()

@property(weak, nonatomic) LoginViewModel *viewModel;

@end

@implementation LoginViewController


-(void) setViewModel:(LoginViewModel *)loginViewModel {
    _viewModel = loginViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
    
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tfLogin becomeFirstResponder];
}

-(void) bindViewModel {
    
    [self.header setText:NSLocalizedString(@"Jitensha bike rental", nil)];
    [self.btSignIn setTitle:NSLocalizedString(@"Sign In", nil) forState:UIControlStateNormal];
    [self.btRegister setTitle:NSLocalizedString(@"Register", nil) forState:UIControlStateNormal];
                                              
    RAC(self.viewModel, login) = self.tfLogin.rac_textSignal;
    RAC(self.viewModel, password) = self.tfPassword.rac_textSignal;
    self.btSignIn.rac_command = self.viewModel.signIn;
    self.btRegister.rac_command = self.viewModel.registr;
    
    [self.viewModel.signIn.errors subscribeNext:^(NSError *error) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"There was a problem loggin in to Jitensha.";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hideAnimated:YES afterDelay:3];
    }];
    [self.viewModel.registr.errors subscribeNext:^(NSError *error) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"There was a problem registering in Jitensha.";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hideAnimated:YES afterDelay:3];
    }];
    [[[self.viewModel.signIn executionSignals] concat ]subscribeNext:^(id x) {
        [self.tfLogin resignFirstResponder];
        [self.tfPassword resignFirstResponder];
        [self performSegueWithIdentifier:@"showPlaces" sender:self];
    }];
    [[[self.viewModel.registr executionSignals] concat ]subscribeNext:^(id x) {
        [self performSegueWithIdentifier:@"showPlaces" sender:self];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showPlaces"]) {
        PlacesViewController *placesViewContorller = (PlacesViewController *) segue.destinationViewController;
        PlacesViewModel *placesViewModel = [[PlacesViewModel alloc] initWithServices:[ViewModelServicesImpl sharedInstance]];
        [placesViewContorller setViewModel: placesViewModel];
    }
}


@end
