//
//  SMFeedbackViewController.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/14.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMFeedbackViewController.h"

@interface SMFeedbackViewController ()<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) ZYKeyboardUtil *keyboardUtil;

@property (weak, nonatomic) IBOutlet UILabel *placeLab;
@property (weak, nonatomic) IBOutlet UITextView *wordTextView;
@property (weak, nonatomic) IBOutlet UITextField *firstTF;
@property (weak, nonatomic) IBOutlet UITextField *secondTF;
@property (weak, nonatomic) IBOutlet UITextField *thirdTF;

@end

@implementation SMFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"意见反馈";
    self.view.backgroundColor = UIColorFromRGB(0xf8f8f8);
    self.wordTextView.delegate = self;
    self.firstTF.delegate = self;
    self.secondTF.delegate = self;
    self.thirdTF.delegate = self;
    
    //  防止键盘弹出遮挡输入框
    self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
    SMWeakSelf;
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.wordTextView, weakSelf.firstTF, weakSelf.secondTF, weakSelf.thirdTF, nil];
    }];
}

#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    self.placeLab.hidden = [textView.text length];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.firstTF == textField) {
        [self.firstTF resignFirstResponder];
        [self.secondTF becomeFirstResponder];
    }else if (self.secondTF == textField){
        [self.secondTF resignFirstResponder];
        [self.thirdTF becomeFirstResponder];
    }else{
        [self.thirdTF resignFirstResponder];
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
