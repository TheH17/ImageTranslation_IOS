//
//  HLLoginTool.m
//  ImageTranslation
//
//  Created by hueyLee on 08/04/2018.
//  Copyright © 2018 李浩鹏. All rights reserved.
//

#import "HLLoginTool.h"
#import "HLInferenceViewController.h"
#import "HLRelateViewController.h"
#import "HLInfoViewController.h"

@implementation HLLoginTool

+ (void)enterAppWithWindow:(UIWindow *)window {
    [UIView animateWithDuration:1.0 animations:^{
        window.rootViewController = [self createMainController];
    }];
}

+ (UIViewController *)createMainController {
    UITabBarController *vc = [UITabBarController new];
    
    UIViewController *vc1 = ({
        HLInferenceViewController *vc = [HLInferenceViewController new];
        vc.tabBarItem.title = @"首页";
        vc.tabBarItem.image = [UIImage imageNamed:@"首页"];
        
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav;
    });
    UIViewController *vc2 = ({
        HLRelateViewController *vc = [HLRelateViewController new];
        vc.tabBarItem.title = @"探索";
        vc.tabBarItem.image = [UIImage imageNamed:@"发现"];
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav;
    });
    
    UIViewController *vc3 = ({
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"hlinfo" bundle:[NSBundle mainBundle]];
        HLInfoViewController *vc = (HLInfoViewController*)[storyboard instantiateViewControllerWithIdentifier:@"HLInfoViewController"];
        vc.tabBarItem.title = @"个人";
        vc.tabBarItem.image = [UIImage imageNamed:@"个人"];
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav;
    });
    
    [@[vc1, vc2, vc3] enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
        [obj.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    }];
    
    vc.viewControllers = @[vc1, vc2, vc3];
    vc.selectedIndex = 0;
    
    return vc;
}

@end
