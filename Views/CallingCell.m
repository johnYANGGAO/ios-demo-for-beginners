//
//  CallingCell.m
//  myfirstpods
//
//  Created by john's mac　　　　 on 3/14/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "CallingCell.h"

@implementation CallingCell


#pragma mark SUPER
- (void)awakeFromNib{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setLabel:(CallRecordInfo *) info{
    NSLog(@"set info %@ and %@",info.duration,info.callerlabel);
    self.callInfo=info;
    self.durationLabel.text=info.duration;
    self.callerLabel.text=info.callerlabel;
    self.answerLabel.text=info.answerlabel;
    self.callingTimeLabel.text=info.callingTime;
}
@end
