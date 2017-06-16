//
//  SMPostingTipsController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/23.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPostingTipsController.h"
#import "SMPostController.h"

@interface SMPostingTipsController ()

@property (weak, nonatomic) IBOutlet UILabel *ftsmLab;

@end

@implementation SMPostingTipsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"提示";
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:self.ftsmLab.text];
    [attributedStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, 6)];
    [attributedStr addAttribute:NSUnderlineColorAttributeName value:UIColorRed range:NSMakeRange(0, 6)];
    [self.ftsmLab setAttributedText:attributedStr];
}

- (IBAction)JumpButtonClick:(id)sender {
    SMPostController *postVc = [[SMPostController alloc] init];
    [self.navigationController pushViewController:postVc animated:YES];
}

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
