//
//  DaShiRuZhuIdCardTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiRuZhuIdCardTableViewCell.h"
@interface DaShiRuZhuIdCardTableViewCell()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (nonatomic, assign) BOOL isLeft;
@end
@implementation DaShiRuZhuIdCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLeft)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.leftImageView addGestureRecognizer:tap];
    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRight)];
    tap1.numberOfTapsRequired = 1;
    tap1.numberOfTouchesRequired = 1;
    
    [self.rightImageView addGestureRecognizer:tap1];
    
}
- (void)clickRight {
   
    [self getPhotoWith:NO];
}
- (void)clickLeft {
    [self getPhotoWith:YES];

    
}
- (void)getPhotoWith:(BOOL)isLeft {
    self.isLeft = isLeft;
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:@"请选择文件来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    
    // 判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])  {
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)  {
            // 设置数据源
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [[CSUtility getCurrentViewController] presentViewController:imagePickerController animated:YES completion:nil];
        }];
        [alertSheet addAction:cameraAction];
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [[CSUtility getCurrentViewController] presentViewController:imagePickerController animated:YES completion:nil];
        }];
        [alertSheet addAction:photoAction];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertSheet addAction:cancelAction];
    [[CSUtility getCurrentViewController] presentViewController:alertSheet animated:YES completion:nil];
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
        NSString *path = [self saveImg:image WithName:@"zizilaiyuan.png"];
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
    [CSNetManager sendPostForUploadImageWithUrl:CSURL_Upload headerImageFilePath:path fileName:@"zizilaiyuan.png" parpameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            
            
            
            NSData *data = [NSData dataWithContentsOfFile:path];
            if (self.isLeft) {
                self.leftImageView.image = [UIImage imageWithData:data];
                self.model.leftImage = [UIImage imageWithData:data];
                self.model.leftImageString = [NSString stringWithFormat:@"%@",CSGetResult[@"path"]];
            } else {
                self.rightImageView.image = [UIImage imageWithData:data];
                 self.model.rightimageString = [NSString stringWithFormat:@"%@",CSGetResult[@"path"]];
                  self.model.rightImage = [UIImage imageWithData:data];
            }
          
            
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DaShiRuZhuModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    
    if (model.leftImage) {
        self.leftImageView.image = model.leftImage;

    } else {
        self.leftImageView.image = DotaImageName(@"icon_tianjia");

    }
    
    
    if (model.rightImage) {
        self.rightImageView.image = model.rightImage;;
        
    } else {
        self.rightImageView.image = DotaImageName(@"icon_tianjia");
        
    }
  
}
@end
