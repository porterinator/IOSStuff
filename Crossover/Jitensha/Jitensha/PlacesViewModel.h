//
//  PlacesViewModel.h
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModelServices.h"
#import "JitenshaPlace.h"

@interface PlacesViewModel : NSObject

@property (weak, nonatomic) id<ViewModelServices> services;
@property (strong, nonatomic) RACCommand *getPlaces;
@property (strong, nonatomic) RACCommand *rentBicycle;
@property (strong, nonatomic) NSArray<JitenshaPlace *> *places;
@property (strong, nonatomic) JitenshaPlace *selectedPlace;

- (instancetype)initWithServices:(id<ViewModelServices>)services;

@end
