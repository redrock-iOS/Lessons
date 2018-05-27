//
//  YouAskTableViewCell.m
//  掌上重邮Demo
//
//  Created by 丁磊 on 2018/5/26.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import "YouAskTableViewCell.h"

@implementation YouAskTableViewCell

#pragma - /           ******重写initwithstyle方法*******              /
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier: reuseIdentifier])
    {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, width-10, 170)];
        img.image = [UIImage imageNamed:@"bg_me_item_full"];
        [self.contentView addSubview:img];
        self.img = img;
        UIButton *btn1 = [[UIButton alloc]init];
        btn1.frame = CGRectMake(25, 20, 40, 40);
        btn1.layer.cornerRadius = 2.0;
        [btn1 setUserInteractionEnabled: NO];
        [self.contentView addSubview:btn1];
        self.btn1 = btn1;
        UILabel *label1 = [[UILabel alloc]init];
        label1.frame = CGRectMake(70, 30, 100, 15);
        label1.textColor = [UIColor blackColor];
        [self.contentView addSubview: label1];
        self.label1 = label1;
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 75, width-40, 20)];
        label2.textColor = [UIColor blackColor];
        label2.font = [UIFont systemFontOfSize:25];
        [self.contentView addSubview:label2];
        self.label2 = label2;
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(20, 110, width-140, 10)];
        label3.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:label3];
        self.label3 = label3;
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(width-120, 110, 100, 10)];
        [btn2 setTitle:@"查看详情" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor colorWithRed:0.557 green:0.835 blue:0.984 alpha:1.0] forState:UIControlStateNormal];
        [self.contentView addSubview:btn2];
        self.btn2 = btn2;
        
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *Identifier = @"status";
    YouAskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[YouAskTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    return (YouAskTableViewCell *)cell;
}

#pragma - /           **********设置分割线*********              /
-(UIView *)separatorView
{
    if (_separatorView == nil) {
        UIView *separatorView = [[UIView alloc]init];
        self.separatorView = separatorView;
        separatorView.backgroundColor = [UIColor clearColor];
        [self addSubview:separatorView];
    }
    return _separatorView;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.separatorView.frame = CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1);
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
