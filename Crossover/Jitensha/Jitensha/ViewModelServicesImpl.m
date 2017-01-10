//
//  ViewModelServicesImpl.m
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewModelServicesImpl.h"
#import "JitenshaServiceImpl.h"
#import "PlacesViewModel.h"
#import "PlacesViewController.h"
#import "RentViewModel.h"

@interface ViewModelServicesImpl ()

@property (strong, nonatomic) JitenshaServiceImpl *jitenshaService;

@end

@implementation ViewModelServicesImpl

+ (instancetype)sharedInstance
{
    static ViewModelServicesImpl *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ViewModelServicesImpl alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _jitenshaService = [JitenshaServiceImpl new];
    }
    return self;
}

- (id<JitenshaService>)getJitenshaService {
    return self.jitenshaService;
}

@end
