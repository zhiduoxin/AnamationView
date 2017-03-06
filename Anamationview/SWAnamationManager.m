//
//  SWAnamationManager.m
//  Anamationview
//
//  Created by lx on 17/3/3.
//  Copyright © 2017年 lx. All rights reserved.
//

#import "SWAnamationManager.h"
#import "ViewController.h"
#import "SecondViewController.h"
#import "SWNavViewController.h"

@interface SWAnamationManager()<CAAnimationDelegate>

@property (assign, nonatomic) SWAnmationType  type;

@end

@implementation SWAnamationManager


+ (instancetype)transitionWithSWAnmationType:(SWAnmationType)type{

    SWAnamationManager *manager = [[SWAnamationManager alloc] init];
    
    manager.type = type;
    
    return manager;
}

- (instancetype)initTransitionWithSWAnmationType:(SWAnmationType)type{

    return [SWAnamationManager transitionWithSWAnmationType:type];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    switch (_type) {
        case SWAnmationTypeFromPresent:
            [self presentAnimation:transitionContext];
            break;
            
        case SWAnmationTypeToPresent:
            [self dismissAnimation:transitionContext];
            break;
    }
}

//实现present或者push动画逻辑代码
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    SecondViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ViewController *temp;
    if([[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] isKindOfClass:[UINavigationController class]]){
    /*
     present
     */

    SWNavViewController *fromVC = (SWNavViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    temp = fromVC.viewControllers.lastObject;
    }else{
    /*
        push
     */
    temp = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    }
    
    UIView *containerView = [transitionContext containerView];
    NSLog(@"00%@",containerView.subviews);
    
    [containerView addSubview:toVC.view];
     NSLog(@"11%@",containerView.subviews);
    
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithOvalInRect:temp.btnFrame];
    
    CGFloat x = MAX(temp.btnFrame.origin.x, containerView.frame.size.width - temp.btnFrame.origin.x);
    
    CGFloat y = MAX(temp.btnFrame.origin.y, containerView.frame.size.height - temp.btnFrame.origin.y);
    
    ////勾股定理计算半径
    CGFloat radius = sqrtf(pow(x, 2)+pow(y, 2));
    
    
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *masklayer =[CAShapeLayer layer];
    
    masklayer.path = endCycle.CGPath;
    toVC.view.layer.mask = masklayer;
    
    //创建路径动画
    CABasicAnimation *maskLayerAnamation = [CABasicAnimation animationWithKeyPath:@"path"];
    
    maskLayerAnamation.delegate = self;
    
    maskLayerAnamation.fromValue = (__bridge id)(startCycle.CGPath);
    
    maskLayerAnamation.toValue = (__bridge id)(endCycle.CGPath);
    
    maskLayerAnamation.duration = [self transitionDuration:transitionContext];
    
    maskLayerAnamation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnamation setValue:transitionContext forKey:@"transitionContext"];
    
    [masklayer addAnimation:maskLayerAnamation forKey:@"path"];
}
//实现dismiss动画逻辑代码
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    SecondViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    NSLog(@"22%@",containerView.subviews);
    
    ViewController *temp;
    if ([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isKindOfClass:[UINavigationController class]]) {
    /*
        这里dismiss的动画效果
     */
    UINavigationController *toVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    temp = toVC.viewControllers.lastObject;
    
    }else{
    /*
     这里pop的动画效果
     */
    temp = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

        [containerView insertSubview:temp.view atIndex:0];
    }
    NSLog(@"33%@",containerView.subviews);
    
    //画两个圆路径
    CGFloat radius = sqrtf(containerView.frame.size.height * containerView.frame.size.height + containerView.frame.size.width * containerView.frame.size.width) / 2;
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:temp.btnFrame];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    fromVC.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    switch (_type) {
        case SWAnmationTypeFromPresent:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
            [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
        }
            break;
        case SWAnmationTypeToPresent:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            }
        }
            break;
    }
}
@end


