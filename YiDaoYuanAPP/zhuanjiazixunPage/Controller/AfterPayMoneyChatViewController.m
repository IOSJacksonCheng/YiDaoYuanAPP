//
//  AfterPayMoneyChatViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/30.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "AfterPayMoneyChatViewController.h"

#import "CSChatCell.h"

@interface AfterPayMoneyChatViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (nonatomic, strong) NSMutableArray *messageArray;
@property (weak, nonatomic) IBOutlet UIButton *guanzhuButton;
@property (weak, nonatomic) IBOutlet UIView *dashiIntroduceView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dashiIntroduceViewHeightConstraint;
@end

@implementation AfterPayMoneyChatViewController
- (NSMutableArray *)messageArray {
    if (!_messageArray) {
        _messageArray = @[].mutableCopy;
        ChatModel *model = [ChatModel new];
        
        model.left = YES;
        model.contentString = @"你好，请把生辰八字发一下";
        model.imageString = @"img_dashi";
       
        
        ChatModel *model1 = [ChatModel new];

        model1.left = NO;
        model1.contentString = @"我的生辰八字是";
        model1.imageString = @"img_user";
        
        ChatModel *model2 = [ChatModel new];
        model2.messageType = CSMessageJudgeType;
        model2.imageString = @"img_dashi";
        model2.left = YES;
        
        [_messageArray addObject:model];
        [_messageArray addObject:model1];

        [_messageArray addObject:model];

        [_messageArray addObject:model1];
        
         [_messageArray addObject:model2];

    }
    return _messageArray;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self.chatTableView reloadData];
}

- (void)configTableView {
    self.chatTableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [self.chatTableView registerNib:[UINib nibWithNibName:CSCellName(ChatLeftTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ChatLeftTableViewCell)];
    [self.chatTableView registerNib:[UINib nibWithNibName:CSCellName(ChatRightTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ChatRightTableViewCell)];
    
     [self.chatTableView registerNib:[UINib nibWithNibName:CSCellName(ChatJudgeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ChatJudgeTableViewCell)];
    self.chatTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}
- (void)configSubViews {
    if (!self.showTopView) {
        self.dashiIntroduceViewHeightConstraint.constant = 0;
        self.dashiIntroduceView.hidden = YES;
    } else {
        self.guanzhuButton.layer.cornerRadius = 5;
        self.guanzhuButton.layer.borderColor = [UIColor colorWithHexString:@"FFCB3F"].CGColor;
        self.guanzhuButton.layer.borderWidth = 1;
    }
    
}
- (void)configNavigationBar {
    WhiteNavigationBarColor
    
    self.title = @"大师姓名";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    ChatModel *model = self.messageArray[indexPath.row];
    
    if (model.messageType == CSMessageJudgeType) {
        ChatJudgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ChatJudgeTableViewCell)];
        
        return cell;
    }
    
    if (model.left) {
        ChatLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ChatLeftTableViewCell)];
        
        cell.model = model;
        return cell;

    }
    ChatRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ChatRightTableViewCell)];
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     ChatModel *model = self.messageArray[indexPath.row];
    if (model.messageType == CSMessageJudgeType) {
        [self performSegueWithIdentifier:@"AfterChatJudgeViewController" sender:self];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChatModel *model = self.messageArray[indexPath.row];
    if (model.messageType == CSMessageJudgeType) {
        return 164.5;
    }
    return [self accrodingTextGiveItHeightWith:model.contentString];
}
- (CGFloat)accrodingTextGiveItHeightWith:(NSString *)text {
    
    
    
    if ([CSUtility characterIsBlankString:text]) {
        
        return 60;
        
    }
    CGFloat labelWidth = MainScreenWidth - 10 - 15 - 100 - 13 - 11 - 43;
    
    NSAttributedString *test = [self attributedBodyText:text];
    
    NSStringDrawingOptions options  = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    CGRect rect = [test boundingRectWithSize:CGSizeMake(labelWidth, 0) options:options context:nil];
    
    CGFloat backHeight = (CGFloat)(ceil(rect.size.height) + 40);
    
    if (backHeight < 60) {
        return 60;
    }
    
    return backHeight;
    
}
- (NSAttributedString *)attributedBodyText:(NSString *)text {
    
    
    UIFont *font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    
    NSDictionary *testDic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:text attributes:testDic];
    
    return string;
}
@end
