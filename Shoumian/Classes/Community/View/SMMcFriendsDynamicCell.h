//
//  SMMcFriendsDynamicCell.h
//  Shoumian
//
//  Created by 何志志 on 2017/2/21.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMMcFriendsDynamicModel;
@interface SMMcFriendsDynamicCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *browseBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *discussBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (nonatomic, strong) SMMcFriendsDynamicModel *friendModel;

@end
