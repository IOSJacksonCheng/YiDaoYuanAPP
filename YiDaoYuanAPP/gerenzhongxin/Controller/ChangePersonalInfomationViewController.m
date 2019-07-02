//
//  ChangePersonalInfomationViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/26.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ChangePersonalInfomationViewController.h"

@interface ChangePersonalInfomationViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *boyButton;
@property (weak, nonatomic) IBOutlet UIButton *girlButton;
@property (weak, nonatomic) IBOutlet UIButton *birthdayButton;
@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;
- (IBAction)clickChooseDateButtonDone:(id)sender;
@property (nonatomic, strong) NSString *recordImage;
@property (nonatomic, strong) NSString *recordBirthday;
@property (weak, nonatomic) IBOutlet UIView *birthdayView;

- (IBAction)clickGirlButtonDone:(id)sender;

- (IBAction)clickBoyButtonDone:(id)sender;

@end

@implementation ChangePersonalInfomationViewController

- (void)viewDidLoad {
  
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    
}

- (void)configTableView {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBirthdayDayButtonDone)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.birthdayView addGestureRecognizer:tap];
    
}
- (void)clickHeadImageView {
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:@"请选择头像来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    
    // 判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])  {
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)  {
            // 设置数据源
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }];
        [alertSheet addAction:cameraAction];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }];
        [alertSheet addAction:photoAction];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertSheet addAction:cancelAction];
    [self presentViewController:alertSheet animated:YES completion:nil];
}
- (void)configSubViews {
    
    self.datepicker.maximumDate = [NSDate date];
    
    self.headImageView.layer.cornerRadius = 51 * 0.5;
    self.headImageView.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeadImageView)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.headView addGestureRecognizer:tap];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:CS_Avatar] placeholderImage:CSUserImagePlaceHolder];
    
    self.nameTextField.text = CS_User_Nickname;
    
    if ([CS_Sex isEqualToString:@"0"]) {
        self.boyButton.selected = NO;
        self.girlButton.selected = NO;
    }else if ([CS_Sex isEqualToString:@"1"]) {
        self.boyButton.selected = YES;
        self.girlButton.selected = NO;
    }else if ([CS_Sex isEqualToString:@"2"]) {
        self.boyButton.selected = NO;
        self.girlButton.selected = YES;
    }
    
    if (csCharacterIsBlank(CS_Birthday)) {
        [self.birthdayButton setTitle:@"选择日期" forState:UIControlStateNormal];
    } else {
    [self.birthdayButton setTitle:CS_Birthday forState:UIControlStateNormal];
    }
}

- (void)configNavigationBar {
    
    F3f3f3NavigationBarColor
    
    self.title = @"设置";
    
    UIButton *rightButton = [[UIButton alloc] init];
    
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    
    rightButton.titleLabel.font = csCharacterFont_18;
    
    [rightButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(clickSaveDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)clickSaveDone {
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定修改信息吗" preferredStyle:UIAlertControllerStyleAlert];
    //2.创建界面上的按钮
    UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self sendSaveRequest];
    }];
    UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    //3.将按钮添加到AlertController中
    [alert addAction:actionNo];
    [alert addAction:actionYes];
    //5.显示AlertController
    [self presentViewController:alert animated:YES completion:nil];
    
    
   
    
}

- (void)sendSaveRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    
    para[@"user_nickname"] = self.nameTextField.text;
    
    if (!csCharacterIsBlank(self.recordImage)) {
        para[@"avatar"] = self.recordImage;

    }
    NSString *sex = @"";
    if (!self.boyButton.selected && !self.girlButton.selected) {
        para[@"sex"] = @"0";
        sex = @"0";
    }else {
        if (self.boyButton.selected) {
            para[@"sex"] = @"1";
            sex = @"1";
            
        } else {
            para[@"sex"] = @"2";
            sex = @"2";
            
            
        }
    }
    if (!csCharacterIsBlank(self.recordBirthday)) {
        para[@"birthday"] = self.recordBirthday;

    }
    
    NSString *Url = CSURL_Profile_UserInfo;
    
    if (CS_UserIsMaster) {
        Url = CSURL_Profile_UserInfo;
    }
    [CSNetManager sendPostRequestWithNeedToken:YES Url:Url Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"修改成功");
            
          
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",CSGetResult[@"avatar"]] forKey:@"CS_Avatar"];
          
           
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",CSGetResult[@"birthday"]] forKey:@"CS_Birthday"];
            
           
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",CSGetResult[@"sex"]] forKey:@"CS_Sex"];
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",CSGetResult[@"user_nickname"]] forKey:@"CS_User_Nickname"];
            
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
}
- (void)clickBirthdayDayButtonDone {
    
    self.dateView.hidden = NO;
}
- (IBAction)clickChooseDateButtonDone:(UIButton *)sender {
    
    if (sender.tag == 1) {
        
        [self.birthdayButton setTitle:[CSUtility convertDateIntoString:self.datepicker.date] forState:UIControlStateNormal];
        self.recordBirthday = [CSUtility convertDateIntoString:self.datepicker.date];
    }
    
    self.dateView.hidden = YES;
    
    
}


#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 被选中的图片
    if ([mediaType isEqualToString:@"public.image"])   {
        // 获取照片
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        NSString *path = [self saveImg:image WithName:@"avatar.png"];
        if (path != nil)  {
            // 图片存在，做你想要的操作
            
            [self sendPostRequestForIconWithPath:path];
            //            [UserDefaults setImage:data];
        }
        [picker dismissViewControllerAnimated:YES completion:nil];          // 隐藏视图
    }
}
- (void)sendPostRequestForIconWithPath:(NSString *)path {
    
 
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"file"] = path;
    [CSNetManager sendPostForUploadImageWithUrl:CSURL_Upload headerImageFilePath:path fileName:@"avatar.png" parpameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            
            
            
            NSData *data = [NSData dataWithContentsOfFile:path];
            
            self.headImageView.image = [UIImage imageWithData:data];
            
            self.recordImage = CSGetResult[@"path"];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
   
    
    
}
- (NSString *)saveImg:(UIImage *)curImage WithName:(NSString *)imageName;
{
    NSData *imageData = UIImageJPEGRepresentation(curImage, 1);             // 1为不缩放保存，取值(0~1)
    
    // 获取沙盒路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:imageName];
    
    // 将照片写入文件
    //atomically：这个参数意思是: 如果为YES则保证文件的写入原子性,就是说会先创建一个临时文件,直到文件内容写入成功再导入到目标文件里.如果为NO,则直接写入目标文件里
    if ([imageData writeToFile:path atomically:NO]) {
        return path;
    }  else {
        return nil;
    }
}
- (IBAction)clickGirlButtonDone:(id)sender {
    
    self.girlButton.selected = !self.girlButton.selected;
    self.boyButton.selected = NO;
}

- (IBAction)clickBoyButtonDone:(id)sender {
    
    self.boyButton.selected = !self.boyButton.selected;
    self.girlButton.selected = NO;
}
@end
