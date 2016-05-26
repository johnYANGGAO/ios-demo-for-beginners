//
//  CallSetAndPrepare.h
//  myfirstpods
//
//  Created by john's mac　　　　 on 3/15/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallSetAndPrepare : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *callNumber;
@property (weak, nonatomic) IBOutlet UITextField *answerNumber;
@property (weak, nonatomic) IBOutlet UIButton *done;

- (IBAction)backAction:(id)sender;
@end
