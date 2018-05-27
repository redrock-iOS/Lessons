//
//  DetailViewController.m
//  掌上重邮Demo
//
//  Created by 丁磊 on 2018/5/26.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailableViewCell.h"

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, strong) NSMutableArray *answers;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    self.tableView.estimatedRowHeight = 150;
//    self.tableView.rowHeight = 200;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)loadData{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *filePath = [bundle pathForResource:@"Messages" ofType:@"plist"];
    
    
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc]initWithContentsOfFile: filePath];
    NSMutableDictionary *dic4 = [dic3 valueForKey:@"data"];
    NSString *stuNum = [dic4 valueForKey:@"stuNum"];
    NSString *idNum = [dic4 valueForKey:@"idNum"];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://wx.idsbllp.cn/springtest/cyxbsMobile/index.php/QA/Question/getDetailedInfo"]];
    
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval:20];
    NSString *str = [NSString stringWithFormat:@"stuNum=%@&idNum=%@&question_id=%@",stuNum,idNum,self.ID];
    [request setHTTPBody:[str dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error = nil;
    NSHTTPURLResponse *urlResponse = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    self.dataDic = [dict valueForKey:@"data"];
    self.answers = [self.dataDic valueForKey:@"answers"];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1 && _answers != nil && ![_answers isKindOfClass:[NSNull class]] && _answers.count != 0) {
        return _answers.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailableViewCell *cell = [DetailableViewCell cellWithTableView:tableView];
    if (indexPath.section == 0) {
        cell.label2.text = [_dataDic valueForKey:@"title"];
        cell.label3.text = [_dataDic valueForKey:@"description"];
        cell.label1.text = [_dataDic valueForKey:@"questioner_nickname"];
        [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
    }
    else{
        cell.label2.text = @" ";
        NSDictionary *dic = [_answers objectAtIndex:indexPath.row];
        cell.label3.text = [dic valueForKey:@"content"];
        cell.label3.frame = CGRectMake(20, 75, [UIScreen mainScreen].bounds.size.width-40, 20);
        cell.label1.text = [dic valueForKey:@"nickname"];
        [cell.btn1 setBackgroundImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
    }
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 150;
    }
    else
        return 100;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
