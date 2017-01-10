//
//  JitenshaApiClient.h
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <SAMKeychain/SAMKeychain.h>
#import "JitenshaApiClientDelegate.h"


/**
 simplifies server API method invokation
 */
@interface JitenshaApiClient : NSObject

@property(weak, nonatomic) id<JitenshaApiClientDelegate> delegate;

-(void)callApiMethodWithPost:(NSString *)method arguments:(NSDictionary *)arguments;

-(void) callApiMethodWithGet:(NSString *)method arguments:(NSDictionary *)arguments;

@end
