//
//  QiFUViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "QiFUViewController.h"
#import "AddXiangViewController.h"

#import "QingFoViewController.h"


#import "QiFUModel.h"

#import "QiFuBottomCollectionViewCell.h"
#import "GongPingModel.h"
#import "XuYuanMingDengViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface QiFUViewController ()<UICollectionViewDelegate ,UICollectionViewDataSource, AVAudioPlayerDelegate>

- (IBAction)qiYuanJiLuButtonDone:(id)sender;
@property (nonatomic, strong) NSString *passString;

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UILabel *leftViewLabel;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UILabel *rightViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftSubTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLabel;
@property (nonatomic, assign) BOOL currentClickShenXian;

@property (weak, nonatomic) IBOutlet UIImageView *animationImageView;
- (IBAction)clickDaoCaiButtonDone:(id)sender;


@property (nonatomic, assign) NSInteger recordBottomTag;


@property (weak, nonatomic) IBOutlet UIButton *caiButton;


@property (nonatomic, strong) NSMutableArray *allFoListArray;

@property (weak, nonatomic) IBOutlet UIImageView *centerBigFoImageView;



@property (weak, nonatomic) IBOutlet UIImageView *dengimageView;


@property (weak, nonatomic) IBOutlet UIImageView *leftHuaPingImageView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIImageView *rightHuaPingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *leftFruitImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightLingShiImageView;
@property (weak, nonatomic) IBOutlet UIImageView *xiangluImageView;

@property (nonatomic, assign) NSInteger recordCurrentClickIndex;
//当前顺序
@property (nonatomic, strong) NSMutableArray *orderArray;

@property (nonatomic, strong) NSString *recordCatId;

@property (nonatomic, strong) NSString *recordMusicUrl;
@end

static AVAudioPlayer *_audioPlayer=nil;
NSString * const MusicPlayKey = @"MusciisPlayOrNot";
@implementation QiFUViewController
- (NSMutableArray *)allFoListArray {
    if (!_allFoListArray) {
        _allFoListArray = @[].mutableCopy;
    }
    return _allFoListArray;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self configNavigationBar];
    [self sendGetRequest];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configNavigationBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.orderArray = @[].mutableCopy;
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self clickLeftView];
    
    [self sendGetRequestForOrder];
    
   
    [self downloadMusic];
}
- (void)downloadMusic:(NSString *)url {
    [CSNetManager downloadFileWithUrl:url success:^(id  _Nonnull responseObject) {
        
        self.recordMusicUrl = responseObject;
        BOOL play = [[NSUserDefaults standardUserDefaults] boolForKey:MusicPlayKey];
        if (play) {
            [self playVoiceWithContentWithPath:responseObject];

        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)downloadMusic {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_portal_consecrate_bgmusic Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
          [self downloadMusic:[NSString stringWithFormat:@"%@",CSGetResult[@"url"]]]  ;
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
   
}
- (void)sendGetRequestForOrder {
    
    NSMutableDictionary *para = @{}.mutableCopy;
   
    [CSNetManager sendGetRequestWithNeedToken:NO Url:CSURL_Portal_Consecrate_Category Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
            self.orderArray = [CSParseManager getGongPingModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
            [self sendGetRequest];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)sendGetRequest {
    
    
    
    NSMutableDictionary *para = @{}.mutableCopy;
    if (self.currentClickShenXian) {
        para[@"type_id"] = @"1";
    } else {
        para[@"type_id"] = @"2";
    }
    [CSNetManager sendGetRequestWithNeedToken:NO Url:CSURL_Portal_Consecrate_Being Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.allFoListArray = [CSParseManager getQiFUModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
            [self reloadCurrentView];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}

- (void)configTableView {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRightView)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.rightView addGestureRecognizer:tap];
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //创建UICollectionView
    self.collectionView.collectionViewLayout = layout;
    
    //设置位置和尺寸
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //注册cell的ID
    [self.collectionView registerNib:[UINib nibWithNibName:CSCellName(QiFuBottomCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(QiFuBottomCollectionViewCell)];
}

- (void)configSubViews {
    
    self.recordCurrentClickIndex = 1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLeftView)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.leftView addGestureRecognizer:tap];
    
    
    NSMutableArray *allImage = @[].mutableCopy;
    
    for (int i = 1; i < 8; i ++) {
        
        NSString *rightCellName = [NSString stringWithFormat:@"daocai%d",i];
        
        UIImage *image = DotaImageName(rightCellName);
        
        [allImage addObject:image];
        
    }
    
    [self.animationImageView setAnimationImages:allImage];
    
    self.animationImageView.animationRepeatCount = 1;
    self.animationImageView.animationDuration = 1;
    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMingDengXuYuan)];
    tap1.numberOfTapsRequired = 1;
    tap1.numberOfTouchesRequired = 1;
    
    [self.dengimageView addGestureRecognizer:tap1];
    
    
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickQingShengButtonDone)];
    tap2.numberOfTapsRequired = 1;
    tap2.numberOfTouchesRequired = 1;
    
    [self.centerBigFoImageView addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickXianHuaButtonDone)];
    tap3.numberOfTapsRequired = 1;
    tap3.numberOfTouchesRequired = 1;
    
    [self.leftHuaPingImageView addGestureRecognizer:tap3];
    
    
    UITapGestureRecognizer *tap31 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickXianHuaButtonDone)];
    tap31.numberOfTapsRequired = 1;
    tap31.numberOfTouchesRequired = 1;
    [self.rightHuaPingImageView addGestureRecognizer:tap31];

    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickXianGuoButtonDone)];
    tap4.numberOfTapsRequired = 1;
    tap4.numberOfTouchesRequired = 1;
    
    [self.leftFruitImageView addGestureRecognizer:tap4];
    
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickJingShiButtonDone)];
    tap5.numberOfTapsRequired = 1;
    tap5.numberOfTouchesRequired = 1;
    
    [self.rightLingShiImageView addGestureRecognizer:tap5];
    
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickXiangButtonDone)];
    tap6.numberOfTapsRequired = 1;
    tap6.numberOfTouchesRequired = 1;
    
    [self.xiangluImageView addGestureRecognizer:tap6];
    
}
- (void)clickMingDengXuYuan {
    
    if (csCharacterIsBlank([self getCurrentQiFuModel].buddha_id)) {
        CustomWrongMessage(@"请先供奉");
    }
     [self performSegueWithIdentifier:@"XuYuanMingDengViewController" sender:self];
    
}
- (QiFUModel *)getCurrentQiFuModel {
    if ((self.recordCurrentClickIndex == 1 && self.allFoListArray.count == 0) || (self.allFoListArray.count == 1 && self.recordCurrentClickIndex == 2) || (self.allFoListArray.count == 2 && self.recordCurrentClickIndex == 3)) {
        
        
        return [QiFUModel new];
        
    }
    
    return self.allFoListArray[self.recordCurrentClickIndex - 1];
}
- (void)clickLeftView {
    
    self.currentClickShenXian = NO;
    
    [self changeTitleLabelWithShenXian:self.currentClickShenXian];
    [self sendGetRequest];
}
- (void)changeTitleLabelWithShenXian:(BOOL)shenxian {
    if (shenxian) {
        self.rightViewLabel.textColor = [UIColor colorWithHexString:@"#CC211D"];
        self.leftViewLabel.textColor = cs333333Color;
        self.leftTitleLabel.textColor = [UIColor colorWithHexString:@"#FCD65F"];
        self.leftSubTitleLabel.textColor = [UIColor colorWithHexString:@"#FEEBAF"];
        self.rightTitleLabel.textColor = [UIColor colorWithHexString:@"#FCD65F"];
        self.leftTitleLabel.text = @"燃\n香\n时\n长";
        self.leftSubTitleLabel.text = @"0H";
    } else {
        self.leftViewLabel.textColor = [UIColor colorWithHexString:@"#CC211D"];
        self.rightViewLabel.textColor = cs333333Color;
        
        self.leftTitleLabel.textColor = [UIColor colorWithHexString:@"#FCD65F"];
        self.leftSubTitleLabel.textColor = [UIColor colorWithHexString:@"#FEEBAF"];
        self.rightTitleLabel.textColor = [UIColor colorWithHexString:@"#FCD65F"];
        self.leftTitleLabel.text = @"祈\n愿\n累\n计\n天\n数";
        self.leftSubTitleLabel.text = @"0天";
    }
}
- (void)clickRightView {
    
    self.currentClickShenXian = YES;
[self changeTitleLabelWithShenXian:self.currentClickShenXian];
   
    [self sendGetRequest];

}
- (void)configNavigationBar {
    
    
    self.title = @"祈福";
    
 
    [self.navigationController.navigationBar setBackgroundImage:DotaImageName(@"img_dingbu") forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[CSUtility createImageWithColor:[UIColor colorWithHexString:@"#180C0A"]]];
    
    UIColor *whiteColor = UIColor.whiteColor;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    
    
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"img_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [[UIButton alloc] init];
    
   BOOL play = [[NSUserDefaults standardUserDefaults] boolForKey:@"MusciisPlayOrNot"];
    
    if (play) {
        [rightButton setImage:DotaImageName(@"img_shengying") forState:UIControlStateNormal];

    } else {
        [rightButton setImage:DotaImageName(@"img_shengying_no") forState:UIControlStateNormal];

    }
    
    
    [rightButton addTarget:self action:@selector(clickRightButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
    self.navigationItem.rightBarButtonItem = rightItem;
}
//声音
- (void)clickRightButtonDone {
    BOOL play = [[NSUserDefaults standardUserDefaults] boolForKey:MusicPlayKey];

    play = !play;
    
    [[NSUserDefaults standardUserDefaults] setBool:play forKey:MusicPlayKey];
    
    UIButton *rightButton = [[UIButton alloc] init];
    
    if (play) {
        [rightButton setImage:DotaImageName(@"img_shengying") forState:UIControlStateNormal];
        if (!_audioPlayer.isPlaying) {
           
            [_audioPlayer play];
            
        }
        if (!_audioPlayer.isPlaying) {
            [self playVoiceWithContentWithPath:self.recordMusicUrl];
        }
    } else {
        [rightButton setImage:DotaImageName(@"img_shengying_no") forState:UIControlStateNormal];
        if (_audioPlayer.isPlaying) {
            [_audioPlayer pause];
            
        }
    }
    
    
    [rightButton addTarget:self action:@selector(clickRightButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)clickLeftButtonDone {
    _audioPlayer = nil;
    [_audioPlayer stop];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainStoryboard"];
}

- (IBAction)qiYuanJiLuButtonDone:(id)sender {
   
    [self performSegueWithIdentifier:@"FirstShenXianQiYuanJiLuViewController" sender:self];
}



- (void)clickXiangButtonDone {
    if (![self judgeOrderIsRight:@"buddha"]) {
        return;
    }
     self.passString = @"敬香";
     self.recordCatId = [self getCatIdWithIdentifier:@"buddha"];
     [self performSegueWithIdentifier:@"AddXiangViewController" sender:self];
}

- (void)clickXianGuoButtonDone {
    
    if (![self judgeOrderIsRight:@"fruit"]) {
        return;
    }
    
     self.passString = @"献果";
        self.recordCatId = [self getCatIdWithIdentifier:@"fruit"];
     [self performSegueWithIdentifier:@"AddXiangViewController" sender:self];
    
}


- (void)clickXianHuaButtonDone {
    
    if (![self judgeOrderIsRight:@"flower"]) {
        return;
    }
    
     self.passString = @"献花";
     self.recordCatId = [self getCatIdWithIdentifier:@"flower"];
     [self performSegueWithIdentifier:@"AddXiangViewController" sender:self];
   
}

- (BOOL)judgeOrderIsRight:(NSString *)identifier {
    
    
    QiFUModel *model = [self getCurrentQiFuModel];
    
    if (csCharacterIsBlank(model.buddha_id)) {
        CustomWrongMessage(@"请先恭请菩萨");
        return NO;
    }
    
    BOOL goOn = YES;

    int order = 0;
    for (int i = 0; i < self.orderArray.count; i ++) {
       
        GongPingModel *subModel = self.orderArray[i];
     
        if ([subModel.ident isEqualToString:identifier]) {
            order = i;
            break;
        }
        
        
    }
    
    //拿到当前顺序
    for (int i = 0; i < order; i ++) {
       
        GongPingModel *subModel = self.orderArray[i];

        BOOL continueCheck = YES;
        
        for (GongPingModel *compareModel in model.item) {
          
            if ([subModel.cat_id isEqualToString:compareModel.cat_id]) {
                
                if (csCharacterIsBlank(compareModel.tribute_id)) {
                    NSString *product = [NSString stringWithFormat:@"先%@",subModel.title];
                    goOn = NO;
                    CustomWrongMessage(product);
                    continueCheck = NO;
                    break;
                }
            }
            
        }
        if (!continueCheck) {
            break;
        }
    }
    
    return goOn;
}
- (void)clickQingShengButtonDone {

    QiFUModel *model = [self getCurrentQiFuModel];
    
    if (csCharacterIsBlank(model.buddha_id)) {
       
        [self performSegueWithIdentifier:@"QingFoViewController" sender:self];
        return;
    }
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定送神归位吗" preferredStyle:UIAlertControllerStyleAlert];
    //2.创建界面上的按钮
    UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self songShenGuiWeiRequest];
    }];
    UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    //3.将按钮添加到AlertController中
    [alert addAction:actionNo];
    [alert addAction:actionYes];
    //5.显示AlertController
    [self presentViewController:alert animated:YES completion:nil];
    
     
}
- (void)songShenGuiWeiRequest {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    QiFUModel *model = [self getCurrentQiFuModel];
   
    para[@"supplication_id"] = model.supplication_id;
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Consecrate_Delete Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            [self sendGetRequest];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)clickJingShiButtonDone {
    
    if (![self judgeOrderIsRight:@"cake"]) {
        return;
    }
    self.passString = @"敬食";
    self.recordCatId = [self getCatIdWithIdentifier:@"cake"];
    [self performSegueWithIdentifier:@"AddXiangViewController" sender:self];
}
- (NSString *)getXiangTimeWithIdentifier {
    
    NSString *string = @"";
    NSString *time =  @"";
    for (GongPingModel *model in self.orderArray) {
        if ([model.ident isEqualToString:@"buddha"]) {
            
            string = model.cat_id;
            break;
        }
    }
    QiFUModel *model1 = [self getCurrentQiFuModel];
    for (GongPingModel *model in model1.item) {
        if ([model.cat_id isEqualToString:string]) {
            time = model.start;
        }
    }
    return time;
}
- (NSString *)getCatIdWithIdentifier:(NSString *)idString {
    
    NSString *string = nil;
    for (GongPingModel *model in self.orderArray) {
        if ([model.ident isEqualToString:idString]) {

            string = model.cat_id;
            break;
        }
    }
    return string;
}
- (IBAction)clickDaoCaiButtonDone:(id)sender {
    if (![self judgeOrderIsRight:@"tea"]) {
        return;
    }
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"cat_id"] = [self getCatIdWithIdentifier:@"tea"];
    
    para[@"pageSize"] = @"100";
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Consecrate Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getGongPingModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
            if (array.count == 0) {
                CustomWrongMessage(@"暂不能贡茶");
                
            } else {
                GongPingModel *model = array[0];
                [self gongCai:model.idString];
            }
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
   
   
    
}
- (void)gongCai:(NSString *)idstring {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"tribute_id"] = idstring;
    
    QiFUModel *model = [self getCurrentQiFuModel];
    para[@"supplication_id"] = model.supplication_id;

    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Consecrate_Paytribute Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            [self.animationImageView startAnimating];
            [self sendGetRequest];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CustomWrongMessage(@"暂不能贡茶");

    }];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"QingFoViewController"]) {
        QingFoViewController *new = segue.destinationViewController;
        if (self.currentClickShenXian) {
            
            new.passTag = @"1";
            
        } else {
            
            new.passTag = @"2";
            

        }
        
    }else if ([segue.identifier isEqualToString:@"AddXiangViewController"]) {
        AddXiangViewController *new = segue.destinationViewController;
        new.passString = self.passString;
        new.passCatId = self.recordCatId;
        QiFUModel *model = [self getCurrentQiFuModel];
        new.passSuppliationId = model.supplication_id;
    }else if ([segue.identifier isEqualToString:@"XuYuanMingDengViewController"]) {
        XuYuanMingDengViewController *new = segue.destinationViewController;
        QiFUModel *model = [self getCurrentQiFuModel];
        new.passBuddahaId = model.buddha_id;
        new.passSuppliationId = model.supplication_id;
    }
}
- (void)refreshCurrentViewWithModel:(QiFUModel *)model {
    
    
    if (model.item.count == 0) {
        
        
        self.leftHuaPingImageView.image = DotaImageName(@"img_huaping_kong");
        self.rightHuaPingImageView.image = DotaImageName(@"img_taohua_kong");
        
        self.rightLingShiImageView.image = DotaImageName(@"img_kongpan");
        
        self.leftFruitImageView.image = DotaImageName(@"img_kongpan");
        
        self.xiangluImageView.image = DotaImageName(@"img_xianglu");
        
        self.caiButton.hidden = NO;
        
        self.animationImageView.hidden = YES;
        
        self.centerBigFoImageView.image = DotaImageName(@"img_qingshen");
        
       
        if (self.currentClickShenXian) {
            
            self.leftSubTitleLabel.text = @"0H";
            
        } else {
            
            self.leftSubTitleLabel.text = @"0天";
            
        }
        self.dengimageView.image = DotaImageName(@"img_deng");
       
        return;
    }
    
    for (int i = 0; i < model.item.count; i ++) {
        
        GongPingModel *subModel = model.item[i];

       
        for (GongPingModel *gongPingModel in self.orderArray) {
        
            if ([subModel.cat_id isEqualToString:gongPingModel.cat_id]) {
                [self configViewGongPing:subModel WithIdentifier:gongPingModel.ident];
                break;
                
            }
        }
        
        
    }
    
   
    
    
     [self.dengimageView sd_setImageWithURL:[NSURL URLWithString:model.lampModel.icon] placeholderImage:DotaImageName(@"img_deng")];
    [self.centerBigFoImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:DotaImageName(@"img_qingshen")];
    if (self.currentClickShenXian) {
        
        self.leftSubTitleLabel.text = [NSString stringWithFormat:@"%@H",[self getXiangTimeWithIdentifier]];

    } else {
        
        self.leftSubTitleLabel.text = [NSString stringWithFormat:@"%@天",model.acc];

    }
    
    
}
- (void)configViewGongPing:(GongPingModel *)subModel WithIdentifier:(NSString *)identifier{
    /** 茶 = tea。flower：花、fruit：果、cake：糕点、buddha：香  */
    if ([identifier isEqualToString:@"tea"]) {
        if (!csCharacterIsBlank(subModel.tribute_id)) {
            self.animationImageView.hidden = NO;
            self.caiButton.hidden = YES;
        } else {
            self.animationImageView.hidden = YES;
            self.caiButton.hidden = NO;
            self.caiButton.enabled = YES;
        }
    } else if ([identifier isEqualToString:@"flower"]) {
        
        if (!csCharacterIsBlank(subModel.tribute_id)) {
            [self.leftHuaPingImageView sd_setImageWithURL:[NSURL URLWithString:subModel.tribute_icon] placeholderImage:DotaImageName(@"img_huaping_kong")];
            
            
            [self.rightHuaPingImageView sd_setImageWithURL:[NSURL URLWithString:subModel.tribute_icon] placeholderImage:DotaImageName(@"img_huaping_kong")];
        } else {
            self.leftHuaPingImageView.image = DotaImageName(@"img_huaping_kong");
            self.rightHuaPingImageView.image = DotaImageName(@"img_huaping_kong");

        }
        
    } else if ([identifier isEqualToString:@"fruit"]) {
        
        if (!csCharacterIsBlank(subModel.tribute_id)) {
           [self.leftFruitImageView sd_setImageWithURL:[NSURL URLWithString:subModel.tribute_icon] placeholderImage:DotaImageName(@"img_kongpan")];
        } else {
            self.leftHuaPingImageView.image = DotaImageName(@"img_kongpan");
            
        }
        
    } else if ([identifier isEqualToString:@"cake"]) {
        
        if (!csCharacterIsBlank(subModel.tribute_id)) {
            [self.rightLingShiImageView sd_setImageWithURL:[NSURL URLWithString:subModel.tribute_icon] placeholderImage:DotaImageName(@"img_kongpan")];
        } else {
            self.rightLingShiImageView.image = DotaImageName(@"img_kongpan");

        }
        
    } else if ([identifier isEqualToString:@"buddha"]) {
        
        if (!csCharacterIsBlank(subModel.tribute_id)) {
            [self.xiangluImageView sd_setImageWithURL:[NSURL URLWithString:subModel.tribute_icon] placeholderImage:DotaImageName(@"img_xianglu")];
        } else {
            self.xiangluImageView.image = DotaImageName(@"img_xianglu");

        }
        
    }
}
- (void)reloadCurrentView {
    
    [self changeTitleLabelWithShenXian:self.currentClickShenXian];

    [self refreshCurrentViewWithModel:[self getCurrentQiFuModel]];

    [self.collectionView reloadData];
}

#pragma mark --UICollectionDelegate/DataSource
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(80, 130);
   
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
 
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
    if (self.allFoListArray.count == 3) {
        return 3;
    }
    return self.allFoListArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    QiFuBottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(QiFuBottomCollectionViewCell) forIndexPath:indexPath];
    
    if (self.allFoListArray.count == 3) {
        
        QiFUModel *model = self.allFoListArray[indexPath.row];
        [cell.topImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:DotaImageName(@"img_qingfo")];
        
        return cell;
    }
    
    if (indexPath.row == self.allFoListArray.count) {
        cell.topImageView.image = DotaImageName(@"img_qingfo");
        return cell;
    }
    
    QiFUModel *model = self.allFoListArray[indexPath.row];
    [cell.topImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:DotaImageName(@"img_qingfo")];
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.recordCurrentClickIndex = indexPath.row + 1;
    
    [self reloadCurrentView];
    
}

#pragma mark -- 播放音乐
-(void)playVoiceWithContentWithPath:(NSString *)path
{
    
    if(_audioPlayer.isPlaying){
        
        [_audioPlayer stop];
        _audioPlayer = nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        CSLog(@"%@存在",path);
    }else {
        CSLog(@"%@不存在",path);

    }
    NSURL *fileUrl=[NSURL fileURLWithPath:path];
    [self initPlayer];
    NSError *error = nil;
    _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:&error];
    if (error) {
        
        CSLog(@"初始化语音失败原因：%@!!!!!!!!",error.userInfo);
        
    }
    [_audioPlayer setVolume:1];
    [_audioPlayer prepareToPlay];
    [_audioPlayer setDelegate:self];
    //为了获取时间
    
    if ([_audioPlayer play]) {
        
       
        CSLog(@"播放成功！！！！！！！！！");
     
    } else {
        
//        CustomWrongMessage(@"语音播放失败")
        CSLog(@"播放失败！！！！！！！！！");
        
    };
    
    
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
}
-(void)initPlayer{
    //初始化播放器的时候如下设置
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,
                            sizeof(sessionCategory),
                            &sessionCategory);
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (audioRouteOverride),
                             &audioRouteOverride);
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    [audioSession setActive:YES error:nil];
    
    audioSession = nil;
    
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
    CSLog(@"audioPlayerDidFinishPlaying");
    //    _audioPlayer=nil;
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    //发送通知当前播放情况
    [self playVoiceWithContentWithPath:self.recordMusicUrl];
    
}
@end
