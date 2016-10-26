//
//  DataClient.h
//  ColorsStatistics
//
//  Created by Admin on 18/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataClient : NSObject
{
    NSURLSessionConfiguration* sessionConfig;
    NSURLSession *session;
    NSURL* downloadTaskURL;
    
}

-(void) getNiches:(void (^)(id json))success
          failure:(void (^)(NSError * error))failure;

@end
