//
//  JitenshaApiClientDelegate.h
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JitenshaApiClientDelegate <NSObject>

-(void) didCompleteWithResponse:(NSDictionary *) response;
-(void) didFailWithError:(NSError *) error;

@end
