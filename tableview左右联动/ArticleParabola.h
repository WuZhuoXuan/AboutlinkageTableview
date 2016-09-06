//
//  ArticleParabola.h
//  tableview左右联动
//
//  Created by DHSoft on 16/9/6.
//  Copyright © 2016年 DHSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


typedef void(^ArticleBlock)();
@interface ArticleParabola : NSObject


@property (nonatomic,copy)ArticleBlock ArticleBlock;
@property (nonatomic,retain) UIView *showingView;


+ (ArticleParabola *)shared;
/**
 *  将某个view或者layer从起点抛到终点
 *
 *  @param obj    被抛的物体
 *  @param start  起点坐标
 *  @param end    终点坐标
 */
- (void)ArticlObject:(UIView *)obj from:(CGPoint)start to:(CGPoint)end;



@end
