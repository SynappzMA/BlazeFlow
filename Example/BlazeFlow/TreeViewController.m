//
//  TreeViewController.m
//  BlazeFlow
//
//  Created by Roy Derks on 04/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import "TreeViewController.h"
#import "TreeFlow.h"
#import "BlazeFlowNavigationController.h"

@interface TreeViewController ()

@end

@implementation TreeViewController

//Test navigationController

-(void)viewDidAppear:(BOOL)animated
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [super viewDidAppear:animated];
        BlazeFlowNavigationController *navCon = [[BlazeFlowNavigationController alloc] initWithBlazeFlow:self.blazeFlow];
        [self presentViewController:navCon animated:true completion:nil];
    });
}

-(BlazeFlow *)initializeBlazeFlow
{
    TreeFlow *treeFlow = [TreeFlow new];
    treeFlow.currentState = TreeFlowState11;
    return treeFlow;
}

-(void)nextOnLastState
{
    [self.blazeFlow alertWithMessage:@"Last state reached!"];
}

-(void)previousOnFirstState
{
    [self.blazeFlow alertWithMessage:@"First state reached!"];
}

@end
