//
//  SMLoginpasswordController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/17.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMLoginpasswordController.h"

@interface SMLoginpasswordController ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *skipLab;
@property (nonatomic, assign) BOOL isCanSideBack;

@end

@implementation SMLoginpasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"设置登录密码";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"home_back"] highImage:nil target:self action:@selector(dismissVc) title:nil];
    self.skipLab.attributedText = [NSString addNSUnderlineStyleAttributeName:@"跳 过"];
    SMWeakSelf;
    [self.skipLab hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        [weakSelf dismissVc];
    }];
}

- (void)dismissVc{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  禁止当前页边缘返回
 */
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.isCanSideBack = NO;
    //关闭ios右滑返回
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    
    return self.isCanSideBack;
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [self resetSideBack];
}
/**
 *  恢复边缘返回
 */
- (void)resetSideBack {
    self.isCanSideBack=YES;
    //开启ios右滑返回
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
