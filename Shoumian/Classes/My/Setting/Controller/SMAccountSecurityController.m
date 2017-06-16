//
//  SMAccountSecurityController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/13.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMAccountSecurityController.h"
#import "SMBindPhoneController.h"
#import "SMSetPasswordController.h"
#import "SMModifyPasswordController.h"

@interface SMAccountSecurityController ()

@property (weak, nonatomic) IBOutlet UIView *bindPhoneView;
@property (weak, nonatomic) IBOutlet UILabel *bindPhoneLab;

@property (weak, nonatomic) IBOutlet UIView *loginPasswordView;
@property (weak, nonatomic) IBOutlet UILabel *passwordLab;

@end

@implementation SMAccountSecurityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"账户与安全";
    
    SMWeakSelf;
    // 绑定手机号
    [self.bindPhoneView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        SMBindPhoneController *bpVc = [[SMBindPhoneController alloc] init];
        [weakSelf.navigationController pushViewController:bpVc animated:YES];
    }];
    
    int x = arc4random() % 2;
    self.passwordLab.text = x == 0 ? @"设置" : @"修改";

    // 登录密码
    [self.loginPasswordView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        if (x == 0) {
            SMSetPasswordController *spVc = [[SMSetPasswordController alloc] init];
            [weakSelf.navigationController pushViewController:spVc animated:YES];
        }else{
            SMModifyPasswordController *mpVc = [[SMModifyPasswordController alloc] init];
            [weakSelf.navigationController pushViewController:mpVc animated:YES];
        }
    }];
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
