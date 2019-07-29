//
//  PlayContactStepThreeViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PlayContactStepThreeViewController.h"

#import "AskStepThreeTableViewCell.h"
#import "AskStepThreeDetailInfomationTableViewCell.h"
#import "ChooseDaShiViewController.h"

@interface PlayContactStepThreeViewController ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
- (IBAction)clickNextStepButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, assign) BOOL chooseEightRow;
@property (nonatomic, strong) NSString *recordQuestion;

@property (nonatomic, strong) NSString *recordQID;

- (IBAction)clickRefreshButtonDone:(id)sender;

@end

@implementation PlayContactStepThreeViewController
- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[].mutableCopy;
    }
    return _titleArray;
}
- (void)viewDidLoad {
  
    [super viewDidLoad];
   
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    
    [self getData];
    
    
}
- (void)getData {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"cat_id"] = self.passCatId;
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Qa_Question Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
            self.titleArray = [CSParseManager getQuestionIdModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
            QuestionId *model = [QuestionId new];
            
            model.question_id = @"";
            model.title = @"自定义问题（限一个问题）";
            model.isEightRow = YES;
            model.choose = NO;
            model.isTextField = NO;
            [self.titleArray addObject:model];
            [self.tableView reloadData];
            
        }else {
            
            CSShowWrongMessage
            
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
   
}
- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(AskStepThreeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(AskStepThreeTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(AskStepThreeDetailInfomationTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(AskStepThreeDetailInfomationTableViewCell)];

}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    WhiteNavigationBarColor
    
    self.title = @"提问";
}

- (IBAction)clickNextStepButtonDone:(id)sender {
    [self.view endEditing:YES];
    if (self.chooseEightRow && csCharacterIsBlank(self.recordQuestion)) {
        CustomWrongMessage(@"请填写要提的问题");
        return;
    }
    BOOL goOn = NO;
    for (int i = 0; i < self.titleArray.count; i ++) {
        QuestionId *changeModel = self.titleArray[i];
        if (changeModel.choose) {
            goOn = YES;
            break;
        }
    }
    if (!goOn) {
        CustomWrongMessage(@"至少选择一个问题！");
        return;
    }
    
    [self performSegueWithIdentifier:@"ChooseDaShiViewController" sender:self];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        if (self.chooseEightRow) {
            return 1;
        }
        return 0;
    }
    return self.titleArray.count;;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        
        AskStepThreeDetailInfomationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(AskStepThreeDetailInfomationTableViewCell)];
        cell.inputTextView.delegate = self;
        cell.inputTextView.text = self.recordQuestion;
        return cell;
    }
    AskStepThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(AskStepThreeTableViewCell)];
    QuestionId *model = self.titleArray[indexPath.row];
    cell.model = model;
    return cell;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    self.recordQuestion = textView.text;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 0) {
        return;
    }
    QuestionId *model = self.titleArray[indexPath.row];
    
     model.choose = YES;
    self.recordQID = model.question_id;
    if (model.isEightRow) {
        self.chooseEightRow = YES;
    } else {
        self.chooseEightRow = NO;
    }
    for (int i = 0; i < self.titleArray.count; i ++) {
        QuestionId *changeModel = self.titleArray[i];
        if (i != indexPath.row) {
            changeModel.choose = NO;
        }
    }
    
    
      [self.tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 170;
    }
    return 52;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ChooseDaShiViewController"]) {
        ChooseDaShiViewController *new = segue.destinationViewController;
        new.passCat_id = self.passCatId;

        if (self.chooseEightRow) {
            new.personalQuestion = self.recordQuestion;
            
        } else {
            new.passQuestion_id = self.recordQID;
        }
    }
}
- (IBAction)clickRefreshButtonDone:(id)sender {
    
    [self getData];
}
@end
