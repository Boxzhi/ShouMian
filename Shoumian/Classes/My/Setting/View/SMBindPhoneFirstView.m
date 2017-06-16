//
//  SMBindPhoneFirstView.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/13.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMBindPhoneFirstView.h"

@interface SMBindPhoneFirstView()

@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;

@end

@implementation SMBindPhoneFirstView

- (IBAction)getVerificationBtnClick:(id)sender {
    if (self.getVerificationButtonClick) {
        self.getVerificationButtonClick();
    }
}

- (IBAction)nextStepButtonClick:(id)sender {
    if (self.nextStepButtonClick) {
        self.nextStepButtonClick(self.verificationTextField.text);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
