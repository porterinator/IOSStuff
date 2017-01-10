//
//  JitenshaApiClient.m
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "JitenshaApiClient.h"


@interface JitenshaApiClient ()

@property(strong, nonatomic) NSString *baseUrl;

@end

@implementation JitenshaApiClient


- (instancetype)init {
    self = [super init];
    if (self) {
        self.baseUrl = @"http://192.168.18.1:8080/api/v1/%@";
    }
    return self;
}

-(void)callApiMethodWithPost:(NSString *)method arguments:(NSDictionary *)arguments {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *authToken = [SAMKeychain passwordForService:@"JitenshaService" account:@"Jitensha"];
    if (authToken)
        [manager.requestSerializer setValue:authToken forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSString *argString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return argString;
    }];
    
    [manager POST:[NSString stringWithFormat:self.baseUrl, method] parameters:arguments progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_delegate didCompleteWithResponse:(NSDictionary *)responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_delegate didFailWithError:error];
    }];
}

-(void) callApiMethodWithGet:(NSString *)method arguments:(NSDictionary *)arguments {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *authToken = [SAMKeychain passwordForService:@"JitenshaService" account:@"Jitensha"];
    [manager.requestSerializer setValue:authToken forHTTPHeaderField:@"Authorization"];
    [manager GET:[NSString stringWithFormat:self.baseUrl, method] parameters:arguments progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_delegate didCompleteWithResponse:(NSDictionary *)responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_delegate didFailWithError:error];
    }];
}

@end
