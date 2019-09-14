//
//  YiDaoKeTangDetailViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoKeTangDetailViewController.h"

#import "ZJZXMoreTableViewCell.h"
#import "YiDaoKeTangDetailDaShiTableViewCell.h"
#import "YiDaoKeTangDetailButtonTableViewCell.h"
#import "YiDaoKeTangDetailIntroduceTableViewCell.h"
#import "YiDaoKeTangDetailJudgeTableViewCell.h"
#import "KeTangShiPingTitleTableViewCell.h"


#import "DaShiDetailViewController.h"

#import "PPStickerInputView.h"
#import "PPUtil.h"

#import "ShopSureOrderPayMoneyWayViewController.h"

#import <AVKit/AVKit.h>

#import "YiDaoKeTangContentViewController.h"
#import "CSShareView.h"
@interface YiDaoKeTangDetailViewController ()<UITableViewDelegate, UITableViewDataSource, YiDaoKeTangDetailButtonTableViewCellDelegate, PPStickerInputViewDelegate, ShopSureOrderPayMoneyWayViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (nonatomic, strong) NSString *freeButtonString;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL clickIntroduce;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *csInputView;
@property (nonatomic, strong) PPStickerInputView *inputView;
@property (weak, nonatomic) IBOutlet UIImageView *shipingImageView;
- (IBAction)clickPlayVideoButtonDone:(id)sender;

@property (nonatomic, strong) NSString *csTitleLabelString;

@property (nonatomic, strong) NSString *introduceLabelString;
@property (nonatomic, strong) NSString *dashiNameLabelString;
@property (nonatomic, strong) NSString *xuexiLabelString;

@property (nonatomic, assign) BOOL is_pay;

@property (nonatomic, assign) BOOL is_free;

@property (nonatomic, strong) NSString *masterIcon;
@property (nonatomic, strong) NSString *masterName;
@property (nonatomic, strong) NSString *masterIntro;

@property (nonatomic, strong) NSString *ketangIntroduce;

@property (nonatomic, strong) NSMutableArray *videoArray;

@property (nonatomic, assign) NSInteger currentVideoIndex;

@property (nonatomic, strong) NSString *shipingImage;

@property (nonatomic, assign) int page;

@property (nonatomic, strong) NSString *totalRecord;

@property (nonatomic, strong) NSMutableArray *judgeArray;

@property (nonatomic, strong) NSString *currentVideoURL;


@property (weak, nonatomic) IBOutlet UIButton *sendButton;
- (IBAction)clickSendMessageButtonDone:(id)sender;
@property (nonatomic, strong) CSShareView *shareView;

@property (nonatomic, strong) NSString *master_id;
@end

@implementation YiDaoKeTangDetailViewController
- (CSShareView *)shareView {
    if (!_shareView) {
        _shareView = [[CSShareView alloc] initWithFrame:self.view.bounds WithDelegate:self WithTitle:@"易道源" WithDescription:@"算命App" WithImage:DotaImageName(@"AppIcon") WithUrl:@"www.baidu.com"];
    }
    return _shareView;
}
- (NSMutableArray *)judgeArray {
    if (!_judgeArray) {
        _judgeArray = @[].mutableCopy;
    }
    return _judgeArray;
}
- (PPStickerInputView *)inputView
{
    if (!_inputView) {
        _inputView = [[PPStickerInputView alloc] init];
        _inputView.delegate = self;
    }
    return _inputView;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configNavigationBar];
    CGFloat height = [self.inputView heightThatFits];
    CGFloat minY = CGRectGetHeight(self.view.bounds) - height - PP_SAFEAREAINSETS(self.view).bottom;
    self.inputView.frame = CGRectMake(0, minY, CGRectGetWidth(self.view.bounds), height);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    [self clickIntroduceButtonDone];

    [self sendGetRequest];
    
    [self getZuiChuData];
}
- (void)getZuiChuData {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"id"] = self.passId;
    self.page = 1;
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Evaluatelists Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        
        if (CSInternetRequestSuccessful) {
            self.totalRecord = [NSString stringWithFormat:@"%@",CSGetResult[@"total"]];;
            self.judgeArray = [CSParseManager getYiDaoKeTangJudgeModelArrayWithResponseObject:CSGetResult[@"lists"]];
            [self.tableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        
        CSInternetFailure
    }];
}
- (void)getJudgeRequest {
    if (self.clickIntroduce) {
        [self endRefresh];
        return;
    }
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"id"] = self.passId;
    self.page = 1;
     para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Evaluatelists Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];

        if (CSInternetRequestSuccessful) {
            self.totalRecord = [NSString stringWithFormat:@"%@",CSGetResult[@"total"]];;
            self.judgeArray = [CSParseManager getYiDaoKeTangJudgeModelArrayWithResponseObject:CSGetResult[@"lists"]];
            [self.tableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];

        CSInternetFailure
    }];
}
- (void)getJudgeRequestMore {
    if (self.clickIntroduce) {
        [self endRefresh];
        return;
    }
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"id"] = self.passId;
    self.page += 1;
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Evaluatelists Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];

        if (CSInternetRequestSuccessful) {
            
            NSMutableArray *array = [CSParseManager getYiDaoKeTangJudgeModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了");
            } else {
                
                [self.judgeArray addObjectsFromArray:array];
                
                [self.tableView reloadData];
            }
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        CSInternetFailure
    }];
}
- (void)endRefresh {
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}
- (void)sendGetRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"id"] = self.passId;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Course_Info Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
            [self configData:CSGetResult];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configData:(id)result {
    
    self.title = [NSString stringWithFormat:@"%@",result[@"title"]];
    
    self.master_id = [NSString stringWithFormat:@"%@",result[@"master_id"]];
    
    self.csTitleLabelString = [NSString stringWithFormat:@"%@",result[@"title"]];
    
    self.introduceLabelString = [NSString stringWithFormat:@"%@",result[@"intro"]];
    
    self.dashiNameLabelString = [NSString stringWithFormat:@"%@",result[@"master"]];
    
    self.xuexiLabelString = [NSString stringWithFormat:@"%@人学习",result[@"apply"]];
    
    NSString *fee = [NSString stringWithFormat:@"%@",result[@"fee"]];
    
    if (fee.floatValue == 0) {
        fee = @"免费";
        self.is_free = YES;
    } else {
        
        fee = [NSString stringWithFormat:@"%.1f元",fee.floatValue];
        
        self.is_free = NO;
    }
    NSNumber *ispay = result[@"is_pay"];
    
    if ([ispay isEqualToNumber:@1]) {
        self.is_pay = YES;
    } else {
        self.is_pay = NO;
    }
    
    self.freeButtonString = fee;
    
    self.shipingImage = [NSString stringWithFormat:@"%@",result[@"img"]];
    
    [self.shipingImageView sd_setImageWithURL:[NSURL URLWithString:self.shipingImage] placeholderImage:PlaceHolderImage];
    
    self.masterIcon = [NSString stringWithFormat:@"%@",result[@"master_avatar"]];
    
    self.masterName = [NSString stringWithFormat:@"%@",result[@"master"]];
    
    self.masterIntro = [NSString stringWithFormat:@"%@",result[@"master_intro"]];
   
    
    self.ketangIntroduce = [NSString stringWithFormat:@"%@",result[@"introduce"]];
    
    if (csCharacterIsBlank(self.ketangIntroduce)) {
        self.ketangIntroduce = @"";
    }
    
    self.videoArray = result[@"goods"];
    
    if (self.videoArray.count != 0) {
        self.currentVideoURL = [NSString stringWithFormat:@"%@",self.videoArray[0][@"v"]];
    }
    
    self.currentVideoIndex = 1;
    [self.tableView reloadData];
}

- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getJudgeRequest)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getJudgeRequestMore)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(KeTangShiPingTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(KeTangShiPingTitleTableViewCell)];

    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXMoreTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXMoreTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(YiDaoKeTangDetailDaShiTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(YiDaoKeTangDetailDaShiTableViewCell)];
       [self.tableView registerNib:[UINib nibWithNibName:CSCellName(YiDaoKeTangDetailButtonTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(YiDaoKeTangDetailButtonTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(YiDaoKeTangDetailIntroduceTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(YiDaoKeTangDetailIntroduceTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(YiDaoKeTangDetailJudgeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(YiDaoKeTangDetailJudgeTableViewCell)];
    
}
- (void)configSubViews {
    
    
    self.inputTextField.layer.cornerRadius = 18;
    self.inputTextField.layer.masksToBounds = YES;
    
    self.totalRecord = @"0";
//    [self.view addSubview:self.inputView];

}
- (void)configNavigationBar {
    
    BlueNavigationBarColor
    
    UIColor *whiteColor = [UIColor colorWithHexString:@"FFFFFF"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    UIButton *rightButton = [[UIButton alloc] init];
    
    [rightButton setImage:DotaImageName(@"icon_share-1") forState:UIControlStateNormal];
    
    
    [rightButton addTarget:self action:@selector(clickShareButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"img_back") forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickBackDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)clickBackDone {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickShareButtonDone {
    
    [self.view addSubview:self.shareView];

    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    if (self.clickIntroduce) {
        return 1;
    }
    return self.judgeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            
            KeTangShiPingTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(KeTangShiPingTitleTableViewCell)];
            cell.ketangTitleLabel.text = self.csTitleLabelString;
            cell.ketangDetailLabel.text = self.introduceLabelString;
            cell.nameLabel.text = self.dashiNameLabelString;
            cell.xuexirenshuLabel.text = self.xuexiLabelString;
            [cell.freeButton setTitle:self.freeButtonString forState:UIControlStateNormal];
            [cell.freeButton addTarget:self action:@selector(clickFreeButtonDone) forControlEvents:UIControlEventTouchDown];
            return cell;
            
        }else if (indexPath.row == 1) {
            ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
            cell.csTitleLabel.text = @"专题目录";
            
            cell.moreTitleLabel.text = [NSString stringWithFormat:@"第%ld课时/共%lu课时 >", (long)self.currentVideoIndex,(unsigned long)self.videoArray.count];
            return cell;
        } else if (indexPath.row == 2) {
            YiDaoKeTangDetailDaShiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoKeTangDetailDaShiTableViewCell)];
            cell.dashiNameLabel.text = self.masterName;
            cell.dashiJieSaoLabel.text = self.masterIntro;
            [cell.csImageView sd_setImageWithURL:[NSURL URLWithString:self.masterIcon] placeholderImage:CSUserImagePlaceHolder];
            return cell;
        }
        
        YiDaoKeTangDetailButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoKeTangDetailButtonTableViewCell)];
        cell.csDelegate = self;
        [cell.pinglunLabel setTitle:[NSString stringWithFormat:@"评论(%@)",self.totalRecord] forState:UIControlStateNormal];
        return cell;
    }
    
    if (self.clickIntroduce) {
        YiDaoKeTangDetailIntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoKeTangDetailIntroduceTableViewCell)];
        
        
        [cell.ketangImageView sd_setImageWithURL:[NSURL URLWithString:self.shipingImage] placeholderImage:PlaceHolderImage];
        
        cell.introLabel.text = self.ketangIntroduce;
        
        return cell;
    }
   
    //judge cell
    YiDaoKeTangDetailJudgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoKeTangDetailJudgeTableViewCell)];
    
    cell.model = self.judgeArray[indexPath.row];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        for (int i = 0; i < self.videoArray.count; i++) {
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"第%@课时",self.videoArray[i][@"i"]] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 self.currentVideoURL = [NSString stringWithFormat:@"%@",self.videoArray[0][@"v"]];
                self.currentVideoIndex = i + 1;
                
                [self.tableView reloadData];
            }];
            [alert addAction:action];
            
        }
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        //3.将按钮添加到AlertController中
        
        [alert addAction:cancelAction];
        
        //5.显示AlertController
        [self presentViewController:alert animated:YES completion:nil];
    } else   if (self.clickIntroduce && indexPath.section == 1) {
        [self performSegueWithIdentifier:@"YiDaoKeTangContentViewController" sender:self];
    }else if (indexPath.section == 0 && indexPath.row == 2) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        
            DaShiDetailViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"DaShiDetailViewController"];
            new.passMasterID = self.master_id;
            [self.navigationController pushViewController:new animated:YES];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 20 + 10 + 89 + [CSUtility accrodingTextGiveItHeightWith:self.ketangIntroduce WithLabelInterval:11 * 2 WithFont:15];
        }
        if (indexPath.row == 1) {
           return 54;
        } else if (indexPath.row == 2) {
            return 116.5 ;
        }
        return 56;
    }
    if (self.clickIntroduce) {
        return 245;
    }
    JudgeModel *model = self.judgeArray[indexPath.row];
    
    if (csCharacterIsBlank(model.content)) {
        return 92;
    }
    
    if (csCharacterIsBlank(model.reply.content)) {
        return 82 + [self accrodingTextGiveItHeightWith:model.content];
    }
    
    
    return 82 + [self accrodingTextGiveItHeightWith:model.content] + [self accrodingDashiTextGiveItHeightWith:model.reply.content];
}
- (CGFloat)accrodingDashiTextGiveItHeightWith:(NSString *)text {
    
    
    
    CGFloat labelWidth = self.tableView.bounds.size.width  - 103 - 9 - 10;
    
    NSAttributedString *test = [self attributedBodyText:text];
    
    NSStringDrawingOptions options  = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    CGRect rect = [test boundingRectWithSize:CGSizeMake(labelWidth, 0) options:options context:nil];
    
    
    return (CGFloat)(ceil(rect.size.height) + 16 + 11);
    
}
- (CGFloat)accrodingTextGiveItHeightWith:(NSString *)text {
    
    

    CGFloat labelWidth = self.tableView.bounds.size.width  - 103 - 26;
    
    NSAttributedString *test = [self attributedBodyText:text];
    
    NSStringDrawingOptions options  = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    CGRect rect = [test boundingRectWithSize:CGSizeMake(labelWidth, 0) options:options context:nil];
    
    
    return (CGFloat)(ceil(rect.size.height) + 20);
    
}
- (NSAttributedString *)attributedBodyText:(NSString *)text {
    
    
    UIFont *font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:15];
    
    NSDictionary *testDic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:text attributes:testDic];
    
    return string;
}
#pragma mark YiDaoKeTangDetailButtonTableViewCellDelegate
- (void)clickJudgeButtonDone {
    self.clickIntroduce = NO;
    self.csInputView.hidden = NO;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
     self.inputViewHeightConstraint.constant = 50;
}
- (void)clickIntroduceButtonDone {
    self.clickIntroduce = YES;
     self.csInputView.hidden = YES;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    self.inputViewHeightConstraint.constant = 0;
}
#pragma mark - PPStickerInputViewDelegate

- (void)stickerInputViewDidClickSendButton:(PPStickerInputView *)inputView
{
    NSString *plainText = inputView.plainText;
    if (!plainText.length) {
        return;
    }
    
    
    [inputView clearText];
    
    [self.tableView reloadData];
}
- (IBAction)clickPlayVideoButtonDone:(id)sender {
    
    if (!self.is_free && !self.is_pay) {
        CustomWrongMessage(@"请先购买该视频才能观看");
        return;
    }
    
    NSString *webVideoPath = self.currentVideoURL;
    NSURL *webVideoUrl = [NSURL URLWithString:webVideoPath];
    //步骤2：创建AVPlayer
    AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:webVideoUrl];
    //步骤3：使用AVPlayer创建AVPlayerViewController，并跳转播放界面
    AVPlayerViewController *avPlayerVC =[[AVPlayerViewController alloc] init];
    
    avPlayerVC.player = avPlayer;
    
    [self presentViewController:avPlayerVC animated:YES completion:nil];
}
- (void)clickFreeButtonDone {
    
    if (self.is_pay) {
        CustomWrongMessage(@"您已经支付过该课程所需费用了");
        return;
    }
    if (self.is_free) {
        CustomWrongMessage(@"该课程为免费课程");
        return;
    }
    
    
     UIStoryboard *shopping = [UIStoryboard storyboardWithName:@"shopping" bundle:nil];
    
    ShopSureOrderPayMoneyWayViewController *new = [shopping instantiateViewControllerWithIdentifier:@"ShopSureOrderPayMoneyWayViewController"];
    new.passVideoId = self.passId;
    new.csDelegate = self;
    [self.navigationController pushViewController:new animated:YES];
    
    
    
}
- (void)successGoBack {
    CustomWrongMessage(@"支付成功！");
    [self sendGetRequest];
}
- (IBAction)clickSendMessageButtonDone:(id)sender {
    [self.view endEditing:YES];
    if (csCharacterIsBlank(self.inputTextField.text)) {
        CustomWrongMessage(@"请输入您要评价的内容");
        return;
    }
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"content"] = self.inputTextField.text;
    para[@"id"] = self.passId;

    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Portal_Course_Evaluate Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"评价发送成功");
            [self getJudgeRequest];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:CSCellName(YiDaoKeTangContentViewController)]) {
        YiDaoKeTangContentViewController *new = segue.destinationViewController;
        
        new.passUrl = [NSString stringWithFormat:@"%@%@&&id=%@", BASE_URL,CSURL_Portal_Site_course_detail,self.passId];
        new.showBottomView = YES;
        new.passTitle = @"视频详情";
        new.idstring = self.passId;
    }
}
@end
