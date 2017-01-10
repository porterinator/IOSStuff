//
//  JitenshaApiIntegrationTests.m
//  Jitensha
//
//  Created by Admin on 11/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JitenshaServiceImpl.h"
#import "JitenshaPlace.h"

@interface JitenshaApiIntegrationTests : XCTestCase
{
    XCTestExpectation *loginExpectation;
    XCTestExpectation *registerExpectation;
    XCTestExpectation *placesExpectation;
    XCTestExpectation *rentExpectation;
    JitenshaServiceImpl *jitenshaServiceImpl;
}


@end

@implementation JitenshaApiIntegrationTests

- (void)setUp {
    [super setUp];
    jitenshaServiceImpl = [[JitenshaServiceImpl alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testLoginFormat {
    loginExpectation = [self expectationWithDescription:@"login"];
    RACCommand *loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[jitenshaServiceImpl jitenshaLoginSignal:@"crossover@crossover.com" password:@"crossover"] doNext:^(NSDictionary *response) {
            XCTAssertNotNil([response valueForKey:@"accessToken"], @"API format error no accessToken in response");
            [loginExpectation fulfill];
        }] ;
    }];
    [loginCommand execute:nil];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Server Get Request Timeout Error: %@", error);
        }
    }];
}

-(void) testRegisterFormat {
    registerExpectation = [self expectationWithDescription:@"register"];
    RACCommand *registerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[jitenshaServiceImpl jitenshaRegisterSignal:@"crossover1@crossover.com" password:@"crossover1"] doNext:^(NSDictionary *response) {
            XCTAssertNotNil([response valueForKey:@"accessToken"], @"API format error no accessToken in response");
            [registerExpectation fulfill];
        }] ;
    }];

    [registerCommand execute:nil];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Server Get Request Timeout Error: %@", error);
        }
    }];
}

-(void) testPlacesFormat {
    [self testLoginFormat];
    placesExpectation = [self expectationWithDescription:@"places"];
    RACCommand *placesCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[jitenshaServiceImpl jitenshaGetPlacesSignal] doNext:^(NSArray *places) {
            for (int i = 0; i < [places count]; i++) {
                JitenshaPlace *place = places[i];
                XCTAssertNotEqual(place.lat, 0.0, @"API format error no lat attribute for place object");
                XCTAssertNotEqual(place.lng, 0.0, @"API format error no lng attribute for place object");
                XCTAssertNotNil(place.name, @"API format error no name attribute for place object");
                XCTAssertNotNil(place.id, @"API format error no name attribute for place object");
            }
            
            [placesExpectation fulfill];
        }] ;
    }];
    
    [placesCommand execute:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Server Get Request Timeout Error: %@", error);
        }
    }];
}

-(void) testRentFormat {
    [self testLoginFormat];
    rentExpectation = [self expectationWithDescription:@"rent"];
    RACCommand *rentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[jitenshaServiceImpl jitenshaRentSignal:@"5256892142166008" name:@"NAME SURNAME" expiration:@"01/16" code:@"555"] doNext:^(NSString *message) {
            XCTAssertNotNil(message, @"API format error no message in response for rent");
            [rentExpectation fulfill];
        }] ;
    }];
    
    [rentCommand execute:nil];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Server Get Request Timeout Error: %@", error);
        }
    }];
}


@end
