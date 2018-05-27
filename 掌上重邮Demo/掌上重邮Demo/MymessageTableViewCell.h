//
//  MymessageTableViewCell.h
//  掌上重邮Demo
//
//  Created by 丁磊 on 2018/5/25.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MymessageTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
