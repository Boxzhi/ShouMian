//
//  SMPrivacyViewController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/14.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPrivacyViewController.h"

@interface SMPrivacyViewController ()

@end

@implementation SMPrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"隐私设置";
    
    [self setContentView];
}

- (void)setContentView{
    UIView *contentView = [UIView hyb_viewWithSuperView:self.view constraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    contentView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab = [UILabel hyb_labelWithText:@"出现在附近的人" font:15 superView:contentView constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentView.mas_centerY);
        make.left.mas_offset(SMMargin);
    }];
    lab.textColor = UIColor666;
    
    UISwitch *switchView = [UISwitch hyb_viewWithSuperView:contentView constraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.centerY.equalTo(contentView.mas_centerY);
        make.width.mas_equalTo(52);
        make.height.mas_equalTo(32);
    }];
    switchView.on = YES;
    
    UIView *lineView = [UIView hyb_addBottomLineToView:contentView height:0.5f color:LineViewBackgroundColor];
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
