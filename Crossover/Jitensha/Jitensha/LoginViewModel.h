//
//  LoginViewModel.h
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ViewModelServices.h"

@interface LoginViewModel : NSObject

- (instancetype)initWithServices:(id<ViewModelServices>)services;

@property(strong, nonatomic) NSString *login;
@property(strong, nonatomic) NSString *password;
@property(strong, nonatomic) RACCommand *signIn;
@property(strong, nonatomic) RACCommand *registr;
@property (strong, nonatomic) RACSignal *connectionErrors;

@end
