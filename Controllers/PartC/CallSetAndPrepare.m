//
//  CallSetAndPrepare.m
//  myfirstpods
//
//  Created by john's mac　　　　 on 3/15/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "CallSetAndPrepare.h"

@implementation CallSetAndPrepare

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initViews];
    
}

- (void)initViews{
    
    self.done.backgroundColor=[UIColor lightTextColor];
    self.done.layer.masksToBounds=YES;
    self.done.layer.borderWidth=0.5;
    self.done.layer.cornerRadius=5;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 205, 0.6 });//R,G,B,alpha
    self.done.layer.borderColor=colorref;
    [self.done addTarget:self action:@selector(onTapDown:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)onTapDown:(UIButton *) button{
    NSLog(@"the down you clicked");
    [self resignFirstResponder];
    /**
     *  TODO 判断
     */
    [self CallalertShow];
    
}

- (void)CallalertShow{
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"呼叫模式选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *directCall=[UIAlertAction actionWithTitle:@"直拨" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        /**
         *  TODO
         */
        
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *backDial=[UIAlertAction actionWithTitle:@"回拨" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        /**
         *  TODO
         */
        
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:directCall];
    [alertController addAction:backDial];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (IBAction)backAction:(id)sender {
    NSLog(@"ok  ,back button!");
    [self resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
