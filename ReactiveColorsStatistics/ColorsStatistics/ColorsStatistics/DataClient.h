//
//  DataClient.h
//  ColorsStatistics
//
//  Created by Admin on 18/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataClientProtocol
- (void)apiRequestDidCompleteWithResponse:(NSDictionary *)inResponseDictionary;
- (void)apiRequestDidFailWithError:(NSError *)inError;
@end

@interface DataClient : NSObject<NSURLSessionDelegate,NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate>
{
    NSURLSessionConfiguration* sessionConfig;
    NSURLSession *session;
    NSURL* downloadTaskURL;
    
}

@property(weak, nonatomic) id<DataClientProtocol> delegate;

-(void) getNiches;

@end
