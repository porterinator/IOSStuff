//
//  ViewModelServicesImpl.h
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModelServices.h"

/**
 Holds all available models within application
 */
@interface ViewModelServicesImpl : NSObject<ViewModelServices>

+ (instancetype)sharedInstance;

@end
