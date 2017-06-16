//
//  SMMyProjectCell.h
//  Shoumian
//
//  Created by 何志志 on 2017/2/13.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^myProjectBtnClickBlock)();

@interface SMMyProjectCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *shiyongLab;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *projectLab;

@property (weak, nonatomic) IBOutlet UILabel *hospitalLab;

@property (weak, nonatomic) IBOutlet UILabel *doctorLab;

@property (weak, nonatomic) IBOutlet UILabel *treatmentNumberLab;

@property (weak, nonatomic) IBOutlet UILabel *surplusNumberLab;

@property (weak, nonatomic) IBOutlet UIButton *appointmentBtn;


@property (nonatomic, copy) myProjectBtnClickBlock appBtnBlock;

@end
