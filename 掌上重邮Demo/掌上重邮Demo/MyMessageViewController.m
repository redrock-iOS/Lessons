//
//  MyMessageViewController.m
//  掌上重邮Demo
//
//  Created by 丁磊 on 2018/5/25.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MymessageTableViewCell.h"

@interface MyMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *HeaderView;
@property (nonatomic, strong) UIButton *iconButton;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    CGFloat Width = [UIScreen mainScreen].bounds.size.width;
    CGFloat Height = [UIScreen mainScreen].bounds.size.height;
    self.HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, Height/2-70)];
    self.HeaderView.backgroundColor = [UIColor colorWithRed:0.557 green:0.835 blue:0.984 alpha:1.0];
    self.iconButton = [[UIButton alloc]initWithFrame:CGRectMake(Width/2-35, 140, 70, 70)];
    self.iconButton.layer.cornerRadius = 2.0;
    [self.iconButton setImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
    [self.iconButton addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.HeaderView addSubview:self.iconButton];
    [self.view addSubview:self.HeaderView];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height/2-70, Width, Height/2+70) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)loadData{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *filePath = [bundle pathForResource:@"MyMessage" ofType:@"plist"];
  
    self.dataArray = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = [self.dataArray objectAtIndex:section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MymessageTableViewCell *cell = [MymessageTableViewCell cellWithTableView:tableView];
    cell.backgroundColor = [UIColor clearColor];
    NSArray *arr1 = [self.dataArray objectAtIndex: indexPath.section];
    NSDictionary *dic = [arr1 objectAtIndex: indexPath.row];
    NSString *str1 = [dic valueForKey:@"title"];
    NSString *str2 = [dic valueForKey:@"image"];
    cell.label1.text = str1;
    [cell.button setImage:[UIImage imageNamed:str2] forState:UIControlStateNormal];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
