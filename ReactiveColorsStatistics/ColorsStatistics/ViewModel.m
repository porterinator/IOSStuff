//
//  ViewModel.m
//  ColorsStatistics
//
//  Created by Admin on 12/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewModel.h"

@interface ViewModel ()

@property (strong, nonatomic) NicheModel *nicheModel;

@end


@implementation ViewModel

-(instancetype) initWithNicheModel: (NicheModel *) nicheModel
{
    self = [super init];
    if (self) {
        _nicheModel = nicheModel;
        [self initialize];
    }
    return self;
}

-(void) initialize
{
    self.getStatistics = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self executeGetStatistics];
    }];
}


-(RACSignal *) executeGetStatistics
{
    return [[_nicheModel getNichesSignal] doNext:^(SQLite3Cursor *cursor) {
        self.niches = cursor;
    }];
}

@end
