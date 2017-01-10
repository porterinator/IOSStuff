//
//  JitenshaServices.h
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JitenshaService.h"

@protocol ViewModelServices <NSObject>

- (id<JitenshaService>) getJitenshaService;

@end
