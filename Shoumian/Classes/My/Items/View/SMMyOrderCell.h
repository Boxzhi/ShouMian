//
//  SMMyOrderCell.h
//  Shoumian
//
//  Created by 何志志 on 2017/3/20.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AppointmentBtnBlock)();
typedef void(^WriteDiaryBtnBlock)();
typedef void(^EvaluationBtnBlock)();

@interface SMMyOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *appointmentBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic, copy) AppointmentBtnBlock appointmentBtnClickBlock;
@property (nonatomic, copy) WriteDiaryBtnBlock writeDiaryBtnClickBlock;
@property (nonatomic, copy) EvaluationBtnBlock evaluationBtnClickBlock;

@end
