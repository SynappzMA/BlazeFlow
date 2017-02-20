//
//  NavbasedNavigationController.m
//  BlazeFlow
//
//  Created by Roy Derks on 20/02/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import "NavbasedNavigationController.h"
#import "LoginFlow.h"

@interface NavbasedNavigationController () <BlazeFlowNavigationControllerDelegate>

@end

@implementation NavbasedNavigationController

-(void)viewDidLoad
{
    self.blazeFlowNavigationControllerDelegate = self;
    [super viewDidLoad];
}

-(NSInteger)blazeFlowNavigationControllerAmountOfPageForPageControl
{
    return self.blazeFlow.numberOfStates-1;
}

-(BOOL)blazeFlowNavigationControllerShouldShowPageControlForState:(NSInteger)state
{
    return state > 1;
}

-(BOOL)blazeFlowNavigationControllerShouldShowLeftBarItemForState:(NSInteger)state
{
    return state == 1;
}

-(BOOL)blazeFlowNavigationControllerShouldShowRightBarItemForState:(NSInteger)state
{
    return state > 1;
}

-(NSString *)blazeFlowNavigationControllerLeftBarItemTitleForState:(NSInteger)state
{
    return @"Lefttitle";
}

-(NSString *)blazeFlowNavigationControllerRightBarItemImageNameForState:(NSInteger)state
{
    return @"Icon_Close";
}

-(void)blazeFlowNavigationControllerLeftBarItemTappedForState:(NSInteger)state
{
    NSLog(@"Left tapped!");
}

-(void)blazeFlowNavigationControllerRightBarItemTappedForState:(NSInteger)state
{
    NSLog(@"Right tapped!");
}

@end
