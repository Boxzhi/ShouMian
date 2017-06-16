//
//  SMRegisterViewController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/16.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMRegisterViewController.h"
#import "SMLoginViewController.h"
#import "SMNavigationController.h"
#import "SMLoginpasswordController.h"

@interface SMRegisterViewController ()

@end

@implementation SMRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"注册";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"home_back"] highImage:nil target:self action:@selector(dismissVc) title:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:nil highImage:nil target:self action:@selector(gotoLoginVc) title:@"登录"];
}

#pragma mark -- 点击注册按钮
- (IBAction)registerBtnClick:(id)sender {
    SMLoginpasswordController *lpVc = [[SMLoginpasswordController alloc] init];
    [self.navigationController pushViewController:lpVc animated:YES];
}

- (void)dismissVc{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)gotoLoginVc{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    [SMKeyWindow.rootViewController presentViewController:[[SMNavigationController alloc] initWithRootViewController:[[SMLoginViewController alloc] init]] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
