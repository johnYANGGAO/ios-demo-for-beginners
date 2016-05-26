//
//  FirstViewController.m
//  myfirstpods
//
//  Created by john's mac　　　　 on 3/10/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "FirstViewController.h"
#import "LCLineChartView.h"
#import "Globle.h"
#import "NetWorkConnection.h"

@interface FirstViewController (){
    
    
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *TimerChooserSegmented;
@property (weak, nonatomic) IBOutlet UIView *ChartView;
@property (weak, nonatomic) IBOutlet UIView *BrifeView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Indicator;
@property (weak, nonatomic) IBOutlet UIScrollView *BrifeScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *PageIndcator;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initViews];
    [self loadWhenIn];
}

- (void)initViews{
    
    self.Indicator.hidesWhenStopped=YES;
    self.Indicator.color=navigationBarColor;
    [self.TimerChooserSegmented  addTarget:self action:@selector(onTapSegment:)  forControlEvents:UIControlEventValueChanged];
    [self initChart];
    [self initBrife];
    
}
- (void)onTapSegment:(UISegmentedControl *)ctrol{
    
    
    NSInteger index=ctrol.selectedSegmentIndex;
    if (0==index) {
        NSLog(@"hello ,i am today");
    }
    else if (1==index) {
        NSLog(@"hello, i am yestoday");
        
    }
    else {
        NSLog(@"hello , i am  choose date");
        [self showPickDateView];
    }
    
}

- (void)initChart{
    LCLineChartData *d = [LCLineChartData new];
    d.xMin = 1;
    d.xMax = 31;
    d.title = @"当日通话概览";
    d.color = [UIColor brownColor];
    d.itemCount = 25;
    NSMutableArray *vals = [NSMutableArray new];
    for(NSUInteger i = 0; i < d.itemCount; ++i) {
        [vals addObject:@((rand() / (float)RAND_MAX) * (31 - 1) + 1)];
    }
    [vals sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    d.getData = ^(NSUInteger item) {
        float x = [vals[item] floatValue];
        float y = powf(2, x / 7);
        NSString *label1 = [NSString stringWithFormat:@"%lu", item];
        NSString *label2 = [NSString stringWithFormat:@"%f", y];
        return [LCLineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2];
    };    LCLineChartView *chartView = [[LCLineChartView alloc] initWithFrame:CGRectMake(0, 8, self.ChartView.frame.size.width, self.ChartView.frame.size.height)];
    chartView.yMin = 0;
    chartView.yMax = powf(2, 31 / 7) + 0.5;
    chartView.ySteps = @[@"0.0",@"10",@"20",@"30",@"40",@"50",@"60",
                         @"70",@"80",@"90",@"100",@"120",@"140",@"160"
                         ];
    chartView.data = @[d];
    
    [self.view addSubview:chartView];
    [self.ChartView addSubview:chartView];
    //模拟请求 而延迟执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadEnd];
    });
}


- (void)initBrife{
    self.PageIndcator.currentPage=0;
    self.BrifeScrollView.delegate=self;
    self.BrifeScrollView.pagingEnabled = YES;//可以滑动到多少自动回弹
    self.BrifeScrollView.showsHorizontalScrollIndicator=NO;
    
    self.BrifeScrollView.contentSize=CGSizeMake(screen_width*2, self.BrifeView.frame.size.height);
    //scrollview 的第一个页面
    UIView * categoryA= [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.BrifeView.frame.size.width, self.BrifeScrollView.frame.size.height)];
        UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(categoryA.center.x-100,CGRectGetMinY(categoryA.frame)+8, 200, 40)];
    //名称
    name.text=@"Giayia Yong";
    name.textAlignment=NSTextAlignmentCenter;
    name.textColor=navigationBarColor;
    name.font=[UIFont systemFontOfSize:20];
    [categoryA addSubview:name];
    //通话账号余额
    UILabel *callBalance=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(name.frame), screen_width*0.5, 50)];
    //名称
    callBalance.text=@"通话账户余额";
    callBalance.textAlignment=NSTextAlignmentCenter;
    callBalance.textColor=[UIColor brownColor];
    callBalance.font=[UIFont systemFontOfSize:16];
    [categoryA addSubview:callBalance];
    
    //金额
    UILabel *callBalanceLebel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(callBalance.frame)-8, screen_width*0.5, 20)];
    
    callBalanceLebel.text=@"137.50 元";
    callBalanceLebel.textAlignment=NSTextAlignmentCenter;
    callBalanceLebel.textColor=[UIColor lightGrayColor];
    callBalanceLebel.font=[UIFont systemFontOfSize:13];
    [categoryA addSubview:callBalanceLebel];
    //增值账号余额
    UILabel *restBalance=[[UILabel alloc]initWithFrame:CGRectMake(screen_width*0.5,CGRectGetMaxY(name.frame), screen_width*0.5,50)];
    //名称
    restBalance.text=@"增值账户余额";
    restBalance.textAlignment=NSTextAlignmentCenter;
    restBalance.textColor=[UIColor brownColor];
    restBalance.font=[UIFont systemFontOfSize:16];
    [categoryA addSubview:restBalance];
    
    //金额
    UILabel *restBalanceLebel=[[UILabel alloc]initWithFrame:CGRectMake(screen_width*0.5,CGRectGetMaxY(restBalance.frame)-8, screen_width*0.5, 20)];
    restBalanceLebel.text=@"37.50 元";
    restBalanceLebel.textAlignment=NSTextAlignmentCenter;
    restBalanceLebel.textColor=[UIColor lightGrayColor];
    restBalanceLebel.font=[UIFont systemFontOfSize:13];
    [categoryA addSubview:restBalanceLebel];
    
    //名称
    UILabel *billingCycle=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(callBalanceLebel.frame)+8, screen_width*0.5, 50)];
    billingCycle.text=@"计费周期";
    billingCycle.textAlignment=NSTextAlignmentCenter;
    billingCycle.textColor=[UIColor brownColor];
    billingCycle.font=[UIFont systemFontOfSize:16];
    [categoryA addSubview:billingCycle];
    
    //金额
    UILabel *billingCycleLebel=[[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(billingCycle.frame)-8, screen_width*0.5, 20)];
    
    billingCycleLebel.text=@"2016-01-20--2016-02-20";
    billingCycleLebel.textAlignment=NSTextAlignmentCenter;
    billingCycleLebel.textColor=[UIColor lightGrayColor];
    billingCycleLebel.font=[UIFont systemFontOfSize:13];
    [categoryA addSubview:billingCycleLebel];
    //名称
    UILabel *consumption=[[UILabel alloc]initWithFrame:CGRectMake(screen_width*0.5,CGRectGetMaxY(callBalanceLebel.frame)+8, screen_width*0.5, 50)];
    consumption.text=@"本期消费";
    consumption.textAlignment=NSTextAlignmentCenter;
    consumption.textColor=[UIColor brownColor];
    consumption.font=[UIFont systemFontOfSize:16];
    [categoryA addSubview:consumption];
    //金额
    UILabel *consumptionLebel=[[UILabel alloc]initWithFrame:CGRectMake(screen_width*0.5,CGRectGetMaxY(consumption.frame)-8, screen_width*0.5, 20)];
    consumptionLebel.text=@"67.50 元";
    consumptionLebel.textAlignment=NSTextAlignmentCenter;
    consumptionLebel.textColor=[UIColor lightGrayColor];
    consumptionLebel.font=[UIFont systemFontOfSize:13];
    [categoryA addSubview:consumptionLebel];
    
    
    [self.BrifeScrollView addSubview:categoryA];
    
    //scrollview 的第二个页面
    UIView * categoryB= [[UIView alloc] initWithFrame:CGRectMake(screen_width, 0, self.BrifeView.frame.size.width, self.BrifeScrollView.frame.size.height)];
   
    //添加图片
    for (int i = 0; i < 8; i++) {
        
        if (i < 4) {//创建第一页 的 上面5个
            CGRect frame = CGRectMake(i*screen_width/4, 10, screen_width/4, categoryB.frame.size.height*0.2);
            
            UIView *menubackView = [[UIView alloc] initWithFrame:frame];
            menubackView.tag = 16+i;
            [categoryB addSubview:menubackView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapImage:)];
            [menubackView addGestureRecognizer:tap];
            
            CGFloat frameWidth = frame.size.width;
            //                CGFloat frameHeight = frame.size.height;
            //图
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frameWidth/2-20, 20, 40, 40)];
            [imageView setImage:[UIImage imageNamed:@"icon_Category"]];
            [menubackView addSubview:imageView];
            //文字
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), frameWidth, 20)];
            titleLabel.font = [UIFont systemFontOfSize:12];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = @"加载中...";
            [menubackView addSubview:titleLabel];
            
            
            
            
        }else if(i<8){//创建第一页下面4个
            CGRect frame = CGRectMake((i-4)*screen_width/4, 100, screen_width/4, categoryB.frame.size.height*0.2);
            
            UIView *menubackView = [[UIView alloc] initWithFrame:frame];
            menubackView.tag = 20+i;
            [categoryB addSubview:menubackView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
            [menubackView addGestureRecognizer:tap];
            
            CGFloat frameWidth = frame.size.width;
            
            //图
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frameWidth/2-20, 20, 40, 40)];
            [imageView setImage:[UIImage imageNamed:@"icon_Category"]];
            [menubackView addSubview:imageView];
            //文字
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), frameWidth, 20)];
            titleLabel.font = [UIFont systemFontOfSize:12];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = @"稍等中...";
            [menubackView addSubview:titleLabel];
        }
    }
    
    [self.BrifeScrollView addSubview:categoryB];
    
}

/**
 *  第二个scroview页面上面点击事件
 *
 *  @param recognizer <#recognizer description#>
 */
- (void)OnTapImage:(UITapGestureRecognizer *)recognizer{
    
    NSLog(@"点击了 upside %ld",recognizer.view.tag);
    
    
}
/**
 *  第二个scroview页面下面点击事件
 *
 *  @param recognizer <#recognizer description#>
 */
- (void)OnTapBtnView:(UITapGestureRecognizer *)recognizer{
    NSLog(@"点击了 downside %ld",recognizer.view.tag);
    
}
- (void)initScrollContent{
    
    
    
}
- (void)loadEnd{
    
    [self.Indicator stopAnimating];
    self.TimerChooserSegmented.hidden=NO;
    self.ChartView.hidden=NO;
    self.BrifeView.hidden=NO;
    
    
}
- (void)loadWhenIn{
    self.TimerChooserSegmented.hidden=YES;
    self.ChartView.hidden=YES;
    self.BrifeView.hidden=YES;
    [self.Indicator startAnimating];
    /* dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     
     NSURL * url = [NSURL URLWithString:@""];
     
     dispatch_async(dispatch_get_main_queue(), ^{
     [self.Indicator stopAnimating];
     self.Indicator.hidden = YES;
     });
     
     });
     */
    
}

- (void)showPickDateView{
    UIDatePicker *datePicker=[[UIDatePicker alloc]init];
    datePicker.center=self.ChartView.center;
    datePicker.frame=CGRectMake(0, CGRectGetMinY(self.ChartView.frame), screen_width, self.ChartView.frame.size.height);
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.layer.masksToBounds=YES;
    datePicker.layer.cornerRadius=3;
    datePicker.backgroundColor=[UIColor whiteColor];
    datePicker.tag=15;
    //时间改变时输出当前时间，添加事件
    [datePicker addTarget:self
                   action:@selector(datePickDateChanged:)
         forControlEvents:UIControlEventValueChanged];
    
    //sure
    UIButton * sure= [UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame=CGRectMake(screen_width-70,CGRectGetMinY(datePicker.frame)+10, 60, 20);
    sure.backgroundColor=navigationBarColor;
    sure.layer.masksToBounds=YES;
    sure.layer.cornerRadius=4;
    
    sure.titleLabel.font=[UIFont systemFontOfSize:13];
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    [sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sure setTitleColor:[UIColor brownColor] forState:UIControlStateHighlighted];
    [sure addTarget:self action:@selector(OnsureButton:) forControlEvents:UIControlEventTouchUpInside];
    sure.tag=5;
    
    
    //cancel
    UIButton * cancel= [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame=CGRectMake(10,CGRectGetMinY(datePicker.frame)+10, 60, 20);
    cancel.backgroundColor=navigationBarColor;
    cancel.layer.masksToBounds=YES;
    cancel.layer.cornerRadius=4;
    cancel.titleLabel.font=[UIFont systemFontOfSize:13];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor brownColor] forState:UIControlStateHighlighted];
    [cancel addTarget:self action:@selector(OnCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    cancel.tag=10;
    
    
    
    [self.view addSubview:datePicker];
    [self.view addSubview:sure];
    [self.view addSubview:cancel];
    
    
}

- (void)OnCancelButton:(UIButton *) cancel{
    NSLog(@" pick cancel");
    [self removePickerView];
    self.TimerChooserSegmented.selectedSegmentIndex=0;
    
}
- (void)OnsureButton:(UIButton *) sure{
    
    NSLog(@" pick sure");
    
    UIActivityIndicatorView *loading=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(self.ChartView.frame), screen_width, self.ChartView.frame.size.height) ];
    loading.center=self.ChartView.center;
    loading.color=navigationBarColor;
    loading.backgroundColor=[UIColor whiteColor];
    loading.hidesWhenStopped=YES;
    
    [self.view addSubview:loading];
    [loading startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [loading stopAnimating];
        [self removePickerView];
        self.TimerChooserSegmented.selectedSegmentIndex=0;
    });
    
    
}

- (void)removePickerView{
    
    UIButton *sureBtn=[self.view viewWithTag:5];
    UIButton *cancelBtn=[self.view viewWithTag:10];
    UIDatePicker *picker=[self.view viewWithTag:15];
    if (sureBtn) {
        [sureBtn removeFromSuperview];
    }
    if (cancelBtn) {
        [cancelBtn removeFromSuperview];
    }
    if (picker) {
        [picker removeFromSuperview];
    }
}
//datepick 点击
- (void)datePickDateChanged:(UIDatePicker*) sender{
    NSLog(@"ok , you got me %@",sender.date);
    
}

- (IBAction)AboutMe:(id)sender{
    
    NSLog(@"about me ");
   
}

- (IBAction)serch:(id)sender{
    
    NSLog(@"well , we are gonna serch something! ");
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    self.PageIndcator.currentPage = page;
}
//开始拖动时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}
//结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
}

@end
