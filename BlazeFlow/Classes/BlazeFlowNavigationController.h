//
//  BlazeFlowNavigationController.h
//  BlazeFlow
//
//  Created by Roy Derks on 25/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

@import UIKit;

@class BlazeFlow;

@protocol BlazeFlowNavigationControllerDelegate <NSObject>

@optional
//Show/hide
-(BOOL)blazeFlowNavigationControllerShouldShowRightBarItemForState:(NSInteger)state;
-(BOOL)blazeFlowNavigationControllerShouldShowLeftBarItemForState:(NSInteger)state;
-(BOOL)blazeFlowNavigationControllerShouldHideBackLeftBarItemForState:(NSInteger)state;
-(BOOL)blazeFlowNavigationControllerShouldShowPageControlForState:(NSInteger)state;

//Titles
-(NSString*)blazeFlowNavigationControllerRightBarItemTitleForState:(NSInteger)state;
-(NSString*)blazeFlowNavigationControllerLeftBarItemTitleForState:(NSInteger)state;
-(NSString*)blazeFlowNavigationControllerRightBarItemImageNameForState:(NSInteger)state;
-(NSString*)blazeFlowNavigationControllerLeftBarItemImageNameForState:(NSInteger)state;

//Actions
-(void)blazeFlowNavigationControllerRightBarItemTappedForState:(NSInteger)state;
-(void)blazeFlowNavigationControllerLeftBarItemTappedForState:(NSInteger)state;

//Pagecontrol
-(NSInteger)blazeFlowNavigationControllerAmountOfPageForPageControl;
-(NSTimeInterval)blazeFlowNavigationControllerAnimationDurationForPageControl;
-(void)customizePageControl:(UIPageControl*)pageControl;
-(Class)classForPageControl;

//Custom view
-(UIView*)customBottomViewForState:(NSInteger)state;

@end


@interface BlazeFlowNavigationController : UINavigationController

@property(nonatomic,strong) BlazeFlow *blazeFlow;
@property(nonatomic) id<BlazeFlowNavigationControllerDelegate> blazeFlowNavigationControllerDelegate;

/* Pagecontrol getter */
@property(nonatomic,strong,readonly) UIPageControl *pageControl;

/* Designated initializer */
-(instancetype)initWithBlazeFlow:(BlazeFlow*)blazeFlow;

/* Overridable methods */
-(void)previousOnFirstState;
-(void)nextOnLastState;
-(void)currentStateChanged:(NSInteger)currentState;
-(void)close;


@end
