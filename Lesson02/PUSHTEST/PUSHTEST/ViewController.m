//
//  ViewController.m
//  PUSHTEST
//
//  Created by hzl on 2018/3/24.
//  Copyright © 2018年 hzl. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *pushBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:self.pushBtn];
}

- (UIButton *)pushBtn{
    if (!_pushBtn) {
        _pushBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.0 - 150, [UIScreen mainScreen].bounds.size.height/2.0 - 150, 300, 300)];
        [_pushBtn setTitle:@"我在VC上，按我给push" forState:UIControlStateNormal];
        [_pushBtn setBackgroundColor:[UIColor yellowColor]];
        [_pushBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchDown];
        [_pushBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _pushBtn;
}

- (void)push{
    OneViewController *onVc = [[OneViewController alloc] init];
    [self.navigationController pushViewController:onVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
