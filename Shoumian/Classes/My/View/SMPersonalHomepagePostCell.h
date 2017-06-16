//
//  SMPersonalHomepagePostCell.h
//  Shoumian
//
//  Created by 何志志 on 2017/3/15.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMPersonalHomepageModel;
@interface SMPersonalHomepagePostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contextLab;
@property (weak, nonatomic) IBOutlet UIButton *browseBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (nonatomic, strong) SMPersonalHomepageModel *postModel;

@end
