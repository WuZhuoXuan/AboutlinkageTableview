//
//  VCTableViewCell.h
//  tableview左右联动
//
//  Created by DHSoft on 16/9/6.
//  Copyright © 2016年 DHSoft. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ShopBlock)(UITableViewCell *shop);


@interface VCTableViewCell : UITableViewCell


@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UIButton *shopBtn;

@property (nonatomic,copy)ShopBlock block;

@end
