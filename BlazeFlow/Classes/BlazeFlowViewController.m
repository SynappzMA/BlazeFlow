//
//  blazeFlowViewController.m
//  Clinicards
//
//  Created by Roy Derks on 01/12/2016.
//  Copyright © 2016 Synappz BV. All rights reserved.
//

#import "BlazeFlow.h"
#import "BlazeFlowViewController.h"
#import "BlazeFlowTableViewController.h"

@interface BlazeFlowViewController ()

@end

@implementation BlazeFlowViewController

-(instancetype)init
{
    self = [super init];
    if(!self) {
        return nil;
    }
    self.blazeFlowTableViewControllerClass = [BlazeTableViewController class];
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.pageControl.numberOfPages = self.blazeFlow.numberOfStates;
}

#pragma mark IBActions

-(IBAction)closeTapped
{
    [self close];
}

-(void)stateFinished
{
    [self next];
}

-(IBAction)previousTapped
{
    [self previous];
}

#pragma mark Setup

-(void)setupBlazeFlow
{
    self.blazeFlow.blazeFlowTableViewController = self.blazeFlowTableViewController;
    
    __weak typeof(self) weakSelf = self;
    self.blazeFlow.stateFinished = ^() {
        [weakSelf stateFinished];
    };
    self.blazeFlow.currentStateChanged = ^(NSInteger currentState) {
        [weakSelf currentStateChanged:currentState];
    };
    self.blazeFlow.nextOnLastState = ^() {
        [weakSelf nextOnLastState];
    };
    self.blazeFlow.previousOnFirstState = ^() {
        [weakSelf previousOnFirstState];
    };
}

#pragma mark Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    Class class = !self.blazeFlowTableViewControllerClass?[BlazeFlowTableViewController class]:self.blazeFlowTableViewControllerClass;
    if([segue.identifier isEqualToString:NSStringFromClass(class)]) {
        self.blazeFlowTableViewController = segue.destinationViewController;
        [self setupBlazeFlow];
    }
}

#pragma mark - Overridable methods

-(void)currentStateChanged:(NSInteger)currentState
{
    //To override
}

-(void)stateFinishedSuccesfully
{
    //To override
}

-(void)previous
{
    [self.blazeFlow previous];
}

-(void)next
{
    [self.blazeFlow next];
}

-(void)previousOnFirstState
{
    //To override
}

-(void)nextOnLastState
{
    //To override
}

-(void)close
{
    [self.blazeFlow close];
}

@end







































