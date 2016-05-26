//
//  SecondViewController.h
//  myfirstpods
//
//  Created by john's mac　　　　 on 3/10/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *CallAction;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SegmentedRecord;
@property (weak, nonatomic) IBOutlet UITableView *RecordTableView;


@end
