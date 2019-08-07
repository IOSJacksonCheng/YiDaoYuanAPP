//
//  GoToJudgeViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/27.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "GoToJudgeViewController.h"


#import "GoToJudgePictureTableViewCell.h"
#import "GoToJudgeJudgeTextTableViewCell.h"
#import "GoToJudgeTitleTableViewCell.h"
#import "GoToJudgeXingXingTableViewCell.h"
#import "GoToJudgeJudgeModel.h"
@interface GoToJudgeViewController ()<UITableViewDelegate, UITableViewDataSource, GoToJudgeXingXingTableViewCellDelegate>
@property (nonatomic, strong) DaShiOrderInfoModel *infoModel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UITextView *judgeTextView;

@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, assign) CGFloat zixunziliangxing;
@property (nonatomic, assign) CGFloat fuwutaiduxing;
@property (nonatomic, assign) CGFloat huifusuduxing;
@end

@implementation GoToJudgeViewController
- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = @[].mutableCopy;
        GoToJudgeJudgeModel *new = [GoToJudgeJudgeModel new];
        [_listArray addObject:new];
    }
    return _listArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigationBar];
    [self configSubViews];

    [self getData];
}
- (void)clickLeftItem {
    if (self.fromChatView) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];

    }
}

- (void)configNavigationBar {
    
    self.title = @"评价详情";
    
    F3f3f3NavigationBarColor
    
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    UIButton *leftButton = [[UIButton alloc]init];
    [leftButton setImage:DotaImageName(@"icon_back") forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickLeftItem) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = backItem;
    
}
- (void)configSubViews {
    
    self.submitButton.layer.cornerRadius = 5;
    
    self.submitButton.layer.masksToBounds = YES;
    
    [self.submitButton addTarget:self action:@selector(clickSubmitButtonDone) forControlEvents:UIControlEventTouchDown];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(GoToJudgeXingXingTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(GoToJudgeXingXingTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(GoToJudgeJudgeTextTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(GoToJudgeJudgeTextTableViewCell)];

    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(GoToJudgeTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(GoToJudgeTitleTableViewCell)];

    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(GoToJudgePictureTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(GoToJudgePictureTableViewCell)];

    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
- (void)clickSubmitButtonDone {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"type"] = self.typestring;
    para[@"order_id"] = self.order_id;

    para[@"quality"] = [NSString stringWithFormat:@"%.1f",self.zixunziliangxing];
    para[@"serve"] = [NSString stringWithFormat:@"%.1f",self.fuwutaiduxing];
    para[@"reply"] = [NSString stringWithFormat:@"%.1f",self.huifusuduxing];
   
    para[@"content"] = self.judgeTextView.text;
    
    
    NSMutableArray *pArray = @[].mutableCopy;
    
    for (int i = 0; i < self.listArray.count; i ++) {
        
        GoToJudgeJudgeModel *model = self.listArray[i];
        
        if (!csCharacterIsBlank(model.path)) {
            [pArray addObject:model];
        }
        
    }
    for (int i = 0; i < pArray.count; i ++) {
        
        GoToJudgeJudgeModel *model = self.listArray[i];
        
        para[[NSString stringWithFormat:@"imgs[%d]",i]] = model.path;

    }

    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_portal_Index_evaluation Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            self.isDetail = YES;
            [self.tableView reloadData];
            self.submitButton.hidden = YES;
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
}
- (void)getData {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.order_id;
    para[@"type"] = self.typestring;

    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_master_master_skille Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.infoModel = [CSParseManager getSingleDaShiOrderInfoModellWithResponseObject:CSGetResult];
            
            self.isDetail = self.infoModel.haveJudged;
            self.submitButton.hidden = self.isDetail;
            if (self.isDetail) {
                [self getDetailInfomation];
            } else {
                [self.tableView reloadData];

            }
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)getDetailInfomation {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.order_id;
    para[@"type"] = self.typestring;

    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_index_order_evaluation Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.zixunziliangxing = [NSString stringWithFormat:@"%@",CSGetResult[@"quality"]].floatValue;
            self.fuwutaiduxing = [NSString stringWithFormat:@"%@",CSGetResult[@"serve"]].floatValue;

            self.huifusuduxing = [NSString stringWithFormat:@"%@",CSGetResult[@"reply"]].floatValue;

            self.judgeTextView.text = [NSString stringWithFormat:@"%@",CSGetResult[@"content"]];
            NSArray *array = CSGetResult[@"imgs"];
            NSMutableArray *newArray = @[].mutableCopy;
            for (NSString *image in array) {
                GoToJudgeJudgeModel *model = [GoToJudgeJudgeModel new];
                model.url = image;
                [newArray addObject:model];
            }
            self.listArray = newArray;
            [self.tableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        GoToJudgeTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(GoToJudgeTitleTableViewCell) forIndexPath:indexPath];
        cell.model = self.infoModel;
        return cell;
    }
    if (indexPath.row == 4) {
        GoToJudgeJudgeTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(GoToJudgeJudgeTextTableViewCell) forIndexPath:indexPath];
        self.judgeTextView = cell.inputTextView;
        self.judgeTextView.editable = !self.isDetail;
        return cell;
    }
    if (indexPath.row == 5) {
        GoToJudgePictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(GoToJudgePictureTableViewCell) forIndexPath:indexPath];
        cell.listArray = self.listArray;
        cell.showTitleView = !self.isDetail;
        return cell;
    }
    
    GoToJudgeXingXingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(GoToJudgeXingXingTableViewCell)];
    cell.isjustDisplay = self.isDetail;
    cell.simpledelegate = self;
    cell.index = indexPath.row;
    if (indexPath.row == 1) {
        cell.csTitleLabel.text = @"咨询质量：";
        cell.fenshuLabel.text = [NSString stringWithFormat:@"%.1f",self.fuwutaiduxing];
        cell.xinxinshu = self.zixunziliangxing;
    } else if (indexPath.row == 2) {
       
        cell.csTitleLabel.text = @"服务态度：";
        cell.xinxinshu = self.fuwutaiduxing;

        cell.fenshuLabel.text = [NSString stringWithFormat:@"%.1f",self.fuwutaiduxing];
        
    }else if (indexPath.row == 3) {
        cell.xinxinshu = self.huifusuduxing;

        cell.csTitleLabel.text = @"回复速度：";
        
        cell.fenshuLabel.text = [NSString stringWithFormat:@"%.1f",self.huifusuduxing];
        
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 67;
    }
    if (indexPath.row == 4) {
       return 200;
    }
    if (indexPath.row == 5) {
//        return (MainScreenWidth - 10 * 2 - 5 * 2) / 3;
    
        return 400;
    }
    return 44;
}
- (void)passFenshuWithRow:(NSInteger)row WithFenshu:(CGFloat)fenshu {
    if (row == 1) {
        self.zixunziliangxing = fenshu;
        
    } else if (row == 2){
        self.fuwutaiduxing = fenshu;
    }else {
        self.huifusuduxing = fenshu;
    }
}
@end
