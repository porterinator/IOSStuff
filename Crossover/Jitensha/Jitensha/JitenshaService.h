//
//  JitenshaLogin.h
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

/**
 contains all possible server API mehtods
 */
@protocol JitenshaService <NSObject>

- (RACSignal *)jitenshaLoginSignal:(NSString *)login password:(NSString *)password;
- (RACSignal *)jitenshaRegisterSignal:(NSString *)login password:(NSString *)password;
- (RACSignal *)jitenshaGetPlacesSignal;
- (RACSignal *)jitenshaRentSignal:(NSString *) number name:(NSString *)name expiration:(NSString *) expiration code:(NSString *) code;

@end
