//
//  BlazeFlowNavigationController.h
//  BlazeFlow
//
//  Created by Roy Derks on 25/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlazeFlow;

@interface BlazeFlowNavigationController : UINavigationController

@property(nonatomic,strong) UIBarButtonItem *leftButtonItemFirstState;
@property(nonatomic,strong) UIBarButtonItem *rightButtonItem;

@property(nonatomic,strong) BlazeFlow *blazeFlow;
@property(nonatomic,assign) BOOL showRightBarItemOnFirstState;
@property(nonatomic,assign) BOOL showRightBarItem;
@property(nonatomic,assign) BOOL showLeftBarItemOnFirstState;

-(instancetype)initWithBlazeFlow:(BlazeFlow*)blazeFlow;

@end
