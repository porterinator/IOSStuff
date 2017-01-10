//
//  LoginViewModel.m
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "LoginViewModel.h"
#import "PlacesViewModel.h"


@interface LoginViewModel ()

@property (weak, nonatomic) id<ViewModelServices> services;

@end

@implementation LoginViewModel

- (instancetype)initWithServices:(id<ViewModelServices>)services {
    self = [super init];
    if (self) {
        _services = services;
        [self initialize];
    }
    return self;
}


-(void) initialize {
    RACSignal *validLoginSignal =
    [[RACObserve(self, login)
      map:^id(NSString *text) {
          return @(text.length > 0);
      }]
     distinctUntilChanged];
    
    RACSignal *validPasswordSignal =
    [[RACObserve(self, password)
      map:^id(NSString *text) {
          return @(text.length > 0);
      }]
     distinctUntilChanged];
    
    self.signIn = [[RACCommand alloc] initWithEnabled:[RACSignal combineLatest:@[validLoginSignal, validPasswordSignal] reduce:^id(NSNumber * loginValid, NSNumber * passwordValid){
        return @(loginValid.boolValue && passwordValid.boolValue);
    }].distinctUntilChanged signalBlock:^RACSignal *(id input) {
        return [self executeSignInSignal];
    }];
    self.registr = [[RACCommand alloc] initWithEnabled:[RACSignal combineLatest:@[validLoginSignal, validPasswordSignal] reduce:^id(NSNumber * loginValid, NSNumber * passwordValid){
        return @(loginValid.boolValue && passwordValid.boolValue);
    }].distinctUntilChanged signalBlock:^RACSignal *(id input) {
        return [self executeRegisterSignal];
    }];
    self.connectionErrors = [RACSignal combineLatest:@[self.signIn.errors, self.registr.errors]] ;
}

-(RACSignal *) executeSignInSignal {
    return [[self.services getJitenshaService] jitenshaLoginSignal:self.login password:[NSString stringWithString:self.password]];
}

-(RACSignal *) executeRegisterSignal {
    return [[self.services getJitenshaService] jitenshaRegisterSignal:self.login password:[NSString stringWithString:self.password]];
}


@end
