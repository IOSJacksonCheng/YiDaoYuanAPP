//
//  RightNowConsultViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/28.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "RightNowConsultViewController.h"
//356.5
#import "RightNowConsultTableViewCell.h"
#import "RightNowConsultIntroduceTableViewCell.h"
//54
#import "ZJZXMoreTableViewCell.h"

#import "RightNowConsultModel.h"

#import "DaShiListViewController.h"
@interface RightNowConsultViewController ()<UITableViewDelegate, UITableViewDataSource, RightNowConsultTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;
- (IBAction)clickJumpButtonDone:(id)sender;

- (IBAction)clickChooseButtonDone:(id)sender;
@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, strong) RightNowConsultModel *supModel;
@property (nonatomic, strong) RightNowConsultModel *subModel;
@end

@implementation RightNowConsultViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    self.listArray = @[].mutableCopy;
    BOOL jump = [[NSUserDefaults standardUserDefaults] boolForKey:@"jump"];
    self.jumpButton.selected = jump;
    [self getData];
    
}
- (void)getData {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_portal_Consult_Category Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.listArray = [CSParseManager getRightNowConsultModelArrayWithResponseObject:CSGetResult[@"lists"]];
            if (self.listArray.count != 0) {
                self.supModel = self.listArray[0];
                if (self.supModel.items.count != 0) {
                    self.subModel = self.supModel.items[0];
                }
            }
            [self.listTableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(RightNowConsultTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(RightNowConsultTableViewCell)];
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(RightNowConsultIntroduceTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(RightNowConsultIntroduceTableViewCell)];
    
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXMoreTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXMoreTableViewCell)];
   
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    F3f3f3NavigationBarColor
    
    self.title = @"即时咨询";
}

- (IBAction)clickJumpButtonDone:(id)sender {
    
    self.jumpButton.selected = !self.jumpButton.selected;
    
    [[NSUserDefaults standardUserDefaults] setBool:self.jumpButton.selected forKey:@"jump"];
    
}

- (IBAction)clickChooseButtonDone:(id)sender {
    [self performSegueWithIdentifier:@"DaShiListViewController" sender:self];
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (void)passCurrentSection:(NSInteger)section WithRow:(NSInteger)row {
    self.supModel = self.listArray[section];
    
    self.subModel = self.supModel.items[row];
    
    [self.listTableView reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        RightNowConsultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(RightNowConsultTableViewCell)];
        cell.itemArray = self.listArray;
        cell.csDelegate = self;
        return cell;
    } else if (indexPath.row == 1) {
         ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
        cell.moreTitleLabel.hidden = YES;
        cell.csTitleLabel.text = self.subModel.subTitle;
        
        return cell;
    }else if (indexPath.row == 2) {
        RightNowConsultIntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(RightNowConsultIntroduceTableViewCell)];
        cell.csTitleLabel.text = self.subModel.intro;
        return cell;
    }else if (indexPath.row == 3) {
        ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
        cell.moreTitleLabel.hidden = YES;
        cell.csTitleLabel.text = @"说明";
        
        return cell;
    }
        RightNowConsultIntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(RightNowConsultIntroduceTableViewCell)];
    cell.csTitleLabel.text = self.subModel.explain;

        return cell;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSInteger row = indexPath.row;
    
        if (row == 0) {
            
            return 330;
        } else if (row == 2 ) {
            
            
            return [self accrodingTextGiveItHeightWith:self.subModel.intro] + 20;
        }else if (row == 4) {
            
            
            return [self accrodingTextGiveItHeightWith:self.subModel.explain] + 20;
        }
        return 54;
   
}
- (CGFloat)accrodingTextGiveItHeightWith:(NSString *)text {
    
    if (csCharacterIsBlank(text)) {
        return 0;
    }
    
    CGFloat labelWidth = MainScreenWidth - 27;
    
    NSAttributedString *test = [self attributedBodyText:text];
    
    NSStringDrawingOptions options  = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    CGRect rect = [test boundingRectWithSize:CGSizeMake(labelWidth, 0) options:options context:nil];
    
    
    return (CGFloat)(ceil(rect.size.height));
    
}
- (NSAttributedString *)attributedBodyText:(NSString *)text {
    
    
    UIFont *font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12];
    
    NSDictionary *testDic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:text attributes:testDic];
    
    return string;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DaShiListViewController"]) {
        DaShiListViewController *new = segue.destinationViewController;
        new.passId = self.subModel.item_id;
        new.adImage = self.subModel.ad;
        new.noFee = NO;
    }
}
@end
