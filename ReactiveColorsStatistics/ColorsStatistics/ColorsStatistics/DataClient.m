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
        session = [NSURLSession sessionWithConfiguration:sessionConfig delegate: self delegateQueue:nil];
        downloadTaskURL = [NSURL URLWithString:@"http://www.mocky.io/v2/57ff840b1300006c09cce2d8"];
    }
    return self;
}

-(void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSError *fileManagerError;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = [urls objectAtIndex:0];
    
    NSURL *originalUrl = [NSURL URLWithString:[downloadTaskURL lastPathComponent]];
    NSURL *destinationUrl = [documentsDirectory URLByAppendingPathComponent:[originalUrl lastPathComponent]];
    
    
    NSString *path =[destinationUrl path];
    if ([fileManager fileExistsAtPath:path])
        [fileManager removeItemAtURL:destinationUrl error:NULL];
    BOOL copiedFine = [fileManager copyItemAtURL:location toURL:destinationUrl error:&fileManagerError];
    if (copiedFine) {
        [fileManager removeItemAtURL:originalUrl error:NULL];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSError *parseError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
        if (parseError) {
            [self.delegate apiRequestDidFailWithError:parseError];
        } else {
            [self.delegate apiRequestDidCompleteWithResponse:json];
        }
    } else {
        [self.delegate apiRequestDidFailWithError:fileManagerError];
    }
}

/*- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    [self.delegate apiRequestDidFailWithError:error];
}*/

-(void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error
{
    [self.delegate apiRequestDidFailWithError:error];
}

-(void) getNiches
{
    [[session downloadTaskWithURL:downloadTaskURL] resume];
}

@end
