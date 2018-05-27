//
//  DetailableViewCell.m
//  掌上重邮Demo
//
//  Created by 丁磊 on 2018/5/27.
//  Copyright © 2018年 丁磊. All rights reserved.
//

#import "DetailableViewCell.h"

@implementation DetailableViewCell

#pragma - /           ******重写initwithstyle方法*******              /
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier: reuseIdentifier])
    {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        
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
        label2.font = [UIFont systemFontOfSize:20];
        label2.numberOfLines = 0;
//    CGSize size1 = [_str1 sizeWithFont:label2.font constrainedToSize:CGSizeMake(label2.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//        label2.text = _str1;
//        label2.frame = CGRectMake(20, 75, width-40, size1.height);
        [self.contentView addSubview:label2];
        self.label2 = label2;
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, width-140, 10)];
        label3.numberOfLines = 0;
        label3.textColor = [UIColor darkGrayColor];
//    CGSize size2 = [_str2 sizeWithFont:label3.font constrainedToSize:CGSizeMake(label3.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
  
//        [label3 setText:_str2];
//        label3.frame = CGRectMake(20, 90+size1.height, width-40, size2.height);
        [self.contentView addSubview:label3];
        self.label3 = label3;
        
        
    }
    self.backgroundColor = [UIColor whiteColor];
    return self;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *Identifier = @"status";
    DetailableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[DetailableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    return (DetailableViewCell *)cell;
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
