//
//  SMNavigationController.m
//  Shoumian
//
//  Created by 何志志 on 2017/1/19.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMNavigationController.h"
#import "UIBarButtonItem+Item.h"

@interface SMNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation SMNavigationController

+ (void)load{
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    titleAttr[NSForegroundColorAttributeName] = [UIColor blackColor];
    [navigationBar setTitleTextAttributes:titleAttr];
    
    navigationBar.tintColor = [UIColor whiteColor];
    navigationBar.translucent = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = self;

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"home_back"] highImage:nil target:self action:@selector(back) title:nil];
    }
    [super pushViewController:viewController animated:animated];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return self.childViewControllers.count > 1;
}


- (void)back{
    [self popViewControllerAnimated:YES];
}


@end
