//
//  SignInViewController.m
//  掌上重邮Demo
//
//  Created by 丁磊 on 2018/5/25.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import "SignInViewController.h"
#import "ViewController.h"
#import "YouAskViewController.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

@interface SignInViewController ()
@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIView *view3;
@property (nonatomic, strong) UITextView *name;
@property (nonatomic, strong) UITextView *code;
@property (nonatomic, strong) UIButton *signInbutton;
@property (nonatomic, strong) NSMutableDictionary *dic;

@end

@implementation SignInViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.image1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, Height/2-70)];
    self.image1.backgroundColor = [UIColor colorWithRed:0.557 green:0.835 blue:0.984 alpha:1.0];
    [self.view addSubview:self.image1];
    self.image2 = [[UIImageView alloc]initWithFrame:CGRectMake(Width/2-75, 100, 150, 150)];
    self.image2.image = [UIImage imageNamed:@"logo"];
    self.image2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.image2];
//    self.view3 = [[UIImageView alloc]initWithFrame:CGRectMake(20, Height/2+100, Width-40, Height/3+70)];
//    self.view3.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:self.view3];
    self.name = [[UITextView alloc]initWithFrame:CGRectMake(40, Height/3+80, Width-80, 60)];
    self.name.editable = YES;
    self.name.text = @"请输入学号";
    self.name.textColor = [UIColor lightGrayColor];
    self.name.font = [UIFont systemFontOfSize:20];
    self.name.textAlignment = NSTextAlignmentLeft;
    self.name.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.name.layer.borderWidth = 1;
    self.name.layer.cornerRadius =5;
    [self.view addSubview:self.name];
    self.code = [[UITextView alloc]initWithFrame:CGRectMake(40, Height/3+160, Width-80, 60)];
    self.code.editable = YES;
    self.code.text = @"请输入身份证后六位";
    self.code.textColor = [UIColor lightGrayColor];
    self.code.font = [UIFont systemFontOfSize:20];
    self.code.textAlignment = NSTextAlignmentLeft;
    self.code.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.code.layer.borderWidth = 1;
    self.code.layer.cornerRadius = 5;
    [self.view addSubview:self.code];
    self.signInbutton = [[UIButton alloc]initWithFrame:CGRectMake(40, Height/3+260, Width-80, 50)];
    self.signInbutton.backgroundColor = [UIColor colorWithRed:0.557 green:0.835 blue:0.984 alpha:1.0];
    [self.signInbutton setTitle:@"登陆" forState:UIControlStateNormal];
//    self.signInbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.signInbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.signInbutton addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.signInbutton];
    
    // Do any additional setup after loading the view. 
}

- (void)didClickButton:(UIButton *)button{
    [self uploadData];
    [self.dic setObject:self.name.text forKey:@"name"];
    [self.dic setObject:self.code.text forKey:@"code"];
    [self.delegate GetUserImformation:self.dic];
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)uploadData{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *filePath1 = [bundle pathForResource:@"Messages" ofType:@"plist"];
    NSString *filePath2 = [bundle pathForResource:@"Schedule" ofType:@"plist"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://wx.idsbllp.cn/api/verify"]];
    
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval:20];
    NSString *str = [NSString stringWithFormat:@"stuNum=%@&idNum=%@",self.name.text,self.code.text];
    [request setHTTPBody:[str dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error = nil;
    NSHTTPURLResponse *urlResponse = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];


    [dict writeToFile: filePath1 atomically:YES];
    
    
    NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://wx.idsbllp.cn/api/kebiao"]];
    
    [request1 setHTTPMethod:@"POST"];
    [request1 setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request1 setTimeoutInterval:20];
    NSString *numStr1 = [NSString stringWithFormat:@"stu_num=%@&forceFetch=true",self.name.text];
    [request1 setHTTPBody:[numStr1 dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error1 = nil;
    NSHTTPURLResponse *urlResponse1 = nil;
    NSData *responseData1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:&urlResponse1 error:&error1];
    NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:responseData1 options:kNilOptions error:nil];
    [dict1 writeToFile: filePath2 atomically:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
