//
//  CallingCell.h
//  myfirstpods
//
//  Created by john's mac　　　　 on 3/14/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallRecordInfo.h"
@interface CallingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *callerLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UILabel *callingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (nonatomic,strong) CallRecordInfo *callInfo;


- (void)setLabel:(CallRecordInfo *) info;
@end
