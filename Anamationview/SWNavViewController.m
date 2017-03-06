//
//  SWNavViewController.m
//  Anamationview
//
//  Created by lx on 17/3/3.
//  Copyright © 2017年 lx. All rights reserved.
//

#import "SWNavViewController.h"
#import "SWAnamationManager.h"

@interface SWNavViewController ()<UINavigationControllerDelegate>

@end

@implementation SWNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.view.backgroundColor = [UIColor greenColor];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        return [SWAnamationManager transitionWithSWAnmationType:SWAnmationTypeFromPresent];
    }else if (operation == UINavigationControllerOperationPop){
        return [SWAnamationManager transitionWithSWAnmationType:SWAnmationTypeToPresent];
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
