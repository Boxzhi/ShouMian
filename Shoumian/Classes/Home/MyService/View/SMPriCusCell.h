//
//  SMPriCusCell.h
//  Shoumian
//
//  Created by 何志志 on 2017/2/13.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^pricusAppBtnClickBlock)();

@interface SMPriCusCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *remainingNumberLab;

@property (weak, nonatomic) IBOutlet UIButton *appointmentsBtn;


@property (nonatomic, copy) pricusAppBtnClickBlock pricusAppBtnBlock;

@end
