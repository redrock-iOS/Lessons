//
//  DetailableViewCell.h
//  掌上重邮Demo
//
//  Created by 丁磊 on 2018/5/27.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailableViewCell : UITableViewCell


@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) NSString *str1;
@property (nonatomic, strong) NSString *str2;

@property (nonatomic, weak) UIView *separatorView;


+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
