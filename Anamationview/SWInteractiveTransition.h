//
//  SWInteractiveTransition.h
//  Anamationview
//
//  Created by lx on 17/3/6.
//  Copyright © 2017年 lx. All rights reserved.
//

#import <UIKit/UIKit.h>

//手势的方向
typedef void(^GestureConifg)(BOOL isPresent);

typedef NS_ENUM(NSInteger, SWInteractiveTransitionDirection) {
    SWInteractiveTransitionDirectionLeft = 0,
    SWInteractiveTransitionDirectionRight,
    SWInteractiveTransitionDirectionUp,
    SWInteractiveTransitionDirectionDown,
};

typedef NS_ENUM(NSInteger, SWInteractiveTransitionType) {
    SWInteractiveTransitionPush = 0,
    SWInteractiveTransitionPop,
    SWInteractiveTransitionPresent,
    SWInteractiveTransitionDismiss,
};

@interface SWInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (copy, nonatomic) GestureConifg isPresent;

- (void)addPanGestureForViewController:(UIViewController *)veiwcontroller;


@end
