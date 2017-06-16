//
//  SMPersonalHomepageHeaderView.h
//  Shoumian
//
//  Created by 何志志 on 2017/3/15.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FansLabClick)();
typedef void(^FollowLabClick)();

@interface SMPersonalHomepageHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIButton *privateletterBtn;

@property (nonatomic, copy) FansLabClick fansLabClick;
@property (nonatomic, copy) FollowLabClick followLabClick;

@end
