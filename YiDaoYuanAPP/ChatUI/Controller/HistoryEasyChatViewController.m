//
//  HistoryEasyChatViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/8/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "HistoryEasyChatViewController.h"

#import "CSChatModel.h"

@interface HistoryEasyChatViewController ()<EaseMessageViewControllerDataSource>
//@property (nonatomic, assign) int csMyPage;
@end

@implementation HistoryEasyChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = self;
    
    [self setChatToolbar:nil];
    
    self.showRefreshFooter = YES;
    
    self.showRefreshHeader = YES;
    
    [self configNavigationBar];
   
//    [EMClient sharedClient].options.isAutoTransferMessageAttachments = NO;
}
- (void)clickLeftItem {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)configNavigationBar {
    
    UIButton *leftButton = [[UIButton alloc]init];
    [leftButton setImage:DotaImageName(@"icon_back") forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickLeftItem) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = backItem;
    WhiteNavigationBarColor
    
    self.title = @"聊天记录";
    
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}

- (EMMessageBody *)accrodingMessageBodyType:(NSString *)type WithText:(NSString *)text WithDuration:(NSString *)duration{
    if ([type isEqualToString:@"0"]) {
        return [[EMTextMessageBody alloc] initWithText:text];
    }else if ([type isEqualToString:@"1"]){
        
        
        EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithData:nil thumbnailData:nil];
       
        body.remotePath = text;
        
        body.thumbnailDisplayName = @"image.png";
        body.downloadStatus = EMDownloadStatusFailed;
        body.thumbnailRemotePath = text;
        return body;
    }else if ([type isEqualToString:@"2"]) {
        
        EMVoiceMessageBody *body = [[EMVoiceMessageBody alloc] initWithLocalPath:nil displayName:@"audio"];
        
        body.remotePath = text;
        
        body.duration = duration.intValue;
        body.downloadStatus = EMDownloadStatusFailed;
        return body;
    }
    
    return nil;
    
}
- (NSMutableArray *)convertArray:(NSMutableArray *)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < result.count; i++) {
        
        CSChatModel *oldModel = result[i];
        EMMessageBody *body = [self accrodingMessageBodyType:oldModel.type WithText:oldModel.content WithDuration:oldModel.size];
        
        EMMessage *message = [[EMMessage alloc] initWithConversationID:@"" from:@"" to:@"" body:body ext:nil];
        message.status = EMMessageStatusSucceed;
        
        message.chatType = EMChatTypeChat;
        message.localTime = oldModel.ctime.longLongValue;
        
        
        id<IMessageModel> model = nil;
        
        model = [[EaseMessageModel alloc] initWithMessage:message];
      
        if ([oldModel.is_reply isEqualToString:@"1"]) {
            //o yonghu 1 dashi
            if (CS_UserIsMaster) {
                model.isSender = YES;
            } else {
                model.isSender = NO;
            }
        }else {
            if (CS_UserIsMaster) {
                model.isSender = NO;
            } else {
                model.isSender = YES;
            }
        }
        
        
        model.isMessageRead = YES;
        
        model.isMediaPlayed = YES;
        
        model.cellHeight = 0;
        
        model.nickname = oldModel.name;
        
        model.avatarImage = CSUserImagePlaceHolder;//默认头像

        model.avatarURLPath = oldModel.avatar;
        
        model.fileURLPath = oldModel.content;
        
        model.thumbnailFileURLPath = oldModel.content;
        
        model.failImageName = @"img_zhanwei";
        
        
        [mutableArray addObject:model];
        

    }
    
    
    return mutableArray;
    
}
- (void)tableViewDidTriggerHeaderRefresh {
    //子类需要重写此方法
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page = 1;
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    para[@"order_id"] = self.orderId;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_consult_chat_msg Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
        NSMutableArray *array = [CSParseManager getCSChatModelWithResponseObject:CSGetResult[@"lists"]];
            
            self.dataArray = [self convertArray:array];
            
            [self.tableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];

        CSInternetFailure
    }];
}
- (void)tableViewDidTriggerFooterRefresh {
    //子类需要重写此方法
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page += 1;
    
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    para[@"order_id"] = self.orderId;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_consult_chat_msg Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getCSChatModelWithResponseObject:CSGetResult[@"lists"]];
            
            if (array.count == 0) {
                
                CustomWrongMessage(@"下面没有数据了");
                
            }else {
                
                
                [self.dataArray addObjectsFromArray:[self convertArray:array]];
                
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
- (void)_customDownloadMessageFile:(EMMessage *)aMessage {
   
    EMMessageBody *messageBody = aMessage.body;
    
    if ([messageBody type] == EMMessageBodyTypeImage) {
        EMImageMessageBody *imageBody = (EMImageMessageBody *)messageBody;
        if (imageBody.thumbnailDownloadStatus > EMDownloadStatusSuccessed)
        {
            //download the message thumbnail
            
//            imageBody.localPath =
            
            
        }
    }
    else if ([messageBody type] == EMMessageBodyTypeVoice)
    {
        EMVoiceMessageBody *voiceBody = (EMVoiceMessageBody*)messageBody;
        if (voiceBody.downloadStatus > EMDownloadStatusSuccessed)
        {
            
            [CSNetManager downloadFileWithUrl:voiceBody.remotePath success:^(id  _Nonnull responseObject) {
                
                
                
                voiceBody.localPath = responseObject;
                voiceBody.downloadStatus = EMDownloadStatusSuccessed;
                

            } failure:^(NSError * _Nonnull error) {
                
            }];
        }
    }
    
}

- (void)endRefresh {
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];

    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}
@end
