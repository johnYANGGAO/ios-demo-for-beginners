//
//  SecondViewController.m
//  myfirstpods
//
//  Created by john's mac　　　　 on 3/10/16.
//  Copyright © 2016 john's mac　　　　. All rights reserved.
//

#import "SecondViewController.h"
#import "CallingCell.h"
#import "MJRefresh.h"
#import "Globle.h"
@interface SecondViewController (){
    
    NSMutableArray *_callingDataSource;
    NSMutableArray *_answerDataSource;
    NSInteger _type;
    NSInteger _page;
}

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self netWork];
    [self initViews];
}


- (void)initViews{
    _callingDataSource=[NSMutableArray array];
    _answerDataSource=[NSMutableArray array];
    _type=0;
    _page=1;
    [self.SegmentedRecord addTarget:self action:@selector(OnTapSegmented:) forControlEvents:UIControlEventValueChanged];
    
    //    UITapGestureRecognizer *recongnizer= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapCall:)];
    /**
     *  no enabled  no feedback from gesture you can also set it on storyboard
     self.CallAction.userInteractionEnabled=YES;
     */
    
    [self.CallAction  setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
//    [self.CallAction addTarget:self action:@selector(OnTapCall:) forControlEvents:UIControlEventTouchUpInside];
    
    [self initTabView];
    
}

- (void)initTabView{
    self.RecordTableView.delegate=self;
    self.RecordTableView.dataSource=self;
    [self getHeader];
    [self getFooter];
    
}

- (void)getHeader{
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadfreshdata)];
    
    //设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    
    UIImage *image = [UIImage imageNamed:@"icon_refresh_1"];
    [idleImages addObject:image];
    
    [header setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *pullingImages = [NSMutableArray array];
    /**
     *  it will get nil if no name of image macthed .
     */
    UIImage *image1 = [UIImage imageNamed:@"icon_refresh_2"];
    [pullingImages addObject:image1];
    UIImage *image2 = [UIImage imageNamed:@"icon_refresh_3"];
    [pullingImages addObject:image2];
    
    [header setImages:pullingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:pullingImages forState:MJRefreshStateRefreshing];
    // 设置header
    self.RecordTableView.mj_header = header;
    
}

- (void)getFooter{
    
    MJRefreshAutoNormalFooter *footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"请稍后..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据啦 " forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:13];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    
    self.RecordTableView.mj_footer=footer;
    
}
/**
 *  下拉刷新
 */
- (void)loadfreshdata{
    NSLog(@"start freshing from  beging");
    [self netWork];
    
}

/**
 *  上拉加载更多
 */
- (void)loadMoreData{
    _page++;
    NSLog(@"start freshing from end");
    
}

-(void)netWork{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        /**
         *  网络请求工作 TODO
         */
        for (int i=0; i<30; i++) {
            CallRecordInfo *info=[[CallRecordInfo alloc]init];
            info.callerlabel=@"13124335678";
            info.answerlabel=@"12345678999";
            info.duration=@"16s";
            info.callingTime=@"2016-03-16 \n 09:41";
            [_answerDataSource addObject:info];
            [_callingDataSource addObject:info];
        }
        [self.RecordTableView reloadData];
        
        //        [self finishedFreshing];
        
    });
    
}

- (void)finishedFreshing{
    if ([self.RecordTableView.mj_header isRefreshing]) {
        [self.RecordTableView.mj_header endRefreshing];
    }
    if ([self.RecordTableView.mj_footer isRefreshing]) {
        [self.RecordTableView.mj_footer endRefreshing];
    }
}

//- (void)OnTapCall:(UITapGestureRecognizer *)gesture{
//    //    UIView *view=gesture.view;
//    NSLog(@"here you are , i am going to prepare call ");
//    
//    
//}


- (void)OnTapSegmented:(UISegmentedControl *)segmented{
    
    [self finishedFreshing];
    NSInteger index=segmented.selectedSegmentIndex;
    if (0==index) {
        _page=1;
        _type=0;
        NSLog(@"No.1  click the %ld",index);
    }else if(1==index){
        _page=1;
        _type=1;
        NSLog(@"No.2  click the %ld",index);
    }
    [self.RecordTableView reloadData];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"callingCell";
    CallingCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    CallRecordInfo *info=nil;
    if (0==_type) {
        if (_callingDataSource.count>0) {
            NSLog(@"_callingDataSource.count>0");
            info=_callingDataSource[indexPath.row];
        }
    }else{
        if (_answerDataSource.count>0) {
            NSLog(@"_answerDataSource.count>0");
            info=_answerDataSource[indexPath.row];
        }
    }
    [cell setLabel:info];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 64;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0==_type) {
        return _callingDataSource.count;
        
    }else if(1==_type){
        return _answerDataSource.count;
    }
    return 0;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 40)];
    headerView.backgroundColor=navigationBarColor;
    
    UILabel *caller = [[UILabel alloc] initWithFrame:CGRectMake(0,0, screen_width/4,headerView.frame.size.height)];
    caller.textAlignment = NSTextAlignmentCenter;
    caller.textColor = [UIColor whiteColor];
    caller.font = [UIFont systemFontOfSize:15];
    caller.text = @"主叫";
    
    [headerView addSubview:caller];
    
    
    UILabel *answer = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(caller.frame)+10,0, screen_width/4,headerView.frame.size.height)];
    answer.textAlignment = NSTextAlignmentCenter;
    answer.textColor = [UIColor whiteColor];
    answer.font = [UIFont systemFontOfSize:15];
    answer.text = @"被叫";
    
    [headerView addSubview:answer];
    
    UILabel *recordTime = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(answer.frame)+10,0, screen_width/4,headerView.frame.size.height)];
    recordTime.textAlignment = NSTextAlignmentCenter;
    recordTime.textColor = [UIColor whiteColor];
    recordTime.font = [UIFont systemFontOfSize:15];
    recordTime.text = @"拨号时间";
    
    [headerView addSubview:recordTime];
    
    UILabel *duration = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(recordTime.frame)+3,0, screen_width/5,headerView.frame.size.height)];
    duration.textAlignment = NSTextAlignmentCenter;
    duration.textColor = [UIColor whiteColor];
    duration.font = [UIFont systemFontOfSize:15];
    duration.text = @"时长";
    
    [headerView addSubview:duration];
    
    return headerView;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"you clicked the NO. %ld",indexPath.row);
    if (0==_type) {
        
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"info" message:@"商家 : Alibaba \n 客户 : Tencent" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"阅览完毕" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }else if(1==_type){
        
        
        
    }
    
    
}


/**
 *  实现滑动按钮
 */

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *likeAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"呼叫" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self CallalertShow];
        tableView.editing = NO;
        
    }];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        if (0==_type) {
            [_callingDataSource removeObjectAtIndex:indexPath.row];
        }else if(1==_type){
            [_answerDataSource removeObjectAtIndex:indexPath.row];
        }
        
        // refresh
        [self.RecordTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        // 不需要主动退出编辑模式，上面更新view的操作完成后就会自动退出编辑模式
    }];
    
    return @[deleteAction, likeAction];
    
    
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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
