//
//  SMPostController.m
//  Shoumian
//
//  Created by 何志志 on 2017/2/27.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "SMPostController.h"
#import "LPDQuoteImagesView.h"

CGFloat headerPortionHegiht = 50 + 10 + 130 + 1 + 5 + 30;

@interface SMPostController ()<UITextFieldDelegate, UITextViewDelegate, UIGestureRecognizerDelegate, LPDQuoteImagesViewDelegate>

@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UITextView *reportStateTextView;
@property (nonatomic, weak) UILabel *pLabel;
@property (nonatomic, weak) UILabel *addLab;
@property (nonatomic, weak) UIView *headView;
@property (nonatomic, strong) LPDQuoteImagesView *lpdView;
@property (nonatomic, assign) NSInteger photoCount;   //  选中的照片数量

@end

@implementation SMPostController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"发帖";
    
    [self.view addSubview:self.contentTabGrouped];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardDismiss:)];
    tap.delegate = self;
    [self.contentTabGrouped addGestureRecognizer:tap];
    self.contentTabGrouped.backgroundColor = [UIColor whiteColor];
    self.photoCount = 0;
    [self initHeaderView];
}

#define textViewHeight 130
#define MacImageCout 9
- (void)initHeaderView
{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectZero];
    headView.backgroundColor = [UIColor whiteColor];
    
    UIView *titleView = [UIView hyb_viewWithSuperView:headView constraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(headView);
        make.height.mas_offset(50);
    }];
    titleView.backgroundColor = [UIColor whiteColor];
    //  标题Label
//    UILabel * titleLab = [UILabel hyb_labelWithText:@"标题" font:15 superView:titleView constraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(SMMargin);
//        make.centerY.equalTo(titleView.mas_centerY);
//    }];
//    titleLab.textColor = UIColor666;
    //  第一个分割线
    UIView *lineView1 = [UIView hyb_addBottomLineToView:titleView height:1 color:LineViewBackgroundColor];
    //  标题输入框
    UITextField *textField = [UITextField hyb_textFieldWithHolder:@"标题" delegate:self superView:titleView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin + 5);
        make.top.equalTo(titleView.mas_top);
        make.right.mas_offset(-SMMargin);
        make.bottom.equalTo(lineView1.mas_top);
    }];
    textField.textColor = UIColor666;
    textField.font = [UIFont systemFontOfSize:15];
    textField.returnKeyType = UIReturnKeyDone;
    self.textField = textField;
    //  内容输入TextView
    UITextView *reportStateTextView = [UITextView hyb_viewWithSuperView:headView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin);
        make.top.equalTo(titleView.mas_bottom).offset(10);
        make.right.mas_offset(-SMMargin);
        make.height.mas_equalTo(130);
    }];
    reportStateTextView.text = self.reportStateTextView.text;
    reportStateTextView.textColor = UIColor666;
    reportStateTextView.font = [UIFont systemFontOfSize:15];
    reportStateTextView.returnKeyType = UIReturnKeyDone;
    self.reportStateTextView = reportStateTextView;
    self.reportStateTextView.delegate = self;
    UILabel *plLab = [UILabel hyb_labelWithText:@"这一刻的想法..." font:15 superView:headView constraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(SMMargin + 5);
        make.top.equalTo(reportStateTextView.mas_top).offset(8);
    }];
    plLab.hidden = [self.reportStateTextView.text length];
    plLab.textColor = UIColor999;
    self.pLabel = plLab;
    //  第二个分割线
    UIView *lineView2 = [UIView hyb_viewWithSuperView:headView constraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headView);
        make.top.equalTo(reportStateTextView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    lineView2.backgroundColor = LineViewBackgroundColor;
    
    // 添加照片
    UILabel *addLab= [UILabel hyb_viewWithSuperView:headView constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(5);
        make.left.mas_offset(SMMargin);
        make.height.mas_equalTo(30);
    }];
    addLab.attributedText = [NSString addPhotoAttributStringWithString:@"添加照片（0/9）"];
    self.addLab = addLab;
    
    UIView *photoView =  [UIView hyb_viewWithSuperView:headView constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addLab.mas_bottom).offset(10);
        make.left.right.bottom.equalTo(headView);
    }];
    photoView.backgroundColor = [UIColor whiteColor];
    
    
    CGFloat photoNum = 4; // 每行几张照片
    CGFloat photoMargin = 15;  //  照片间的间距
    CGFloat photoWH = (S_Width - photoMargin * (photoNum + 1)) / photoNum;  // 每张照片的宽高
    CGFloat viewHeight = photoWH + 30;
    
    LPDQuoteImagesView *lpdView = [[LPDQuoteImagesView alloc] initWithFrame:CGRectMake(0, 0, S_Width, viewHeight) withCountPerRowInView:photoNum cellMargin:photoMargin];
    lpdView.navcDelegate = self;
    lpdView.maxSelectedCount = 9;
    [photoView addSubview:lpdView];
    [lpdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(photoView);
    }];
    self.lpdView = lpdView;
    
    NSInteger headViewHeight = headerPortionHegiht + viewHeight;
    headView.frame = CGRectMake(0, 0, S_Width, headViewHeight);
    self.headView = headView;
    self.contentTabGrouped.tableHeaderView = headView;

}

#pragma mark - LPDQuoteImagesView Delegate
//  添加照片或删除照片调用的方法
- (void)selectedPhotosCount:(NSInteger)count{
    CGFloat photoNum = 4; // 每行几张照片
    CGFloat photoMargin = 15;  //  照片间的间距
    CGFloat photoWH = (S_Width - photoMargin * (photoNum + 1)) / photoNum;  // 每张照片的宽高
    CGFloat viewHeight = photoWH + 30;
    if (count < 4) {
        self.lpdView.frame = CGRectMake(0, 0, S_Width, viewHeight);
        self.lpdView.collectionView.frame = CGRectMake(0, 0, S_Width, viewHeight);
        self.headView.frame = CGRectMake(0, 0, S_Width, headerPortionHegiht + viewHeight);
    }else if (count >= 4 && count < 8){
        self.lpdView.frame = CGRectMake(0, 0, S_Width, viewHeight * 2 - 15);
        self.lpdView.collectionView.frame = CGRectMake(0, 0, S_Width, viewHeight * 2 - 15);
        self.headView.frame = CGRectMake(0, 0, S_Width, headerPortionHegiht + viewHeight * 2 - 15);
    }else if (count >= 8){
        self.lpdView.frame = CGRectMake(0, 0, S_Width, viewHeight * 3 - 30);
        self.lpdView.collectionView.frame = CGRectMake(0, 0, S_Width, viewHeight * 3 - 30);
        self.headView.frame = CGRectMake(0, 0, S_Width, headerPortionHegiht + viewHeight * 3 - 30);
    }

    [self.contentTabGrouped setTableHeaderView:self.headView];
    self.addLab.attributedText = [NSString addPhotoAttributStringWithString:[NSString stringWithFormat:@"添加照片（%ld/9）", count]];
}

#pragma mark - UIGesture Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }else if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]){
        return NO;
    }
    return  YES;
}

#pragma mark - keyboard method
-(void)keyboardDismiss:(UITapGestureRecognizer *)tap
{
    [self.reportStateTextView resignFirstResponder];
    [self.textField resignFirstResponder];
}

#pragma mark - Text View Delegate
-(void)textViewDidChange:(UITextView *)textView
{
    self.pLabel.hidden = [textView.text length];
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text])
    {
        if ([self.reportStateTextView.text length]) {
            [self.reportStateTextView resignFirstResponder];
        }
        else
        {
            return NO;
        }
    }
    return YES;
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }else{
        return 150;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = ViewBackgroundColor;
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *postCellID = @"postCellId";
    UITableViewCell *postCell = [tableView dequeueReusableCellWithIdentifier:postCellID];
    if (!postCell) {
        postCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postCellID];
    }
    postCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
//        static NSString *firstCellID = @"postFirst";
//        UITableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:firstCellID];
//        if (!firstCell) {
//            firstCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellID];
//        }
        UILabel *anonymityLab = [UILabel hyb_labelWithText:@"匿名发布" font:16 superView:postCell.contentView constraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(SMMargin);
            make.centerY.equalTo(postCell.contentView.mas_centerY);
        }];
        
        UISwitch *anonymitySwitch = [UISwitch hyb_viewWithSuperView:postCell.contentView constraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-SMMargin);
            make.centerY.equalTo(postCell.contentView.mas_centerY);
            make.width.mas_equalTo(52);
            make.height.mas_equalTo(32);
        } onTaped:^(UITapGestureRecognizer *sender) {
            
        }];
        
//        return firstCell;
    }else{
        
//        static NSString *secondCellID = @"postSecond";
//        UITableViewCell *secondCell = [tableView dequeueReusableCellWithIdentifier:secondCellID];
//        if (!secondCell) {
//            secondCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellID];
//        }
        
        UIButton *publishBtn = [UIButton hyb_buttonWithSuperView:postCell.contentView constraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-SMMargin);
            make.top.mas_offset(35);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(40);
        } touchUp:^(UIButton *sender) {
            
        }];
        [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
        [publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [publishBtn setBackgroundColor:UIColorRed];
        [publishBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        publishBtn.layer.masksToBounds = YES;
        publishBtn.layer.cornerRadius = 6;
        
//        return secondCell;
    }
    return postCell;
    
}



@end
