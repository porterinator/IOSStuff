//
//  JitenshaApiClient.m
//  Jitensha
//
//  Created by Admin on 11/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JitenshaApiClient.h"
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>

@interface JitenshaApiClientTests : XCTestCase<JitenshaApiClientDelegate>
{
    XCTestExpectation *getExpectation;
    XCTestExpectation *postExpectation;
    JitenshaApiClient *apiClient;
}
@end

@implementation JitenshaApiClientTests

- (void)setUp {
    [super setUp];
    apiClient = [JitenshaApiClient new];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testGet {
    getExpectation = [self expectationWithDescription:@"get"];
    [OHHTTPStubs setEnabled:YES];
    static id<OHHTTPStubsDescriptor> stub = nil;
    stub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {        return [[OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"places.json", self.class)
                                                 statusCode:200
                                                    headers:@{@"Content-Type":@"application/json"}]
                requestTime: .5f
                responseTime:OHHTTPStubsDownloadSpeedWifi];
    }];
    
    apiClient.delegate = self;
    [apiClient callApiMethodWithGet:@"places" arguments:nil];
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Server Get Request Timeout Error: %@", error);
        }
    }];
    [OHHTTPStubs setEnabled:NO];
}

- (void) testPost {
    postExpectation = [self expectationWithDescription:@"post"];
    [OHHTTPStubs setEnabled:YES];
    static id<OHHTTPStubsDescriptor> stub = nil;
    stub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        return [[OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(@"login.json", self.class)
                                                 statusCode:200
                                                    headers:@{@"Content-Type":@"application/json"}]
                requestTime: .5f
                responseTime:OHHTTPStubsDownloadSpeedWifi];
    }];
    
    apiClient.delegate = self;
    [apiClient callApiMethodWithPost:@"auth" arguments:nil/*[NSDictionary dictionaryWithObjectsAndKeys:@"crossover@crossover.com", @"email", @"crossover", @"password", nil]*/];
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Server Post Request Timeout Error: %@", error);
        }
    }];
    [OHHTTPStubs setEnabled:NO];
}

- (void)didCompleteWithResponse:(NSDictionary *)response {
    if (getExpectation) {
        [getExpectation fulfill];
        XCTAssertNotNil(response, @"GET json object returned from server is nil");
    }
    if (postExpectation) {
        [postExpectation fulfill];
        XCTAssertNotNil(response, @"POST json object returned from server is nil");
    }
    
}


@end
