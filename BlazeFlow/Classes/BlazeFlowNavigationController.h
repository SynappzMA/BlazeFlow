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

@property(nonatomic,strong) BlazeFlow *blazeFlow;

/* Pagecontrol getter */
@property(nonatomic,strong,readonly) UIPageControl *pageControl;

/* Designated initializer */
-(instancetype)initWithBlazeFlow:(BlazeFlow*)blazeFlow;

/* Overridable methods */

/**
 @description Override this method if you want to customize UIBarButtonItems for the different viewControllers.
 Default implementation uses the BlazeFlowNavigationConfiguration object if present to present its different UIBarButtonItems as provided by the configuration.

 @param navigationController the presenting BlazeFlowNavigationController
 @param viewController the currently presented BlazeFlowTableViewController
 */
-(void)configureDefaultNavbarButtons:(UINavigationController*)navigationController viewController:(UIViewController*)viewController;

/* Overridable methods */
-(void)previousOnFirstState;
-(void)nextOnLastState;
-(void)currentStateChanged:(NSInteger)currentState;
-(void)close;


@end
