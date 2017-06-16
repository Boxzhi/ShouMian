//
//  SMPublishedEvaluationController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/20.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPublishedEvaluationController.h"
#import "SMPublishedEvaluationCell.h"
#import "SMPublishedEvaluationSecondCell.h"

@interface SMPublishedEvaluationController ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *lab; //  texteView的占位文字
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) ZYKeyboardUtil *keyboardUtil;

@end

@implementation SMPublishedEvaluationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"发表评价";
    [self.view addSubview:self.contentTabGrouped];
    [self setHeadFootView];
    
    //  防止键盘弹出遮挡输入框
    self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
    SMWeakSelf;
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.textView, nil];
    }];
}

- (void)setHeadFootView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_Width, 60)];
    headerView.backgroundColor = ViewBackgroundColor;
    
    UIView *subView = [UIView hyb_viewWithSuperView:headerView constraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(headerView);
        make.bottom.mas_offset(-10);
    }];
    subView.backgroundColor = [UIColor whiteColor];
    
    UILabel *headLab = [UILabel hyb_labelWithText:@"订单编号：     111124352" font:15 superView:subView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.centerY.equalTo(subView.mas_centerY);
    }];
    headLab.textColor = UIColor333;
    
    self.contentTabGrouped.tableHeaderView = headerView;
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_Width, 240)];
    footerView.backgroundColor = ViewBackgroundColor;
    
    UIView *textSupView = [UIView hyb_viewWithSuperView:footerView constraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(footerView);
        make.height.mas_equalTo(145);
    }];
    textSupView.backgroundColor = [UIColor whiteColor];
    //  评语输入框
    UITextView *textView = [UITextView hyb_viewWithSuperView:textSupView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.right.mas_offset(-SMMargin);
        make.top.mas_offset(15);
        make.bottom.mas_offset(-10);
    }];
    textView.returnKeyType = UIReturnKeyDone;
    textView.delegate = self;
    textView.textColor = UIColor666;
    textView.font = FONTSIZE(15);
    self.textView = textView;
    UILabel *lab = [UILabel hyb_labelWithText:@"写下你的评价..." font:15 superView:textSupView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin + 5);
        make.top.mas_offset(24);
    }];
    lab.textColor = UIColor999;
    self.lab = lab;
    
    //  提交评价
    UIButton *btn = [UIButton hyb_buttonWithTitle:@"提交评价" superView:footerView constraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-SMMargin);
        make.top.equalTo(textSupView.mas_bottom).offset(25);
        make.width.mas_equalTo(100);
        make.height.mas_lessThanOrEqualTo(40);
    } touchUp:^(UIButton *sender) {
        
    }];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:UIColorRed];
    [btn.titleLabel setFont:FONTSIZE(17)];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    
    
    self.contentTabGrouped.tableFooterView = footerView;
}

#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 103;
    }else{
        return 160;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        SMPublishedEvaluationCell *peCell = [[SMPublishedEvaluationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        peCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return peCell;
    }else{
        
        SMPublishedEvaluationSecondCell *secondCell = [SMPublishedEvaluationSecondCell viewFromXib];
        secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
        secondCell.tagBtnClickBlock = ^(NSString *text){
            
        };
        return secondCell;
    }
};

#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    self.lab.hidden = [textView.text length];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text])
    {
        [self.textView resignFirstResponder];
//        if ([self.textView.text length]) {
//            [self.textView resignFirstResponder];
//        }
//        else
//        {
//            return NO;
//        }
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
