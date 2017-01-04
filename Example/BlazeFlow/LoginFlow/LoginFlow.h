//
//  LoginFlow.h
//  BlazeFlow
//
//  Created by Roy Derks on 26/11/2016.
//  Copyright © 2016 Roy Derks. All rights reserved.
//

#import "BlazeFlowSkippable.h"

typedef NS_ENUM(NSInteger, LoginState) {
    LoginStateNone = 0,
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

@interface LoginFlow : BlazeFlowSkippable

@property(nonatomic,strong) User *user;

@end
