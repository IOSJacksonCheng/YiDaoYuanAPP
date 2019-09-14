//
//  CSInterfaceAddress.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#ifndef CSInterfaceAddress_h
#define CSInterfaceAddress_h


#define CSInternetFailure [CSUtility showWrongMessageWithTitle:@"连接失败，请稍后再试"];
#define CSShowWrongMessage [CSUtility showWrongMessageWithTitle:responseObject[@"msg"]];

#define CSInternetRequestSuccessful [HandleRequestTool requestIsSuccessful:responseObject]

#define CustomWrongMessage(message) [CSUtility showWrongMessageWithTitle:message];

#define CSGetResult [HandleRequestTool requestSuccessGetResult:responseObject]

#define SuccessfulCode 1

#define NotSubmitCode 10001

#define APIVersion @"1.0.0"



#pragma mark -- //登录

#define BASE_URL @"https://www.kavinwong.xyz/api/"

#define CSURL_Login_wechat @"user/public/wechat"

#define CSURL_Login @"user/public/login"

#define CSURL_Login_QQ  @"user/public/qq"
#define CSURL_Register @"user/public/register"

#define CSURL_Verification_code @"user/verification_code/send"

#define CSURL_ChangePassword @"user/profile/changePassword"

#define CSURL_PasswordReset @"user/public/passwordReset"

#define CSURL_Profile_UserInfo @"user/profile/userInfo"
#define CSURL_Profile_Masterinfo @"user/profile/masterinfo"

#define CSURL_Portal_withdraw @"portal/user/withdraw"

#define CSURL_Logout @"user/public/logout"

#define CSURL_Upload @"user/upload/one"


#pragma mark -- //祈福
#define CSURL_Portal_Consecrate_Category @"portal/consecrate/category"
#define CSURL_Portal_Consecrate_Being @"portal/consecrate/being"
#define CSURL_Portal_Consecrate @"portal/consecrate"

#define CSURL_Portal_Consecrate_Delete @"portal/consecrate/delete"
#define CSURL_Portal_Consecrate_Hotwish @"portal/consecrate/hotwish"
#define CSURL_Portal_Consecrate_Supplication @"portal/consecrate/supplication"

#define CSURL_Portal_Consecrate_Buddha @"portal/consecrate/buddha"
#define CSURL_Portal_Consecrate_Record @"portal/consecrate/record"
#define CSURL_Portal_Consecrate_History @"portal/consecrate/history"
#define CSURL_Portal_Consecrate_Paytribute @"portal/consecrate/paytribute"
#define CSURL_Portal_Consecrate_Lamp @"portal/consecrate/lamp"
#define CSURL_Portal_Consecrate_Lampinfo @"portal/consecrate/lampinfo"

#define CSURL_Portal_Site_Lamp @"portal/site/lamp"
#define CSURL_Consecrate_Lampprice @"portal/consecrate/lampprice"
#define CSURL_Consecrate_Addlamp @"portal/consecrate/addlamp"


//祈福


#pragma mark -- //首页
#define CSURL_consult_refund @"portal/consult/refund"
#define CSURL_qa_refund @"portal/qa/refund"

#define CSURL_qa_cancel @"portal/qa/cancel"
#define CSURL_consult_finish @"portal/consult/finish"
#define CSURL_qa_finish @"portal/qa/finish"

#define CSURL_qa_reply @"portal/qa/reply"
#define CSURL_consult_cancel @"portal/consult/cancel"
#define CSURL_Portal_Re @"portal/master/rec"
#define CSURL_Portal_consult_chat_msg @"portal/consult/chat_msg"
#define CSURL_Portal_consult_reply @"portal/consult/reply"
#define CSURL_Index_Bask @"portal/index/bask"
#define CSURL_Portal_City @"portal/area/city"
#define CSURL_Portal_Hot @"portal/area/hot"
#define CSURL_Portal_News_Index @"portal/news/index"
#define CSURL_portal_Master_Rank @"portal/master/rank"
#define CSURL_portal_Consult_Category @"portal/consult/category"
#define CSURL_portal_Master_Info @"portal/master/info"
#define CSURL_portal_Index_Evaluationinfo @"portal/index/evaluationinfo"
#define CSURL_portal_Index_evaluation @"portal/index/evaluation"

#define CSURL_portal_index_rechargead @"portal/index/rechargead"
#define CSURL_portal_master @"portal/master"
#define CSURL_portal_msg_read @"portal/msg/read"
#define CSURL_portal_isapply @"portal/user/isapply"
#define CSURL_portal_msg_unread @"portal/msg/unread"
#define CSURL_portal_mcenter_consultinfo @"portal/mcenter/consultinfo"
#define CSURL_portal_mcenter_getinfo @"portal/mcenter/getinfo"

#define CSURL_share_index @"portal/share/index"
#define CSURL_Portal_hot_banner @"portal/index/banner"
#define CSURL_Portal_index_reclevel @"portal/index/reclevel"
#define CSURL_Portal_hot_item @"portal/index/hot_item"
#define CSURL_Portal_qa_case @"portal/qa/case"
#define CSURL_Portal_qa_category @"portal/qa/category"
#define CSURL_Portal_Qa_Question @"portal/qa/question"
#define CSURL_Portal_Master_Qa @"portal/master/qa"
#define CSURL_Portal_Qa_order @"portal/qa/order"
#define CSURL_Portal_master_condition @"portal/master/condition"
#define CSURL_Portal_consult_price @"portal/consult/price"
#define CSURL_Portal_master_evaluate @"portal/master/evaluate"

#define CSURL_Portal_user_evaluation @"portal/user/evaluation"
#define CSURL_Portal_master_avgevaluate @"portal/master/avgevaluate"
#define CSURL_Portal_user_favorites_add @"user/favorites/add"
#define CSURL_Portal_user_favorites_unset @"user/favorites/unset"
#define CSURL_Portal_user_favorites_hasFavorite @"user/favorites/hasFavorite"

#define CSURL_Portal_total_praise @"portal/master/total_praise"

#define CSURL_Portal_master_praise @"portal/master/praise"
#define CSURL_Portal_consult_order_msg @"portal/consult/order_msg"
#define CSURL_Portal_user_coin_multiple @"portal/user/coin_multiple"
#define CSURL_Portal_consult_order @"portal/consult/order"
#define CSURL_Portal_consult_fillorder @"portal/consult/fillorder"
#define CSURL_Portal_master_master_skille @"portal/master/master_skille"
#define CSURL_Portal_index_order_evaluation @"portal/index/order_evaluation"
//首页

//个人中心
#pragma mark -- //个人中心

#define CSURL_Portal_Consult @"portal/user/consult"

#define CSURL_Favorites_My @"user/favorites/my"

#define CSURL_About_Us @"portal/site/about"
#define CSURL_New_Fish @"portal/site/newbie"
#define CSURL_User_Consult @"portal/user/consult"
#define CSURL_Site_News @"portal/site/news"
#define CSURL_User_Recharge @"portal/user/recharge"
#define CSURL_User_Feedback @"portal/user/feedback"
#define CSURL_User_Profile_Account @"user/profile/account"
#define CSURL_User_Profile_Coindiscount @"user/profile/coindiscount"
#define CSURL_User_City_Partner @"portal/user/city_partner"
#define CSURL_Portal_mcenter_consult @"portal/mcenter/consult"
#define CSURL_Portal_mcenter_qa @"portal/mcenter/qa"

#define CSURL_Portal_user_consult @"portal/user/consult"
#define CSURL_Portal_user_qa @"portal/user/qa"
#define CSURL_Portal_user_ismaster @"portal/user/ismaster"

#define CSURL_Portal_balance_logs @"user/balance/logs"
#define CSURL_Portal_coin_logs @"user/coin/logs"

//个人中心
#pragma mark -- //大师个人中心
#define CSURL_Master_Skilled_field @"portal/master/skilled_field"
#define CSURL_Masterpost @"portal/user/masterpost"
#define CSURL_QA_detail @"portal/qa/detail"
//易道源课堂
#pragma mark -- //易道源课堂
#define CSURL_Course_Category @"portal/course/category"
#define CSURL_Portal_Course @"portal/course"
#define CSURL_Course_Info @"portal/course/info"

#define CSURL_Portal_Evaluatelists @"portal/course/evaluatelists"
#define CSURL_Portal_Course_Order @"portal/course/order"
#define CSURL_Portal_Course_Evaluate @"portal/course/evaluate"

#define CSURL_Portal_Site_course_detail @"portal/site/course/detail"
//商场
#pragma mark -- //商场
#define CSURL_Portal_share_bill @"portal/share/bill"
#define CSURL_Portal_Site_Goodsabout @"portal/site/goodsabout"
#define CSURL_Portal_Site_share_play @"portal/site/share_play"
#define CSURL_Goods_Idea @"portal/goods/idea"
#define CSURL_Cart_Modify @"portal/cart/modify_cart_quantity"
#define CSURL_Cart_Delcart @"portal/cart/delcart"
#define CSURL_Cart_Cart_creat_order @"portal/cart/cart_creat_order"

#define CSURL_Cart_Affirm @"portal/cart/affirm"
#define CSURL_User_Addresslist @"portal/user/addresslist"

#define CSURL_User_Setaddress @"portal/user/setaddress"
#define CSURL_User_address @"portal/user/address"
#define CSURL_User_CSDeladdres @"portal/user/deladdres"
#define CSURL_Cart_Save @"portal/cart/saveorderaddr"
/**0咨询订单 1问答订单 2充值 3课堂订单 4商城订单 5赞赏订单*/
#define CSURL_Index_Createpay @"portal/index/createpay"
#define CSURL_Goods_Slideimg @"portal/goods/slideimg"

#define CSURL_Goods_New_goods @"portal/goods/new_goods"
#define CSURL_Goods_Classify @"portal/goods/classify"
#define CSURL_Goods_Goodslist @"portal/goods/goodslist"
#define CSURL_Goods_GoodsDetail @"portal/goods/goodsdetail"

#define CSURL_Site_GoodsInfo @"portal/site/goods_info"
#define CSURL_Cart_buynow_creat_order @"portal/cart/buynow_creat_order"
#define CSURL_Cart_addcart @"portal/cart/addcart"
#define CSURL_Cart_order_list @"portal/cart/order_list"
#define CSURL_Cart_cart_list @"portal/cart/cart_list"
#define CSURL_Cart_Goods_issue @"portal/goods/issue"
#define CSURL_Cart_cancle_order @"portal/cart/cancle_order"
#define CSURL_Cart_apply_refund @"portal/cart/apply_refund"
#define CSURL_Cart_affirm_order @"portal/cart/affirm_order"
#define CSURL_Cart_Logistics @"portal/cart/logistics"
#define CSURL_Order_Details @"portal/cart/order_details"
//商场
#pragma mark -- //消息
#define CSURL_portal_index_search @"portal/index/search"
#define CSURL_portal_index_topad @"portal/index/topad"

#define CSURL_msg_index @"portal/msg/index"
#define CSURL_msg_del @"portal/msg/del"
#define CSURL_forum_index @"portal/forum/index"
#define CSURL_forum_comment_list @"portal/forum/comment_list"
#define CSURL_forum_topic_comment @"portal/forum/topic_comment"
#define CSURL_Portal_consult_chat @"portal/consult/chat"
#define CSURL_user_upload_chat @"user/upload/chat"

#define CSURL_portal_consecrate_bgmusic @"portal/consecrate/bgmusic"
#endif /* CSInterfaceAddress_h */
