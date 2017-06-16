//
//  SMInformationController.m
//  Shoumian
//
//  Created by 何志志 on 2017/1/19.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMInformationController.h"
#import "SMCommentsPraiseController.h"
#import "SMChatController.h"
#import "SMInformationOrderController.h"
#import "SMInformationAppointmentController.h"
#import "SMInformationNoticeController.h"

@interface SMInformationController ()

@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UIView *fourthView;
@property (weak, nonatomic) IBOutlet UIView *fifthView;

@property (weak, nonatomic) IBOutlet UIButton *firstCornerBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondCornerBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdCornerBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourthCornerBtn;
@property (weak, nonatomic) IBOutlet UIButton *fifthCornerBtn;

@end

@implementation SMInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.secondCornerBtn.hidden = self.thirdCornerBtn.hidden = self.fifthCornerBtn.hidden = YES;
    self.navigationItem.title = @"消息";
    
    SMWeakSelf;
    // 评论和赞
    [self.firstView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        SMCommentsPraiseController *cpVc = [[SMCommentsPraiseController alloc] init];
        [weakSelf.navigationController pushViewController:cpVc animated:YES];
    }];
    // 咨询和私信
    [self.secondView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        SMChatController *chatVc = [[SMChatController alloc] init];
        [weakSelf.navigationController pushViewController:chatVc animated:YES];
    }];
    // 订单
    [self.thirdView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        SMInformationOrderController *orderVc = [[SMInformationOrderController alloc] init];
        [weakSelf.navigationController pushViewController:orderVc animated:YES];
    }];
    // 预约
    [self.fourthView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        SMInformationAppointmentController *orderVc = [[SMInformationAppointmentController alloc] init];
        [weakSelf.navigationController pushViewController:orderVc animated:YES];
    }];
    // 通知
    [self.fifthView hyb_addTapGestureWithCallback:^(UITapGestureRecognizer *sender) {
        SMInformationNoticeController *noticeVc = [[SMInformationNoticeController alloc] init];
        [weakSelf.navigationController pushViewController:noticeVc animated:YES];
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
