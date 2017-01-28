//
//  BlazeFlowNavigationConfiguraton.h
//  BlazeFlow
//
//  Created by Roy Derks on 28/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlazeFlowNavigationControllerConfiguraton : NSObject

#pragma mark UIBarButtomItem configuration

/* Setting the show property to true adds a UIBarButtonItem to the corresponding viewController(s). For more specific situations you must override -configureDefaultNavbarButtons:viewController: on BlazeFlowNavigationController */
@property(nonatomic,assign) BOOL showRightBarItemOnFirstState;
@property(nonatomic,assign) BOOL showRightBarItem;
@property(nonatomic,assign) BOOL showLeftBarItemOnFirstState;


/* Localization properties for the optional UIBarButtonItems */
@property(nonatomic,strong) NSString *leftBarItemOnFirstStateTitle;
@property(nonatomic,strong) NSString *rightBarItemTitle;
@property(nonatomic,strong) NSString *rightBarItemOnFirstStateTitle;

/* Action block for the optional UIBarButtonItem */
@property(nonatomic,copy) void (^rightBarItemAction)();
@property(nonatomic,copy) void (^leftBarItemActionOnFirstState)();
@property(nonatomic,copy) void (^rightBarItemActionOnFirstState)();

#pragma mark UIPageControl configuration

@property(nonatomic,assign) BOOL showPageControl;
@property(nonatomic,assign) NSUInteger  pageControlAmountOfPages;

@end
