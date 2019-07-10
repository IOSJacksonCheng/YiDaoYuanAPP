//
//  CSInterfaceAddress.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#ifndef CSInterfaceAddress_h
#define CSInterfaceAddress_h


#define CSInternetFailure [CSUtility showWrongMessageWithTitle:@"发生未知错误，请检查网络或稍后再试."];
#define CSShowWrongMessage [CSUtility showWrongMessageWithTitle:responseObject[@"msg"]];

#define CSInternetRequestSuccessful [HandleRequestTool requestIsSuccessful:responseObject]

#define CustomWrongMessage(message) [CSUtility showWrongMessageWithTitle:message];

#define CSGetResult [HandleRequestTool requestSuccessGetResult:responseObject]

#define SuccessfulCode 1

#define NotSubmitCode 10001

#define APIVersion @"1.0.0"



//API
#define BASE_URL @"https://www.kavinwong.xyz/api/"

#define CSURL_Login_wechat @"user/public/wechat"

#define CSURL_Login @"user/public/login"

#define CSURL_Register @"user/public/register"

#define CSURL_Verification_code @"user/verification_code/send"

#define CSURL_ChangePassword @"user/profile/changePassword"

#define CSURL_PasswordReset @"user/public/passwordReset"

#define CSURL_Profile_UserInfo @"user/profile/userInfo"
#define CSURL_Profile_Masterinfo @"user/profile/masterinfo"



#define CSURL_Logout @"user/public/logout"

#define CSURL_Upload @"user/upload/one"

//祈福
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

//首页
#define CSURL_Portal_Re @"portal/master/rec"
#define CSURL_Index_Bask @"portal/index/bask"
#define CSURL_Portal_City @"portal/area/city"
#define CSURL_Portal_Hot @"portal/area/hot"
#define CSURL_Portal_News_Index @"portal/news/index"
#define CSURL_portal_Master_Rank @"portal/master/rank"
//首页

//个人中心
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

//个人中心

#define CSURL_Master_Skilled_field @"portal/master/skilled_field"
#define CSURL_Masterpost @"portal/user/masterpost"

//易道源课堂
#define CSURL_Course_Category @"portal/course/category"
#define CSURL_Portal_Course @"portal/course"
#define CSURL_Course_Info @"portal/course/info"

#define CSURL_Portal_Evaluatelists @"portal/course/evaluatelists"
#define CSURL_Portal_Course_Order @"portal/course/order"
#define CSURL_Portal_Course_Evaluate @"portal/course/evaluate"


//商场
#define CSURL_Portal_Site_Goodsabout @"portal/site/goodsabout"
#define CSURL_Goods_Idea @"portal/goods/idea"

#endif /* CSInterfaceAddress_h */
