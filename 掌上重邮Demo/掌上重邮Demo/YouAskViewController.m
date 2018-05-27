//
//  YouAskViewController.m
//  掌上重邮Demo
//
//  Created by 丁磊 on 2018/5/26.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import "YouAskViewController.h"
#import "YouAskTableViewCell.h"
#import "MymessageTableViewCell.h"
#import "DetailViewController.h"
//#import "SignInViewController.h"

@interface YouAskViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
//@property (nonatomic, strong) NSMutableDictionary *dic;

@end

@implementation YouAskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [[NSMutableArray alloc]init];
    self.dataArray = [@[] mutableCopy];
    [self loadData];
    
//    SignInViewController *data = [[SignInViewController alloc]init];
//    data.delegate = self;
//
    
    CGFloat Width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 150;
    
    [self.view addSubview:self.tableView];
    
}




- (void)loadData{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *filePath = [bundle pathForResource:@"Questions" ofType:@"plist"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/Question/getQuestionList"]];
    
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval:20];
    NSString *str = @"kind=学习";
    [request setHTTPBody:[str dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error = nil;
    NSHTTPURLResponse *urlResponse = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    [dict writeToFile: filePath atomically:YES];
    
   self.dataArray = [dict valueForKey:@"data"];

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YouAskTableViewCell *cell = [YouAskTableViewCell cellWithTableView:tableView];
    cell.backgroundColor = [UIColor clearColor];
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
    dic1 = [self.dataArray objectAtIndex: indexPath.row];
    [cell.btn1 setImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
    cell.label1.text = [dic1 valueForKey:@"nickname"];
    cell.label2.text = [dic1 valueForKey:@"title"];
    cell.label3.text = [dic1 valueForKey:@"description"];

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *vc = [[DetailViewController alloc] init];
    NSDictionary *diction =  [self.dataArray objectAtIndex:indexPath.row];
    [vc setID:[diction valueForKey:@"id"]];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
