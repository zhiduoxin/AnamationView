//
//  SecondViewController.m
//  Anamationview
//
//  Created by lx on 17/3/3.
//  Copyright © 2017年 lx. All rights reserved.
//

#import "SecondViewController.h"
#import "SWAnamationManager.h"


@interface SecondViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation SecondViewController

-(instancetype)init{

    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [SWAnamationManager transitionWithSWAnmationType:SWAnmationTypeToPresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
     return [SWAnamationManager transitionWithSWAnmationType:SWAnmationTypeFromPresent];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"main-2.jpg"];
    [self.view addSubview:image];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 80, 80);
    btn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"dismiss" forState:UIControlStateNormal];
    
    UIButton *btnOther = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _btnFrame = CGRectMake(50, 100, 50, 50);
    btnOther.frame = CGRectMake(200, 100, 80, 80);
    btnOther.backgroundColor = [UIColor redColor];
    [self.view addSubview:btnOther];
    [btnOther addTarget:self action:@selector(btnOtherOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [btnOther setTitle:@"pod" forState:UIControlStateNormal];
}
- (void)btnOnclick:(UIButton *)sender{

    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)btnOtherOnclick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
