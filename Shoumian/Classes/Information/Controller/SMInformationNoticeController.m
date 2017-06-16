//
//  SMInformationNoticeController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/24.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMInformationNoticeController.h"
#import "SMInformationNoticeCell.h"

@interface SMInformationNoticeController ()

@end

@implementation SMInformationNoticeController

static NSString * const noticeCellId = @"noticeCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"通知";
    
    [self.view addSubview:self.contentTabPlain];
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMInformationNoticeCell class]) bundle:nil] forCellReuseIdentifier:noticeCellId];
    self.contentTabPlain.rowHeight = 60;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMInformationNoticeCell *noticeCell = [tableView dequeueReusableCellWithIdentifier:noticeCellId forIndexPath:indexPath];
    return noticeCell;
}

@end
