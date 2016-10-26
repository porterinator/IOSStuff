//
//  DataClient.m
//  ColorsStatistics
//
//  Created by Admin on 18/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "DataClient.h"

@implementation DataClient


- (instancetype)init
{
    self = [super init];
    if (self) {
        sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:sessionConfig];
        downloadTaskURL = [NSURL URLWithString:@"http://www.mocky.io/v2/57ff840b1300006c09cce2d8"];
    }
    return self;
}

-(void) getNiches:(void (^)(id json))success
                 failure:(void (^)(NSError * error))failure;
{
    [[session downloadTaskWithURL: downloadTaskURL
                completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                    NSError *fileManagerError;
                    if (!error) {
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    
                    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
                    NSURL *documentsDirectory = [urls objectAtIndex:0];
                    
                    NSURL *originalUrl = [NSURL URLWithString:[downloadTaskURL lastPathComponent]];
                    NSURL *destinationUrl = [documentsDirectory URLByAppendingPathComponent:[originalUrl lastPathComponent]];
                    
                    
                    NSString *path =[destinationUrl path];
                    if ([fileManager fileExistsAtPath:path])
                        [fileManager removeItemAtURL:destinationUrl error:NULL];
                    BOOL copedFine = [fileManager copyItemAtURL:location toURL:destinationUrl error:&fileManagerError];
                    
                    [fileManager removeItemAtURL:originalUrl error:NULL];
                    NSData *data = [NSData dataWithContentsOfFile:path];
                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                        if (fileManagerError != nil){
                            failure(fileManagerError);
                        } else {
                            success(json);
                        }
                    } else {
                        failure(error);
                    }
                    
                }] resume];
}

@end
