//
//  RentViewModel.m
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "RentViewModel.h"
#import "Luhn.h"


@interface RentViewModel ()

@property (weak, nonatomic) id<ViewModelServices> services;

@end

@implementation RentViewModel

- (instancetype)initWithServices:(id<ViewModelServices>)services currentPlace:(JitenshaPlace *)currentPlace {
    self = [super init];
    if (self) {
        _services = services;
        [self initialize];
    }
    return self;
}

- (void) initialize {
    RACSignal *validCreditCard =
    [[RACObserve(self, cardNumber)
      map:^id(NSString *text) {
          return @([Luhn validateString:text]);
      }]
     distinctUntilChanged];
    
    RACSignal *expiredValid =
    [[RACObserve(self, expired)
      map:^id(NSString *text) {
          NSString *someRegexp = @"[0-9][0-9]\/[0-9][0-9]";
          NSPredicate *expiredTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", someRegexp];
          return @([expiredTest evaluateWithObject: text]);
          //return @(text.length > 0);
      }]
     distinctUntilChanged];
    
    RACSignal *codeValid =
    [[RACObserve(self, code)
      map:^id(NSString *text) {
          NSString *t;
          if (text)
           t = [NSString stringWithString:text];
          NSString *someRegexp = @"[0-9][0-9][0-9]";
          NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", someRegexp];
          
          BOOL matches = [codeTest evaluateWithObject: t];
          return @(matches);
          //return @(text.length > 3);
      }]
     distinctUntilChanged];
    
    RACSignal *nameValid =
    [[RACObserve(self, name)
      map:^id(NSString *text) {
          NSString *someRegexp = @"[A-Z]* [A-Z]*";
          NSPredicate *expiredTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", someRegexp];
          return @([expiredTest evaluateWithObject: text]);
          //return @(text.length > 0);
      }]
     distinctUntilChanged];
    
    _rentCommand = [[RACCommand alloc] initWithEnabled:[RACSignal combineLatest:@[validCreditCard, expiredValid, codeValid, nameValid] reduce:^id(NSNumber * cardNumberValid, NSNumber * expiredValid, NSNumber * codeValid, NSNumber * nameValid){
        return @(cardNumberValid.boolValue && expiredValid.boolValue && codeValid.boolValue && nameValid.boolValue);
    }].distinctUntilChanged signalBlock:^RACSignal *(id input) {
        return [self executeRent];
    }];
}

-(RACSignal *) executeRent
{
    return [[[self.services getJitenshaService] jitenshaRentSignal:self.cardNumber name:self.name expiration:self.expired code:self.code] doNext:^(NSString *message) {
        self.message = message;
    }];
}

@end
