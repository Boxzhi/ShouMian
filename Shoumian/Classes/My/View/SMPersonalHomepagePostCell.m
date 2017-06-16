//
//  SMPersonalHomepagePostCell.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/15.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPersonalHomepagePostCell.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
#import "SMPersonalHomepageModel.h"

@implementation SMPersonalHomepagePostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //  UI布局
    //  头像
    self.headImage.sd_layout
    .leftSpaceToView(self.contentView, SMMargin)
    .topSpaceToView(self.contentView, 20)
    .widthIs(30)
    .heightEqualToWidth();
    //  时间
    self.timeLab.sd_layout
    .rightSpaceToView(self.contentView, SMMargin)
    .centerYEqualToView(self.headImage)
    .widthIs(60);
    //  昵称
    self.nameLab.sd_layout
    .leftSpaceToView(self.headImage, SMMargin)
    .rightSpaceToView(self.timeLab, SMMargin)
    .centerYEqualToView(self.headImage);
    [self.nameLab setMaxNumberOfLinesToShow:1];
    //  内容图片
    self.contentImage.sd_layout
    .leftSpaceToView(self.contentView, SMMargin)
    .rightSpaceToView(self.contentView, SMMargin)
    .topSpaceToView(self.headImage, 10);
    //  标题
    self.titleLab.sd_layout
    .leftSpaceToView(self.contentView, SMMargin)
    .rightSpaceToView(self.contentView, SMMargin)
    .topSpaceToView(self.contentImage, 8);
    [self.titleLab setMaxNumberOfLinesToShow:1];
    //  内容文字
    self.contextLab.sd_layout
    .leftSpaceToView(self.contentView, SMMargin)
    .rightSpaceToView(self.contentView, SMMargin)
    .topSpaceToView(self.titleLab, 12)
    .autoHeightRatio(0);
    //  评论按钮
    self.commentBtn.sd_layout
    .rightSpaceToView(self.contentView, SMMargin)
    .topSpaceToView(self.contextLab, 15)
    .heightIs(20)
    .widthIs(60);
    //  点赞按钮
    self.likeBtn.sd_layout
    .rightSpaceToView(self.commentBtn, 27)
    .centerYEqualToView(self.commentBtn)
    .heightIs(20)
    .widthIs(60);
    //  浏览按钮
    self.browseBtn.sd_layout
    .rightSpaceToView(self.likeBtn, 27)
    .centerYEqualToView(self.commentBtn)
    .heightIs(20)
    .widthIs(60);
    //  分割线
    self.lineView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topSpaceToView(self.commentBtn, 15)
    .heightIs(SMLineViewHeight);
    self.lineView.backgroundColor = LineViewBackgroundColor;
}

- (void)setPostModel:(SMPersonalHomepageModel *)postModel{
    _postModel = postModel;
    
    self.headImage.image = [UIImage imageNamed:postModel.headImageStr];
    self.nameLab.text = postModel.nameStr;
    self.timeLab.text = postModel.timeStr;
    self.titleLab.text = postModel.titleStr;
    self.contextLab.text = postModel.contextStr;
    [self.browseBtn setTitle:postModel.browseNum forState:UIControlStateNormal];
    [self.likeBtn setTitle:postModel.likeNum forState:UIControlStateNormal];
    [self.commentBtn setTitle:postModel.commentNum forState:UIControlStateNormal];
    
    //  计算图片的宽高比
    UIImage *pic = [UIImage imageNamed:postModel.contentImageStr];
    if (pic == nil) {
        
        self.contentImage.sd_layout.autoHeightRatio(0);
    }else{
        
        CGFloat scale = pic.size.height / pic.size.width;
        self.contentImage.sd_layout.autoHeightRatio(scale);
        self.contentImage.image = pic;
    }
    
    [self setupAutoHeightWithBottomView:self.lineView bottomMargin:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
