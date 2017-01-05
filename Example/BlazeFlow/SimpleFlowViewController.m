//
//  SimpleFlowViewController.m
//  BlazeFlow
//
//  Created by Roy Derks on 04/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import "SimpleFlow.h"
#import "SimpleFlowViewController.h"

@interface SimpleFlowViewController ()

@end

@implementation SimpleFlowViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.backLabel.text = NSLocalizedString(@"BlazeFlow_Navbar_Item_Cancel", nil);
}

-(BlazeFlow *)initializeBlazeFlow
{
    SimpleFlow* simpleFlow = [SimpleFlow new];
    simpleFlow.numberOfStates = 5;
    simpleFlow.currentState = 1;
    return simpleFlow;
}

-(void)currentStateChanged:(NSInteger)currentState
{
    [super currentStateChanged:currentState];
    self.backLabel.text = currentState == 1? NSLocalizedString(@"BlazeFlow_Navbar_Item_Cancel", nil):NSLocalizedString(@"BlazeFlow_Navbar_Item_Back", nil);
}

-(void)previousOnFirstState
{
    [self.blazeFlow alertWithMessage:@"First state reached!"];
}

-(void)nextOnLastState
{
    [self.blazeFlow alertWithMessage:@"Last state reached!"];
}

@end
