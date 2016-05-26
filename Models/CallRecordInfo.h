//
//  CallRecordInfo.h
//  myfirstpods
//
//  Created by john's mac　　　　 on 3/14/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallRecordInfo : NSObject
@property (nonatomic, strong) NSString *callerlabel;
@property (nonatomic, strong) NSString *answerlabel;
@property (nonatomic, strong) NSString *callingTime;
@property (nonatomic, strong) NSString *duration;

@end
