//
//  ViewController.m
//  tableview左右联动
//
//  Created by DHSoft on 16/8/24.
//  Copyright © 2016年 DHSoft. All rights reserved.
//

#import "ViewController.h"
#import "VCTableViewCell.h"
#import "ArticleParabola.h"

#define kAPPH [[UIScreen mainScreen] bounds].size.height
#define kAPPW [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *leftTableView;

@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, strong) UIImageView   *redView;   //抛物线

@property (nonatomic, strong) UIButton *shopBtn; // 购物车

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    [self.view addSubview:self.shopBtn];
    [ArticleParabola shared].ArticleBlock = ^{
    
        [self.redView removeFromSuperview];
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _leftTableView)
    {
        return 40;
    }else
    {
        return 8;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == self.leftTableView)
    {
        return 1;
    }else
    {
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(tableView == self.leftTableView)
    {
        UITableViewCell *cell;
        cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"leftTableView" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
       
    }else
    {
        VCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VCTableViewCell" forIndexPath:indexPath];
        
        cell.titleLabel.text = [NSString stringWithFormat:@"第%ld组-第%ld行",indexPath.section,indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.block = ^(UITableViewCell *cell){
       
            VCTableViewCell *VCTablecell =(VCTableViewCell*)cell;
            [self rightTableViewCellDidClikPlus:VCTablecell];
            
        };
        return cell;
    }
   
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView == self.rightTableView)
    {
        return [NSString stringWithFormat:@"第 %ld 组", section];
    }
    return nil;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == self.leftTableView) return;
    
    NSIndexPath *HeaderViewIndex = [[self.rightTableView indexPathsForVisibleRows] firstObject];
    
    NSIndexPath *ToIndex = [NSIndexPath indexPathForRow:HeaderViewIndex.section inSection:0];
    
    [self.leftTableView selectRowAtIndexPath:ToIndex animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.leftTableView)
    {
        NSIndexPath *ToIndex = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        
        [self.rightTableView selectRowAtIndexPath:ToIndex animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}

- (void)rightTableViewCellDidClikPlus:(VCTableViewCell*)cell{


    // 通过坐标转换得到抛物线的起点和终点
    CGRect parentRectA =[cell convertRect:cell.shopBtn.frame toView:self.view];
    CGRect parentRectB = [self.view convertRect:self.shopBtn.frame toView:self.view];
    [self.view addSubview:self.redView];
    
    [[ArticleParabola shared] ArticlObject:self.redView from:parentRectA.origin to:parentRectB.origin];


}


/**
 *   点击购物车
 */
- (void)shop
{
    
}

- (UITableView *)leftTableView
{
    if(_leftTableView == nil)
    {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kAPPW*0.3, kAPPH)];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"leftTableView"];
        _leftTableView.tableFooterView = [[UIView alloc]init];

    }
    return _leftTableView;
}
- (UITableView *)rightTableView
{
    if(_rightTableView == nil)
    {
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(kAPPW*0.3, 0, kAPPW*0.7, kAPPH)];
        _rightTableView.delegate= self;
        _rightTableView.dataSource = self;
        
       
        [_rightTableView registerClass:[VCTableViewCell class] forCellReuseIdentifier:@"VCTableViewCell"];
        _rightTableView.tableFooterView = [[UIView alloc]init];
    }
    return _rightTableView;
}
- (UIButton *)shopBtn
{
    if(_shopBtn == nil){
        _shopBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, kAPPH-80, 30, 30)];
        [_shopBtn setBackgroundImage:[UIImage imageNamed:@"ygouwuche"] forState:UIControlStateNormal];
        [_shopBtn addTarget:self action:@selector(shop) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _shopBtn;
}
- (UIImageView *)redView {
    if (!_redView) {
        _redView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _redView.image = [UIImage imageNamed:@"adddetail"];
        _redView.layer.cornerRadius = 10;
    }
    return _redView;
}
@end
