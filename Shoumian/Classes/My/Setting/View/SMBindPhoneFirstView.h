//
//  SMBindPhoneFirstView.h
//  Shoumian
//
//  Created by 何志志 on 2017/3/13.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GetVerificationButtonClick)();
typedef void (^NextStepButtonClick)(NSString *text);

@interface SMBindPhoneFirstView : UIView

@property (nonatomic, copy) GetVerificationButtonClick getVerificationButtonClick;
@property (nonatomic, copy) NextStepButtonClick nextStepButtonClick;

@end
