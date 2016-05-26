//
//  NetWorkConnection.m
//  myfirstpods
//
//  Created by john's mac　　　　 on 3/11/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "NetWorkConnection.h"
static dispatch_once_t predicate;

@implementation NetWorkConnection

+ (NetWorkConnection *)sharedManager{
    
    static NetWorkConnection *netConnection=nil;
    dispatch_once(&predicate,^{
        netConnection = [[self alloc] init];
    });
    return netConnection;
}
- (AFHTTPSessionManager *)HttpSessionRequestManager{

    return nil;

}
- (AFURLSessionManager *)UrlSessionRequestManager{
    
//    NSString *key = @"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
//    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.forecast.io/forecast/%@/37.8267,-122.423", key]];
    
    // Initialize Session Configuration
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Initialize Session Manager
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
    
    // Configure Manager
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    
    // Send Request
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        // Process Response Object
//    }] resume];


    return manager;

}
@end
