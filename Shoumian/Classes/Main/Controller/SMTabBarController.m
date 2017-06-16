//
//  SMTabBarController.m
//  Shoumian
//
//  Created by 何志志 on 2017/1/19.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMTabBarController.h"
#import "SMNavigationController.h"
#import "SMHomeController.h"
#import "SMCommunityController.h"
#import "SMInformationController.h"
#import "SMStoreController.h"
#import "SMMyController.h"


@interface SMTabBarController ()

@end

@implementation SMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置Tabbar为不透明
    self.tabBar.translucent = NO;
    
    // Tabbar字体往上偏移一点
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    [self loadTabbar];
}

- (void)loadTabbar{
    
    SMHomeController *homeVc = [[SMHomeController alloc] init];
    SMNavigationController *homeNav = [[SMNavigationController alloc] initWithRootViewController:homeVc];
    homeNav.tabBarItem.image = [UIImage imageNamed:@"home"];
    homeNav.tabBarItem.selectedImage = [UIImage imageNamed:@"home-pre"];
    homeNav.tabBarItem.title = @"首页";
    
    SMCommunityController *communityVc = [[SMCommunityController alloc] init];
    SMNavigationController *communityNav = [[SMNavigationController alloc] initWithRootViewController:communityVc];
    communityNav.tabBarItem.image = [UIImage imageNamed:@"community"];
    communityNav.tabBarItem.selectedImage = [UIImage imageNamed:@"community-pre"];
    communityNav.tabBarItem.title = @"社群";
    
    SMInformationController *informationVc = [[SMInformationController alloc] init];
    SMNavigationController *informationNav = [[SMNavigationController alloc] initWithRootViewController:informationVc];
    informationNav.tabBarItem.image = [UIImage imageNamed:@"information"];
    informationNav.tabBarItem.selectedImage = [UIImage imageNamed:@"information-pre"];
    informationNav.tabBarItem.title = @"消息";
    
    SMStoreController *storeVc = [[SMStoreController alloc] init];
    SMNavigationController *storeNav = [[SMNavigationController alloc] initWithRootViewController:storeVc];
    storeNav.tabBarItem.image = [UIImage imageNamed:@"store"];
    storeNav.tabBarItem.selectedImage = [UIImage imageNamed:@"store-pre"];
    storeNav.tabBarItem.title = @"商城";
    
    SMMyController *myVc = [[SMMyController alloc] init];
    SMNavigationController *myNav = [[SMNavigationController alloc] initWithRootViewController:myVc];
    myNav.tabBarItem.image = [UIImage imageNamed:@"user"];
    myNav.tabBarItem.selectedImage = [UIImage imageNamed:@"user-pre"];
    myNav.tabBarItem.title = @"我的";
    
    self.viewControllers = @[homeNav, communityNav, informationNav, storeNav, myNav];
    self.selectedIndex = 0;
    
    self.tabBar.tintColor = UIColorFromRGB(0xff5050);
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    UIButton *button = [self.tabBar viewWithTag:100];
    if (item.title.length == 0) {
        button.layer.borderColor = RGBA(92, 211, 103, 1).CGColor;
    }else{
        button.layer.borderColor = [UIColor whiteColor].CGColor;
    }
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
