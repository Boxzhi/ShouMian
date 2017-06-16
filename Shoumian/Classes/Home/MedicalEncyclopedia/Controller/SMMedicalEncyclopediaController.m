//
//  SMMedicalEncyclopediaController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/16.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMMedicalEncyclopediaController.h"
#import "SMMedicalEncyclopediaCell.h"

@interface SMMedicalEncyclopediaController ()

@end

@implementation SMMedicalEncyclopediaController

static NSString * const meCellId = @"meCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"医美百科";
    
    [self.view addSubview:self.contentTabPlain];
    [self.contentTabPlain registerNib:[UINib nibWithNibName:NSStringFromClass([SMMedicalEncyclopediaCell class]) bundle:nil] forCellReuseIdentifier:meCellId];
    self.contentTabPlain.rowHeight = 355;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMMedicalEncyclopediaCell *meCell = [tableView dequeueReusableCellWithIdentifier:meCellId forIndexPath:indexPath];
    return meCell;
};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
