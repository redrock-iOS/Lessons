//
//  discoverViewController.m
//  掌上重邮Demo
//
//  Created by 丁磊 on 2018/5/25.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import "discoverViewController.h"

@interface discoverViewController ()
@property (nonatomic, strong) NSArray *array;

@end

@implementation discoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadArray];
    CGFloat Width = [UIScreen mainScreen].bounds.size.width;
    CGFloat Height = [UIScreen mainScreen].bounds.size.height;
    int n = 1;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(Width/3-70+100*j, Height/2-50+(105*i), 80, 80)];
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i",n]] forState:UIControlStateNormal];
            btn.layer.cornerRadius = 2.0;
            [self.view addSubview:btn];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(Width/3-70+100*j, Height/2+32+(105*i), 80, 15)];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [_array objectAtIndex:n-1];
            label.textColor = [UIColor lightGrayColor];
            label.backgroundColor = [UIColor clearColor];
            [self.view addSubview:label];
            n++;
        }
    }
    // Do any additional setup after loading the view.
}

- (void)loadArray{
    self.array = [[NSArray alloc] init];
    self.array = @[@"没课约",@"空教室",@"成绩单",@"志愿时长",@"重邮地图",@"课前提醒",@"校历",@"查电费",@"关于红岩"];
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
