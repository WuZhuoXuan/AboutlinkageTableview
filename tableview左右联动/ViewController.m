//
//  ViewController.m
//  tableview左右联动
//
//  Created by DHSoft on 16/8/24.
//  Copyright © 2016年 DHSoft. All rights reserved.
//

#import "ViewController.h"


#define kAPPH [[UIScreen mainScreen] bounds].size.height
#define kAPPW [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *leftTableView;

@property (nonatomic,strong)UITableView *rightTableView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
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
    UITableViewCell *cell;
    
    if(tableView == self.leftTableView)
    {
        cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"leftTableView" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
       
    }else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"rightTableView" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"第%ld组-第%ld行",indexPath.section,indexPath.row];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
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
        
        [_rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"rightTableView"];
        _rightTableView.tableFooterView = [[UIView alloc]init];
    }
    return _rightTableView;
}

@end
