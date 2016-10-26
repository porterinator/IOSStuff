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


#pragma mark - Properties
- (NSInteger)count
{
    return nicheCursor.count;
}

#pragma mark - Public methods
- (NSMutableDictionary *)objectAtIndexedSubscript:(NSUInteger)idx
{
    return nicheCursor[idx];
}

-(void) getNiches:(void(^)())success
          failure:(void (^)(NSError * error))failure
{
        [dataClient getNiches:^(id json) {
            NSDictionary *response = (NSDictionary *)json;
            NSArray *niches = response[kNicheStats];
            [[NicheDB default] removeAllNiches];
            for (int i = 0; i < [niches count]; i++) {
                [[NicheDB default] insertNiche:niches[i]];
            }
            nicheCursor = [[NicheDB default] getNiches];
            dispatch_async(dispatch_get_main_queue(),^{
                success();
            });
            
            
        } failure:^(NSError *error) {
            nicheCursor = [[NicheDB default] getNiches];
            dispatch_async(dispatch_get_main_queue(), ^{
                success();
            });
        }];
}

@end
