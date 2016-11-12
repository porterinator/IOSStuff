//
//  NicheModel.m
//  ColorsStatistics
//
//  Created by Admin on 19/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "NicheModel.h"
#import "Consts.h"
#import "NicheDB.h"

@interface NicheModel ()

@property (nonatomic) DataClient * dataClient;

@end

@implementation NicheModel

@synthesize dataClient = dataClient;

- (id)init
{
    self = [super init];
    if (self) {
        dataClient = [DataClient new];
    }
    return self;
}

- (RACSignal *)signalFromAPIMethod:(id (^)(NSDictionary *response))block {
    
    // 1. Create a signal for this request
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // 2. set delegate to data client
        dataClient.delegate = self;
        
        RACSignal *errorSignal =
        [self rac_signalForSelector:@selector(apiRequestDidFailWithError:)
                       fromProtocol:@protocol(DataClientProtocol)];
        
        [errorSignal subscribeNext:^(RACTuple *tuple) {
            [subscriber sendError:tuple.first];
        }];
        
        // 3. Create a signal from the delegate method
        RACSignal *successSignal =
        [self rac_signalForSelector:@selector(apiRequestDidCompleteWithResponse:)
                       fromProtocol:@protocol(DataClientProtocol)];
        
        [[[successSignal map:^id(RACTuple *tuple) {
            return tuple.first;
        }] map:block] subscribeNext:^(id x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }];
        
        // 5. Make the request
        [dataClient getNiches];
        
        // 6. When we are done, remvoe the reference to this request
        return [RACDisposable disposableWithBlock:^{
           
        }];
    }];
}

- (RACSignal *)getNichesSignal
{
    return [self signalFromAPIMethod:^id(NSDictionary *response) {
        NSArray *niches = response[kNicheStats];
        [[NicheDB default] removeAllNiches];
        for (int i = 0; i < [niches count]; i++) {
            [[NicheDB default] insertNiche:niches[i]];
        }
        SQLite3Cursor *nicheCursor = [[NicheDB default] getNiches];
        return nicheCursor;
    }];
}

@end
