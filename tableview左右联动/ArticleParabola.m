//
//  ArticleParabola.m
//  tableview左右联动
//
//  Created by DHSoft on 16/9/6.
//  Copyright © 2016年 DHSoft. All rights reserved.
//

#import "ArticleParabola.h"

static ArticleParabola *a_sharedInstance = nil;

@implementation ArticleParabola

+ (ArticleParabola *)shared
{
    if (!a_sharedInstance)
    {
        a_sharedInstance = [[[self class]alloc] init];
    }
    return a_sharedInstance;
}
/**
 *  将某个view或者layer从起点抛到终点
 *
 *  @param obj    被抛的物体
 *  @param start  起点坐标
 *  @param end    终点坐标
 */
- (void)ArticlObject:(UIView *)obj from:(CGPoint)start to:(CGPoint)end
{
    self.showingView = obj;
    UIBezierPath *path= [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(start.x, start.y)];
    //三点曲线
    [path addCurveToPoint:CGPointMake(end.x+25, end.y+25)
            controlPoint1:CGPointMake(start.x, start.y)
            controlPoint2:CGPointMake(start.x - 180, start.y - 200)];
    
    [self groupAnimation:path];
    
    
}

#pragma mark - 组合动画
- (void)groupAnimation:(UIBezierPath *)path{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.8f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.6f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [self.showingView.layer addAnimation:groups forKey:@"position scale"];


}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(_ArticleBlock)
    {
        _ArticleBlock();
    }
    self.showingView = nil;
}



@end
