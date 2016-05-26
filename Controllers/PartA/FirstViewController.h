//
//  FirstViewController.h
//  myfirstpods
//
//  Created by john's mac　　　　 on 3/10/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
@interface FirstViewController : UIViewController<UIScrollViewDelegate>

@property (weak,nonatomic) AFURLSessionManager *sessionManager;

- (IBAction)AboutMe:(id)sender;
- (IBAction)serch:(id)sender;

@end
