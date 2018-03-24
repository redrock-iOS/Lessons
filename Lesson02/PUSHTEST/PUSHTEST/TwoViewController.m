//
//  TwoViewController.m
//  PUSHTEST
//
//  Created by hzl on 2018/3/24.
//  Copyright © 2018年 hzl. All rights reserved.
//

#import "TwoViewController.h"
#import "UINavigationController+shouldPopExtension.h"

@interface TwoViewController ()<navigationShouldPop>

@property (nonatomic, strong) UIButton *pushBtn;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:self.pushBtn];
}

- (UIButton *)pushBtn{
    if (!_pushBtn) {
       _pushBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.0 - 150, [UIScreen mainScreen].bounds.size.height/2.0 - 150, 300, 300)];
        [_pushBtn setTitle:@"我在TwoVC上，按我给pop" forState:UIControlStateNormal];
        [_pushBtn setBackgroundColor:[UIColor redColor]];
//        [_pushBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchDown];
        [_pushBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _pushBtn;
}

- (void)test{
    NSLog(@"test");
}

- (BOOL)navigationShouldPop {
   
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    return false;
}


//
//- (void)push{
//    
//}

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
