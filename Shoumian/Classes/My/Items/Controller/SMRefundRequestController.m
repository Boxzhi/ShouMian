//
//  SMRefundRequestController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/20.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMRefundRequestController.h"
#import "SMRefundDetailsController.h"

@interface SMRefundRequestController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *refundDescriptionLab;
@property (weak, nonatomic) IBOutlet UITextView *refundTextView;

@end

@implementation SMRefundRequestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"退款申请";
    self.view.backgroundColor = [UIColor whiteColor];
    self.refundTextView.delegate = self;
}

- (IBAction)submitApplicationBtn:(id)sender {
    SMRefundDetailsController *rdVc = [[SMRefundDetailsController alloc] init];
    [self.navigationController pushViewController:rdVc animated:YES];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    self.refundDescriptionLab.hidden = [textView.text length];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
