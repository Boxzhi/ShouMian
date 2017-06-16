//
//  SMCommunityController.m
//  Shoumian
//
//  Created by 何志志 on 2017/1/19.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMCommunityController.h"
#import "SMAssociationController.h"
#import "SMMyCommunityController.h"

@interface SMCommunityController ()

@property (nonatomic, strong)NSArray *titleData;

@end

@implementation SMCommunityController

- (NSArray *)titleData{
    if (!_titleData) {
        _titleData = @[@"社群", @"我在社群"];
    }
    return _titleData;
}

- (instancetype)init{
    if (self = [super init]) {
        self.menuHeight = 44;
        self.menuItemWidth = S_Width / 2;
        self.menuBGColor = [UIColor whiteColor];
        self.menuViewStyle = WMMenuViewStyleLine;
        self.progressColor = UIColorRed;
        self.titleSizeNormal = 16;
        self.titleSizeSelected = 16;
        self.titleColorNormal = UIColorFromRGB(0x666666);
        self.titleColorSelected = UIColorRed;
        self.preloadPolicy = WMPageControllerPreloadPolicyNear;
//        self.menuViewBottomSpace = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:16]};
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        CGSize titleSize = [_titleData[i] sizeWithAttributes:attrs];
        [arr addObject:[NSNumber numberWithFloat:titleSize.width]];
    }
    self.progressViewWidths = arr;
    
}


#pragma mark - DataSource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titleData.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    switch (index) {
            case 0:{
                return [[SMAssociationController alloc] init];
            }
            break;
            case 1:{
                return [[SMMyCommunityController alloc] init];
            }
            break;
            
        default:
            return nil;
            break;
    }
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    return self.titleData[index];
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
