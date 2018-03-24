//
//  OneViewController.m
//  PUSHTEST
//
//  Created by hzl on 2018/3/24.
//  Copyright © 2018年 hzl. All rights reserved.
//

#import "OneViewController.h"
#import "TwoViewController.h"

@interface OneViewController ()

@property (nonatomic, strong) UIButton *pushBtn;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.pushBtn];
}

- (UIButton *)pushBtn{
    if (!_pushBtn) {
         _pushBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.0 - 150, [UIScreen mainScreen].bounds.size.height/2.0 - 150, 300, 300)];
        [_pushBtn setTitle:@"我在OneVC上，按我给push" forState:UIControlStateNormal];
        [_pushBtn setBackgroundColor:[UIColor blueColor]];
        [_pushBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchDown];
        [_pushBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _pushBtn;
}

- (void)push{
    TwoViewController *twoVc = [[TwoViewController alloc] init];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:twoVc action:@selector(test)];
    
    [self.navigationController pushViewController:twoVc animated:YES];
}

- (void)test{
    NSLog(@"test");
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
