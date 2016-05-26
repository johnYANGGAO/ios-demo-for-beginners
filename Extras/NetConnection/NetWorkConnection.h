//
//  NetWorkConnection.h
//  myfirstpods
//
//  Created by john's mac　　　　 on 3/11/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#define NETTIMEOUT 20

typedef void(^SuccessBlock)(id responseBody);
typedef void(^ErrorBlock)(NSString *error);

@interface NetWorkConnection : NSObject
+ (NetWorkConnection *)sharedManager;
- (AFHTTPSessionManager *)HttpSessionRequestManager;
- (AFURLSessionManager *)UrlSessionRequestManager;
@end
