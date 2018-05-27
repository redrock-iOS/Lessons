//
//  MymessageTableViewCell.m
//  掌上重邮Demo
//
//  Created by 丁磊 on 2018/5/25.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import "MymessageTableViewCell.h"

@implementation MymessageTableViewCell

#pragma - /           ******重写initwithstyle方法*******              /
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier: reuseIdentifier])
    {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, width-20, 80)];
        [button3 setImage:[UIImage imageNamed:@"bg_me_item_full"] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:button3];
        
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(30, 10, 50, 50);
        [self.contentView addSubview:button];
        self.button = button;
        UILabel *label1 = [[UILabel alloc]init];
        label1.frame = CGRectMake(90, 15, 200, 50);
        label1.textColor = [UIColor blackColor];
        [self.contentView addSubview: label1];
        self.label1 = label1;
        UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(width-60, 20, 30, 30)];
        [button2 setImage:[UIImage imageNamed:@"ic_me_arrow"] forState:UIControlStateNormal];
        [self.contentView addSubview:button2];
        self.button2 = button2;
    }
    self.backgroundColor = [UIColor clearColor];
    
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *Identifier = @"status";
    MymessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[MymessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    return (MymessageTableViewCell *)cell;
}





- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
