//
//  ColorsStatisticsTests.m
//  ColorsStatisticsTests
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>
#import "DataClient.h"

@interface ColorsStatisticsTests : XCTestCase<DataClientProtocol>
{
    XCTestExpectation *getNichesExpectation;
    DataClient *dataClient;
}
@end

@implementation ColorsStatisticsTests

- (void)setUp {
    [super setUp];
    dataClient = [DataClient new];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testDataClientGetNiches {
    getNichesExpectation = [self expectationWithDescription:@"get niches"];
    [OHHTTPStubs setEnabled:YES];
    static id<OHHTTPStubsDescriptor> stub = nil;
    stub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:@"www.mocky.io"];
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        // Stub txt files with this
        return [[OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"statistics.json", self.class)
                                                 statusCode:200
                                                    headers:@{@"Content-Type":@"text/json"}]
                requestTime: .5f
                responseTime:OHHTTPStubsDownloadSpeedWifi];
    }];

    dataClient.delegate = self;
    [dataClient getNiches];
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Server Timeout Error: %@", error);
        }
        NSLog(@"execute here after delegate called  or timeout");
    }];
    [OHHTTPStubs setEnabled:NO];
}

-(void)apiRequestDidCompleteWithResponse:(NSDictionary *)inResponseDictionary
{
    [getNichesExpectation fulfill];
    XCTAssertNotNil(inResponseDictionary,@"json object returned from server is nil");
}

-(void)apiRequestDidFailWithError:(NSError *)inError
{
    
}

@end
