//
//  PlacesViewModel.m
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "PlacesViewModel.h"
#import "RentViewModel.h"


@interface PlacesViewModel ()



@end

@implementation PlacesViewModel

- (instancetype)initWithServices:(id<ViewModelServices>)services {
    self = [super init];
    if (self) {
        _services = services;
        [self initialize];
    }
    return self;
}

-(void) initialize {
    self.getPlaces = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self executeGetPlaces];
    }];
}

-(RACSignal *) executeGetPlaces
{
    return [[[self.services getJitenshaService] jitenshaGetPlacesSignal] doNext:^(NSArray *places) {
        self.places = places;
    }];
}

@end
