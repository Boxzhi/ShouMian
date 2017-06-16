//
//  SMMcFriendsDynamicModel.h
//  Shoumian
//
//  Created by 何志志 on 2017/2/21.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMMcFriendsDynamicModel : NSObject

@property (nonatomic, copy) NSString *iconImagePath;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *contentText;
@property (nonatomic, strong) NSArray *imagePathsArray;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *browseNum;
@property (nonatomic, copy) NSString *likeNum;
@property (nonatomic, copy) NSString *discussNum;

@end
