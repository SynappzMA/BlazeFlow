//
//  TreeViewController.m
//  BlazeFlow
//
//  Created by Roy Derks on 04/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import "TreeViewController.h"
#import "TreeFlow.h"

@interface TreeViewController ()

@end

@implementation TreeViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.blazeFlow = [TreeFlow new];
    self.blazeFlow.currentState = TreeFlowState11;
    [super prepareForSegue:segue sender:sender];
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
