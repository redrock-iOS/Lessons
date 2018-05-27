//
//  ViewController.m
//  掌上重邮Demo
//
//  Created by 丁磊 on 2018/5/25.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import "ViewController.h"
#import "SignInViewController.h"


#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#define buttonWidth (Width - 20) / 7
#define buttonHeight (Height - 150) / 6

int schedule[7][6];




@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, retain) UIButton *btn;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, strong) NSString *numStr;
@property (nonatomic, strong) NSMutableArray *ScheduleArray;
@property (nonatomic, strong) NSMutableArray *All_inArray;
@property (nonatomic, strong) NSMutableArray *weekSchedule;
@property (nonatomic, strong) UIPickerView *picker;
@property (assign, nonatomic,getter=isHidden)  BOOL hidden;
@property (nonatomic, strong) UIButton *button;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *filePath1 = [bundle pathForResource:@"Messages" ofType:@"plist"];
    NSString *filePath = [bundle pathForResource:@"Schedule" ofType:@"plist"];
    self.dic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    self.title = @"课表";
    self.dataArray = [[NSMutableArray alloc]init];
    if ([self.dic count]) {
        self.nowWeek = [self.dic valueForKey:@"nowWeek"];
        self.dataArray = [self.dic valueForKey:@"data"];
    }
    else
        self.dataArray = [@[] mutableCopy];

    self.weekSchedule = [[NSMutableArray alloc]init];
    
    self.navigationController.navigationBarHidden = YES;
    self.hidden = NO;
    self.picker = [[UIPickerView alloc]init];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    self.picker.backgroundColor = [UIColor colorWithHue:0.0000 saturation:0.0000 brightness:0.8706 alpha:1.0];
    
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(Width/2-50, 20, 100, 45)];
    [self.button setTitle:[NSString stringWithFormat:@"第%@周",_nowWeek] forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.button.backgroundColor = [UIColor clearColor];
    [self.button addTarget:self action:@selector(tabHiddenOrShow) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 65)];
    View.backgroundColor = [UIColor colorWithRed:0.557 green:0.835 blue:0.984 alpha:1.0];
    [self.view addSubview:View];
    [self.view addSubview:self.button];
    
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 65, Width, Height-65);
    for (int i = 0; i < 7; i++) {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20 + buttonWidth*i, 65, buttonWidth, 40)];
        label1.text = [NSString stringWithFormat:@"周%i",i+1];
        label1.textColor = [UIColor colorWithRed:0.557 green:0.835 blue:0.984 alpha:1.0];
        label1.font = [UIFont systemFontOfSize:13];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.backgroundColor = [UIColor colorWithHue:0.5694 saturation:0.0478 brightness:0.9843 alpha:1.0];
        [self.view addSubview:label1];
    }
    for (int i = 0; i < 12; i++) {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 105+buttonHeight/2*i, 20, buttonHeight/2)];
        label1.text = [NSString stringWithFormat:@"%i",i+1];
        label1.textColor = [UIColor colorWithRed:0.557 green:0.835 blue:0.984 alpha:1.0];
        label1.font = [UIFont systemFontOfSize:13];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.backgroundColor = [UIColor colorWithHue:0.5694 saturation:0.0478 brightness:0.9843 alpha:1.0];
        [self.view addSubview:label1];
    }
    
    if (_dataArray != nil && ![_dataArray isKindOfClass:[NSNull class]] && _dataArray.count != 0) {
        self.img.hidden = YES;
        self.btn.hidden = YES;
        [self loadData:self.nowWeek];
        [self loadMyScrollView:schedule];
    }
    else{
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(Width/2-100, 150, 200, 200)];
        self.img.image = [UIImage imageNamed:@"no_course"];
        self.img.backgroundColor = [UIColor clearColor];
        [self.scrollView addSubview: self.img];
        self.btn = [[UIButton alloc]initWithFrame:CGRectMake(Width/2-75, 450, 150, 20)];
        [self.btn setTitle:@"登陆查看课表" forState:UIControlStateNormal];
        [self.btn setTitleColor:[UIColor colorWithRed:0.557 green:0.835 blue:0.984 alpha:1.0]  forState:UIControlStateNormal];
        self.btn.backgroundColor = [UIColor whiteColor];
        [self.btn addTarget:self action:@selector(didClickButton1:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:self.btn];
    }
    [self.view addSubview: self.scrollView];
    
    
}

- (void)loadScheduleArray{
    self.ScheduleArray = [[NSMutableArray alloc] init];
    self.ScheduleArray = [@[] mutableCopy];
    self.All_inArray = [[NSMutableArray alloc] init];
    self.All_inArray = [@[] mutableCopy];
    int Schel[7][6];

    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
    NSMutableArray *arr2 = [[NSMutableArray alloc]init];
    NSMutableArray *arr3 = [[NSMutableArray alloc]init];
    for (int i = 0; i < 20; i++) {
        arr1 = [@[] mutableCopy];
        for (int n = 0; n < 7; n++) {
            for (int j = 0; j < 6; j++) {
                Schel[n][j] = 0;
            }
        }
        arr3 = [@[] mutableCopy];
        for (NSDictionary *dict in _dataArray) {
            NSMutableArray *array = [dict valueForKey:@"week"];
            for (NSNumber  *num in array) {
                int a = [num intValue];
                if (a == i+1) {
                    [arr3 addObject:dict];
                    break;
                }
            }
        }
        
        for (int n = 0; n < arr3.count; n++) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            dict = [arr3 objectAtIndex:i];
            NSNumber *day = [dict valueForKey:@"hash_day"];
            NSNumber *class = [dict valueForKey:@"hash_lesson"];
            int a = [day intValue];
            int b = [class intValue];
            
            Schel[a][b] = 1;
        }
        for (int n = 0; n < 7; n++) {
            for (int j = 0; j < 6; j++) {
                if (Schel[n][j] != 1) {
                    Schel[n][j] = 0;
                    continue;
                }
            }
        }
        for (int n = 0; n < 7; n++) {
            arr1 = [@[] mutableCopy];
            for (int j = 0; j < 6; j++) {
                NSNumber *num = [NSNumber numberWithInt:schedule[n][j]];
                [arr1 addObject:num];
            }
            [arr2 addObject:arr1];
        }
        [self.All_inArray addObject:arr3];
        [self.ScheduleArray addObject:arr2];
    }
}

- (void)loadMyScrollView:(int *)data{
    long int n = 0;
    for (int i = 0; i < 7; i++) {
        for (int j = 0; j < 6; j++) {
            if (*(data ++) == 1) {
                
                if (n != 0) {
                    NSDictionary *dict = [[NSDictionary alloc]init];
                    dict = [_weekSchedule objectAtIndex:n];
                    NSDictionary *dict1 =[[NSDictionary alloc]init];
                    dict1 = [_weekSchedule objectAtIndex:n-1];
                    NSString *courseNum1 = [dict valueForKey:@"course_num"];
                    NSString *courseNum2 = [dict1 valueForKey:@"course_num"];
                    
                    const char *a = [courseNum1 UTF8String];
                    const char *b = [courseNum2 UTF8String];
                    int c = strcmp(a, b);
                    while (c == 0)
                    {
                        n++;
                        NSDictionary *dict = [[NSDictionary alloc]init];
                        dict = [_weekSchedule objectAtIndex:n];
                        NSDictionary *dict1 =[[NSDictionary alloc]init];
                        dict1 = [_weekSchedule objectAtIndex:n-1];
                        NSString *courseNum1 = [dict valueForKey:@"course_num"];
                        NSString *courseNum2 = [dict1 valueForKey:@"course_num"];
                        
                        const char *a = [courseNum1 UTF8String];
                        const char *b = [courseNum2 UTF8String];
                        c = strcmp(a, b);
                    }
                    dict = [_weekSchedule objectAtIndex:n];
                    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(22 + buttonWidth*i, 105 + buttonHeight*j, buttonWidth - 4, buttonHeight - 2)];
                    if (j < 2)
                        View.backgroundColor = [UIColor colorWithHue:0.9658 saturation:0.3436 brightness:0.8902 alpha:1.0];
                    else if (j < 4)
                        View.backgroundColor = [UIColor colorWithHue:0.0884 saturation:0.4118 brightness:0.9333 alpha:1.0];
                    else
                        View.backgroundColor = [UIColor colorWithHue:0.6054 saturation:0.4033 brightness:0.9529 alpha:1.0];
                    
                    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, buttonWidth - 4, buttonHeight-25)];
                    label1.text = [dict valueForKey:@"course"];
                    label1.numberOfLines = 3;
                    label1.textColor = [UIColor whiteColor];
                    label1.font = [UIFont systemFontOfSize:13];
                    label1.textAlignment = NSTextAlignmentCenter;
                    label1.backgroundColor = [UIColor clearColor];
                    [View addSubview:label1];
                    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(2, buttonHeight-20, buttonWidth-4, 20)];
                    
                    label2.text = [dict valueForKey:@"classroom"];
                    label2.textAlignment = NSTextAlignmentCenter;
                    label2.textColor = [UIColor whiteColor];
                    label2.font = [UIFont systemFontOfSize:13];
                    label2.backgroundColor = [UIColor clearColor];
                    [View addSubview:label2];
                    [self.view addSubview:View];
                    n++;
                    continue;
                }
                else{
                    NSDictionary *dict = [[NSDictionary alloc]init];
                    dict = [_weekSchedule objectAtIndex:n];
                    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(22 + buttonWidth*i, 105 + buttonHeight*j, buttonWidth - 4, buttonHeight - 2)];
                    if (j < 2)
                        View.backgroundColor = [UIColor colorWithHue:0.9658 saturation:0.3436 brightness:0.8902 alpha:1.0];
                    else if (j < 4)
                        View.backgroundColor = [UIColor colorWithHue:0.0884 saturation:0.4118 brightness:0.9333 alpha:1.0];
                    else
                        View.backgroundColor = [UIColor colorWithHue:0.6054 saturation:0.4033 brightness:0.9529 alpha:1.0];
                    
                    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, buttonWidth - 4, buttonHeight-25)];
                    label1.text = [dict valueForKey:@"course"];
                    label1.numberOfLines = 3;
                    label1.textColor = [UIColor whiteColor];
                    label1.font = [UIFont systemFontOfSize:13];
                    label1.textAlignment = NSTextAlignmentCenter;
                    label1.backgroundColor = [UIColor clearColor];
                    [View addSubview:label1];
                    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(2, buttonHeight-20, buttonWidth-4, 20)];
                    
                    label2.text = [dict valueForKey:@"classroom"];
                    label2.textAlignment = NSTextAlignmentCenter;
                    label2.textColor = [UIColor whiteColor];
                    label2.font = [UIFont systemFontOfSize:13];
                    label2.backgroundColor = [UIColor clearColor];
                    [View addSubview:label2];
                    [self.view addSubview:View];
                    n++;
                    continue;
                }
              
            }
        }
    }

}


- (void)didClickButton1:(UIButton *)button{
    SignInViewController *vc = [[SignInViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)loadData:(NSNumber *)week{
  
    self.weekSchedule = [@[] mutableCopy];
    for (NSDictionary *dict in _dataArray) {
        NSMutableArray *array = [dict valueForKey:@"week"];
        for (NSNumber  *num in array) {
            int a = [num intValue];
            int b = [week intValue];
            if (a == b) {
                [self.weekSchedule addObject:dict];
                break;
            }
        }
    }
    
    for (int i = 0; i < self.weekSchedule.count; i++) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict = [_weekSchedule objectAtIndex:i];
        NSNumber *day = [dict valueForKey:@"hash_day"];
        NSNumber *class = [dict valueForKey:@"hash_lesson"];
        int a = [day intValue];
        int b = [class intValue];
        
        schedule[a][b] = 1;
    }
    for (int i = 0; i < 7; i++) {
        for (int j = 0; j < 6; j++) {
            if (schedule[i][j] != 1) {
                schedule[i][j] = 0;
                continue;
            }
        }
    }
    
}

- (void)EmptyData{

    for (int i = 0; i < 7; i++) {
        for (int j = 0; j < 6; j++) {
            schedule[i][j] = 0;
        }
    }
}


-(void)tabHiddenOrShow
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];

    
    if (self.hidden == NO) {
//        self.view.frame = CGRectMake(0, -300, Width, Height);
        self.picker.frame = CGRectMake(0, Height-300, Width, 300);
        [self.view addSubview:self.picker];
        [UIView commitAnimations];
        self.hidden = YES;
    }
    else{
//        self.view.frame = CGRectMake(0, 0, Width, Height);
        self.picker.frame = CGRectMake(0, 300+Height, Width, 300);
        [self.view addSubview:self.picker];
        [UIView commitAnimations];
        self.hidden = NO;
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 20;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"第%li周",row+1];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.hidden = YES;
    [self EmptyData];
    [self loadData:[NSNumber numberWithInteger:row]];
    [self loadMyScrollView:schedule];
    [self.button setTitle: [NSString stringWithFormat:@"第%li周", row+1] forState:UIControlStateNormal];
    [self tabHiddenOrShow];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
