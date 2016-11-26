//
//  LoginFlow.h
//  BlazeFlow
//
//  Created by Roy Derks on 26/11/2016.
//  Copyright © 2016 Roy Derks. All rights reserved.
//

#import "BlazeFlow.h"

typedef NS_ENUM(NSInteger, LoginState) {
    LoginStateLogin,
    LoginStateName,
    LoginStateMessage,
    LoginStateDone
};

#define kCardTitleTableViewCell @"CardTitleTableViewCell"
#define kCardForgotPasswordTableViewCell @"CardForgotPasswordTableViewCell"
#define kCardTextFieldTableViewCell @"CardTextFieldTableViewCell"
#define kCardSearchTextfieldTableViewCell @"CardSearchTextfieldTableViewCell"
#define kCardButtonTableViewCell @"CardButtonTableViewCell"
#define kCardTopSection @"CardTopSection"
#define kCardBottomSection @"CardBottomSection"
#define kCardMiddleSection @"CardMiddleSection"

@class User;

@interface LoginFlow : BlazeFlow

@property(nonatomic,strong) User *user;

@end
