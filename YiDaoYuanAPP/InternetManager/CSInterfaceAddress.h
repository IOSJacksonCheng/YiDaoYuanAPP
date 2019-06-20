//
//  CSInterfaceAddress.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#ifndef CSInterfaceAddress_h
#define CSInterfaceAddress_h



#define CSInternetFailure [CSUtility showWrongMessageWithTitle:@"网络错误，请检查网络."];
#define CSShowWrongMessage [CSUtility showWrongMessageWithTitle:responseObject[@"msg"]];

#define CSInternetRequestSuccessful [HandleRequestTool requestIsSuccessful:responseObject]

#define CustomWrongMessage(message) [CSUtility showWrongMessageWithTitle:message];

#define CSGetResult [HandleRequestTool requestSuccessGetResult:responseObject]

#define SuccessfulCode 1

#define NotSubmitCode 10001

#define APIVersion @"1.0.0"

#define CSGetToken [[NSUserDefaults standardUserDefaults] valueForKey:@"CSGetToken"]


//API
#define BASE_URL @"http://xx.com/api/"


#define CSURL_Login @"user/public/login"

#define CSURL_Register @"user/public/register"

#define CSURL_Verification_code @"user/verification_code/send"

#define CSURL_ChangePassword @"user/profile/changePassword"

#define CSURL_PasswordReset @"user/public/passwordReset"

#define CSURL_Profile_UserInfo @"profile/userInfo"



#define CSURL_Logout @"user/public/logout"

#define CSURL_Upload @"user/upload/one"

#endif /* CSInterfaceAddress_h */
