//
//  SMMcFriendsDynamicCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/21.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMMcFriendsDynamicCell.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>

#import "PhotosContainerView.h"

#import "SMMcFriendsDynamicModel.h"

@implementation SMMcFriendsDynamicCell
{
    PhotosContainerView *_photosContainer;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.lineView.backgroundColor = UIColorFromRGB(0xdddddd);
    
    PhotosContainerView *photosContainer = [[PhotosContainerView alloc] initWithMaxItemsCount:9];
    _photosContainer = photosContainer;
    [self.contentView addSubview:photosContainer];
    
    /**
     *  对cell内部空间进行布局
     */
    // 头像
    self.iconView.sd_layout
    .leftSpaceToView(self.contentView, SMMargin)
    .topSpaceToView(self.contentView, 15)
    .widthIs(60)
    .heightEqualToWidth();
    
    // 用户名
    self.nameLab.sd_layout.leftSpaceToView(self.iconView, 13).topSpaceToView(self.contentView, 21).rightSpaceToView(self.contentView, SMMargin);
    [self.nameLab setMaxNumberOfLinesToShow:1];
    
    // 内容文字
    self.contentLab.sd_layout.leftEqualToView(self.nameLab).topSpaceToView(self.nameLab, 20).rightSpaceToView(self.contentView, SMMargin).autoHeightRatio(0);
    
    // 内容图片
    _photosContainer.sd_layout.leftEqualToView(self.nameLab).rightEqualToView(self.nameLab).topSpaceToView(self.contentLab, 10).autoHeightRatio(0);
    
    // 时间
    self.timeLab.sd_layout.leftEqualToView(self.nameLab).topSpaceToView(photosContainer, 10).rightSpaceToView(self.contentView, 12.5).autoHeightRatio(1);
    [self.timeLab setMaxNumberOfLinesToShow:1];
    
    // 评论按钮
    self.discussBtn.sd_layout.topSpaceToView(self.timeLab, 11).rightEqualToView(self.nameLab).heightIs(20).widthIs(60);
//    [self.discussBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:20];
    
    // 点赞按钮
    self.likeBtn.sd_layout.rightSpaceToView(self.discussBtn, 27).centerYEqualToView(self.discussBtn).heightIs(20).widthRatioToView(self.discussBtn, 1);
//    [self.likeBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:20];
    
    // 已浏览按钮
    self.browseBtn.sd_layout.rightSpaceToView(self.likeBtn, 27).centerYEqualToView(self.likeBtn).heightIs(20).widthRatioToView(self.discussBtn, 1);
//    [self.browseBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:20];
    
    // 分割线
    self.lineView.sd_layout.leftEqualToView(self.contentView).rightEqualToView(self.contentView).topSpaceToView(self.discussBtn, 13).heightIs(0.5);
}


- (void)setFriendModel:(SMMcFriendsDynamicModel *)friendModel{
    _friendModel = friendModel;
    
    _contentLab.text = friendModel.contentText;
    _iconView.image = [UIImage imageNamed:friendModel.iconImagePath];
    _nameLab.text = friendModel.name;
    _photosContainer.photoNamesArray = friendModel.imagePathsArray;
    _timeLab.text = friendModel.time;
    [_browseBtn setTitle:friendModel.browseNum forState:UIControlStateNormal];
    [_discussBtn setTitle:friendModel.discussNum forState:UIControlStateNormal];
    [_likeBtn setTitle:friendModel.likeNum forState:UIControlStateNormal];
    
    if (friendModel.imagePathsArray.count > 0) {
        _photosContainer.hidden = NO;
    } else {
        _photosContainer.hidden = YES;
    }
    
     [self setupAutoHeightWithBottomView:_lineView bottomMargin:0];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
