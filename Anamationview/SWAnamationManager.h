//
//  SWAnamationManager.h
//  Anamationview
//
//  Created by lx on 17/3/3.
//  Copyright © 2017年 lx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SWAnmationType){
    SWAnmationTypeFromPresent = 0,
    
    SWAnmationTypeToPresent
    
};

@interface SWAnamationManager : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithSWAnmationType:(SWAnmationType)type;

- (instancetype)initTransitionWithSWAnmationType:(SWAnmationType)type;

@end
