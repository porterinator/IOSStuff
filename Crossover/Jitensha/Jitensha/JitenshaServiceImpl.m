//
//  JitenshaLoginImpl.m
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "JitenshaServiceImpl.h"
#import "JitenshaApiClient.h"
#import <SAMKeychain/SAMKeychain.h>
#import "JitenshaPlace.h"


@interface JitenshaServiceImpl () <JitenshaApiClientDelegate>

@property(strong, nonatomic) JitenshaApiClient *apiClient;

@end

@implementation JitenshaServiceImpl

- (instancetype)init {
    self = [super init];
    if (self) {
        _apiClient = [JitenshaApiClient new];
        _apiClient.delegate = self;
    }
    return self;
}


- (RACSignal *)signalFromAPIMethod:(NSString *)method
                         arguments:(NSDictionary *)args
                              post: (BOOL)post
                         transform:(id (^)(NSDictionary *response))block {
    
    // 1. Create a signal for this request
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

        RACSignal *errorSignal =
        [self rac_signalForSelector:@selector(didFailWithError:)
                       fromProtocol:@protocol(JitenshaApiClientDelegate)];
        
        [errorSignal subscribeNext:^(RACTuple *tuple) {
            [subscriber sendError:tuple.first];
        }];
        
        // 3. Create a signal from the delegate method
        RACSignal *successSignal =
        [self rac_signalForSelector:@selector(didCompleteWithResponse:)
                       fromProtocol:@protocol(JitenshaApiClientDelegate)];
        
        [[[successSignal map:^id(RACTuple *tuple) {
            return tuple.first;
        }] map:block] subscribeNext:^(id x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }];
        
        // 5. Make the request
        if (post) {
        [_apiClient callApiMethodWithPost:method
                                  arguments:args];
        } else {
            [_apiClient callApiMethodWithGet:method
                                    arguments:args];
        }
        
        // 6. When we are done, remvoe the reference to this request
        return [RACDisposable disposableWithBlock:^{}];
    }];
}

- (RACSignal *)jitenshaLoginSignal:(NSString *)login password:(NSString *)password {
    return [self signalFromAPIMethod:@"auth" arguments:[NSDictionary dictionaryWithObjectsAndKeys:login, @"email", password, @"password", nil] post: YES transform:^id(NSDictionary *response) {
        NSString *accessToken = [response valueForKey:@"accessToken"];
        [SAMKeychain setPassword:accessToken forService:@"JitenshaService" account:@"Jitensha"];
        return response;
    }];
}

- (RACSignal *)jitenshaRegisterSignal:(NSString *)login password:(NSString *)password {
    return [self signalFromAPIMethod:@"register" arguments:[NSDictionary dictionaryWithObjectsAndKeys:login, @"email", password, @"password", nil] post: YES transform:^id(NSDictionary *response) {
        NSString *accessToken = [response valueForKey:@"accessToken"];
        [SAMKeychain setPassword:accessToken forService:@"JitenshaService" account:@"Jitensha"];
        return response;
    }];
}

- (RACSignal *)jitenshaGetPlacesSignal {
    return [self signalFromAPIMethod:@"places" arguments:nil post:NO transform:^id(NSDictionary *response) {
        //transforming unstuctured dictionary to plain object with typed attributes
        NSMutableArray *places = [NSMutableArray array];
        NSArray *placesArray = response[@"results"];
        for (int i = 0; i < [placesArray count]; i++) {
            JitenshaPlace *place = [JitenshaPlace new];
            place.lat = [[placesArray[i] valueForKeyPath:@"location.lat"] doubleValue];
            place.lng = [[placesArray[i] valueForKeyPath:@"location.lng"] doubleValue];
            place.id = [placesArray[i] valueForKey:@"id"];
            place.name = [placesArray[i] valueForKey:@"name"];
            [places addObject:place];
        }
        return places;
    }];
}

- (RACSignal *)jitenshaRentSignal:(NSString *)number name:(NSString *)name expiration:(NSString *)expiration code:(NSString *)code {
    return [self signalFromAPIMethod:@"rent" arguments:[NSDictionary dictionaryWithObjectsAndKeys:number, @"number", name, @"name", expiration, @"expiration", code, @"code", nil] post:YES transform:^id(NSDictionary *response) {
        return [response valueForKey:@"message"];
    }];
}

@end
