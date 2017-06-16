//
//  SMDoctorsAppCell.h
//  Shoumian
//
//  Created by 何志志 on 2017/2/13.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^doctorsAppointmentsClickBlock)();

@interface SMDoctorsAppCell : UITableViewCell

@property (nonatomic, copy) doctorsAppointmentsClickBlock docAppBtnBlock;

@end
