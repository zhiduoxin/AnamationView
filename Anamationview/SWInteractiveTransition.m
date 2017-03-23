//
//  SWInteractiveTransition.m
//  Anamationview
//
//  Created by lx on 17/3/6.
//  Copyright © 2017年 lx. All rights reserved.
//

#import "SWInteractiveTransition.h"

@interface SWInteractiveTransition ()

@property (strong, nonatomic) UIViewController *vc;

@property (assign, nonatomic) SWInteractiveTransitionDirection  direction;

@property (assign, nonatomic) SWInteractiveTransitionType type;

@end

@implementation SWInteractiveTransition

+ (instancetype)swInteractiveTransition:(SWInteractiveTransitionType)type direction:(SWInteractiveTransitionDirection)direction {
    SWInteractiveTransition *swInteractiveTransitionVC = [[SWInteractiveTransition alloc] init];
    swInteractiveTransitionVC.type = type;
    swInteractiveTransitionVC.direction = direction;
    return swInteractiveTransitionVC;
}
- (instancetype)initSWInteractiveTransition:(SWInteractiveTransitionType)type irection:(SWInteractiveTransitionDirection)direction{

    return [SWInteractiveTransition swInteractiveTransition:type direction:direction];
}

- (void)addPanGestureForViewController:(UIViewController *)viewcontroller{

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    self.vc = viewcontroller;
    [viewcontroller.view addGestureRecognizer:pan];

}

- (void)handleGesture:(UIPanGestureRecognizer *)gesture{
    
    //手势百分比
    CGFloat persent = 0;
    switch (_direction) {
        case SWInteractiveTransitionDirectionLeft:{
            CGFloat transitionX = -[gesture translationInView:gesture.view].x;
            persent = transitionX / gesture.view.frame.size.width;
        }
            break;
        case SWInteractiveTransitionDirectionRight:{
            CGFloat transitionX = [gesture translationInView:gesture.view].x;
            persent = transitionX / gesture.view.frame.size.width;
        }
            break;
        case SWInteractiveTransitionDirectionUp:{
            CGFloat transitionY = -[gesture translationInView:gesture.view].y;
            persent = transitionY / gesture.view.frame.size.width;
        }
            break;
        case SWInteractiveTransitionDirectionDown:{
            CGFloat transitionY = [gesture translationInView:gesture.view].y;
            persent = transitionY / gesture.view.frame.size.width;
        }
            break;
    }
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            self.interation = YES;
            
            [self startGesture];
            
            break;
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition: persent];
            
            break;
        case UIGestureRecognizerStateEnded:
            self.interation = NO;
            
            if(persent > 0.5){
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            
            break;
        default:
            break;
    }
}


- (void)startGesture{
    switch (_type) {
    case SWInteractiveTransitionPresent:{
        if (_isPresent) {
            _isPresent(YES);
        }
    }
        break;
        
    case SWInteractiveTransitionDismiss:
        [_vc dismissViewControllerAnimated:YES completion:nil];
        break;
    case SWInteractiveTransitionPush:{
        if (_isPresent) {
            _isPresent(NO);
        }
    }
        break;
    case SWInteractiveTransitionPop:
        [_vc.navigationController popViewControllerAnimated:YES];
        break;
    }
    
}
@end
