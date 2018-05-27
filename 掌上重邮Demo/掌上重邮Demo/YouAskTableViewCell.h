//
//  YouAskTableViewCell.h
//  掌上重邮Demo
//
//  Created by 丁磊 on 2018/5/26.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YouAskTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, weak) UIView *separatorView;


+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
