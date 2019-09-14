//
//  GoToJudgePictureTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/27.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "GoToJudgePictureTableViewCell.h"

#import "UploadImageCollectionViewCell.h"

#import "DaShiItemCollectionReusableView.h"

#import "GoToJudgeJudgeModel.h"
@interface GoToJudgePictureTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;


@property (nonatomic, assign) NSInteger currentIndex;
@end
@implementation GoToJudgePictureTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageCollectionView.delegate = self;
    
    self.imageCollectionView.dataSource = self;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((MainScreenWidth - 10 * 2 - 5 * 2 ) / 3.0, (MainScreenWidth - 10 * 2 - 5 * 2 ) / 3.0);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //创建UICollectionView
    self.imageCollectionView.collectionViewLayout = layout;
    
    [self.imageCollectionView registerNib:[UINib nibWithNibName:@"UploadImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"UploadImageCollectionViewCell"];
    
    [self.imageCollectionView registerNib:[UINib nibWithNibName:@"DaShiItemCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DaShiItemCollectionReusableView"];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -- UICollectionViewDataSouce/Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (!self.showTitleView) {
        return CGSizeMake(0, 0);
    }
    
    return CGSizeMake(MainScreenWidth, 45);
}


// CGFloat top, left, bottom, right;
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 10, 15, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 2;
//}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (!self.showTitleView) {
        
        GoToJudgeJudgeModel *model = self.listArray.lastObject;
       
       if (csCharacterIsBlank(model.url) && self.listArray.count != 1) {
            
            return self.listArray.count - 1;
            
        }
        
    }
    
    return self.listArray.count;
    
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    UploadImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UploadImageCollectionViewCell" forIndexPath:indexPath];
    
    GoToJudgeJudgeModel *model = self.listArray[indexPath.row];
  
    if (csCharacterIsBlank(model.url)) {
        
        cell.uploadImageView.image = DotaImageName(@"icon_tianjia");
        cell.deleteButton.hidden = YES;
    } else {
        
        if (!self.showTitleView) {
            cell.deleteButton.hidden = YES;

        }else {
            cell.deleteButton.hidden = NO;

        }
        
        
        [cell.deleteButton addTarget:self action:@selector(deleteBUttonDone:) forControlEvents:UIControlEventTouchDown];
         [cell.uploadImageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:PlaceHolderImage];
    }
    

    return cell;
    
}

- (void)deleteBUttonDone:(UIButton *)sender {
   
    UploadImageCollectionViewCell *cell = (UploadImageCollectionViewCell *)[[sender superview] superview];
    
    NSIndexPath *indexPath = [self.imageCollectionView indexPathForCell:cell];
    
    if (!indexPath) {
        return;
    }
    
    [self.listArray removeObjectAtIndex:indexPath.row];
    
    [self.imageCollectionView reloadData];
    
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
   
    if (!self.showTitleView) {
        return nil;
    }
    
    DaShiItemCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DaShiItemCollectionReusableView" forIndexPath:indexPath];
    if (self.listArray.count == 1) {
        headerView.itemTitleLabel.text = @"上传图片（0/9）";

    }else  if (self.listArray.count == 9){
        GoToJudgeJudgeModel *last = self.listArray.lastObject;
        if (csCharacterIsBlank(last.url)) {
            headerView.itemTitleLabel.text = @"上传图片（8/9）";

        } else {
            headerView.itemTitleLabel.text = @"上传图片（9/9）";

        }
    }else {
        headerView.itemTitleLabel.text = [NSString stringWithFormat:@"上传图片（%ld/9）",self.listArray.count - 1];

    }
    
    headerView.itemTitleLabel.textColor = [UIColor colorWithHexString:@"666666"];
    
    headerView.itemTitleLabel.font = csCharacterFont_18;
   
    headerView.backgroundColor = UIColor.whiteColor;
    
    return headerView;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!self.showTitleView) {
        
        GoToJudgeJudgeModel *model = self.listArray[indexPath.row];
        if (!csCharacterIsBlank(model.url)) {
            if ([self.csDelegate respondsToSelector:@selector(passUrl:)]) {
                [self.csDelegate passUrl:model.url];
                return;
            }
        }
        
        return;
    }
     GoToJudgeJudgeModel *model = self.listArray[indexPath.row];
    if (!csCharacterIsBlank(model.url)) {
        if ([self.csDelegate respondsToSelector:@selector(passUrl:)]) {
            [self.csDelegate passUrl:model.url];
            return;
        }
    }
    
    self.currentIndex = indexPath.row;
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:@"请选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
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
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
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
            
            
            
//            NSData *data = [NSData dataWithContentsOfFile:path];
            
            GoToJudgeJudgeModel *model = [GoToJudgeJudgeModel new];
model.url = [NSString stringWithFormat:@"%@",CSGetResult[@"url"]];
            model.path = [NSString stringWithFormat:@"%@",CSGetResult[@"path"]];
            model.filename = [NSString stringWithFormat:@"%@",CSGetResult[@"path"]];
            
            if (self.currentIndex == self.listArray.count - 1) {
                [self.listArray replaceObjectAtIndex:self.listArray.count - 1 withObject:model];
                if (self.listArray.count <9) {
                    GoToJudgeJudgeModel *new = [GoToJudgeJudgeModel new];
                    [self.listArray addObject:new];
                }
            } else if (self.currentIndex < self.listArray.count - 1) {
                [self.listArray replaceObjectAtIndex:self.currentIndex withObject:model];
            }
            
            [self.imageCollectionView reloadData];
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
- (void)setListArray:(NSMutableArray *)listArray {
    _listArray = listArray;
    
    [self.imageCollectionView reloadData];
}
@end
