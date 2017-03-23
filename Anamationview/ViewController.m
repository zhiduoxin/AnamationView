//
//  ViewController.m
//  Anamationview
//
//  Created by lx on 17/3/3.
//  Copyright © 2017年 lx. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "SWInteractiveTransition.h"
#import "SWInteractiveTransition.h"

#import "Comment.h"

@interface ViewController ()<UINavigationBarDelegate,UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) SWInteractiveTransition *interactiveTrasition;


@end

@implementation ViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"main-1.jpg"];
//    image.contentMode = UIViewContentModeCenter;
    [self.view addSubview:image];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnFrame = CGRectMake(100, 100, 80, 80);
    btn.frame = _btnFrame;
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"present" forState:UIControlStateNormal];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [btn addGestureRecognizer:pan];
    
    
    UIButton *btnOther = [UIButton buttonWithType:UIButtonTypeCustom];
//    _btnFrame = CGRectMake(50, 100, 50, 50);
    btnOther.frame = CGRectMake(200, 100, 80, 80);
    btnOther.backgroundColor = [UIColor redColor];
    [self.view addSubview:btnOther];
    [btnOther addTarget:self action:@selector(btnOtherOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [btnOther setTitle:@"push" forState:UIControlStateNormal];
    
    self.interactiveTrasition = [SWInteractiveTransition swInteractiveTransition:2 direction:2];
    [self.interactiveTrasition addPanGestureForViewController:self];
    
    SWWeakSelf(self);
    self.interactiveTrasition.isPresent = ^(BOOL isPresent){
        if (isPresent == YES) {
            [weakSelf btnOnclick:nil];
        }else{
            [weakSelf btnOtherOnclick:nil];
        }
    };
    
}

- (void)btnOnclick:(UIButton *)sender{
    
    [self presentViewController:[[SecondViewController alloc] init] animated:YES completion:nil];
    
}
- (void)btnOtherOnclick:(UIButton *)sender{
    [self.navigationController pushViewController:[[SecondViewController alloc] init] animated:YES];
}
- (void)pan:(UIPanGestureRecognizer *)gesture{
    UIView *button = gesture.view;
    CGPoint pt = [gesture translationInView:gesture.view];
    CGPoint newCenter = CGPointMake(gesture.view.center.x+pt.x,gesture.view.center.y+pt.y);
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        
         [button setCenter:newCenter];
        
    }else if (gesture.state == UIGestureRecognizerStateEnded) {
        
        CGFloat newCenterX = newCenter.x;
        CGFloat newCenterY = newCenter.y;
        
        if (newCenterX<=button.frame.size.width/2){
            newCenterX = button.frame.size.width/2;
        }
        if (newCenterX>=button.superview.frame.size.width-button.frame.size.width/2) {
            newCenterX = button.superview.frame.size.width-button.frame.size.width/2;
        }
        if (newCenterY<=button.frame.size.height/2+64){
            newCenterY = button.frame.size.height/2+64;
        }
        if (newCenterY>=button.superview.frame.size.height-button.frame.size.height/2) {
            newCenterY = button.superview.frame.size.height-button.frame.size.height/2;
        }
        newCenter = CGPointMake(newCenterX, newCenterY);
        [UIView animateWithDuration:.5 animations:^{
            [button setCenter:newCenter];
        }];
    }
    [gesture setTranslation:CGPointZero inView:gesture.view];
    self.btnFrame = button.frame;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return self.interactiveTrasition.interation ? self.interactiveTrasition: nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
