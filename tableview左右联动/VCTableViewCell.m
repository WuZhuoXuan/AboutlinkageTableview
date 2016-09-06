//
//  VCTableViewCell.m
//  tableview左右联动
//
//  Created by DHSoft on 16/9/6.
//  Copyright © 2016年 DHSoft. All rights reserved.
//

#import "VCTableViewCell.h"



@implementation VCTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.contentView.frame.size.width-150, 20)];
        self.shopBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.titleLabel.frame.size.width+20,10, 40, 30)];
        self.shopBtn.backgroundColor = [UIColor redColor];
        [self.shopBtn addTarget:self action:@selector(shopClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.shopBtn];
        
    }
    return self;
}


- (void)shopClick:(UIButton *)sender{

    if(self.block)
    {
         self.block(self);
    }
   
}
@end
