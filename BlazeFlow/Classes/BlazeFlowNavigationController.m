//
//  BlazeFlowNavigationController.m
//  BlazeFlow
//
//  Created by Roy Derks on 25/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import "BlazeFlowNavigationController.h"
#import "BlazeFlow.h"
#import "BlazeFlowTableViewController.h"
#import "BlazeFlowTree.h"

@interface BlazeFlowNavigationController () <UINavigationControllerDelegate>

@end

@implementation BlazeFlowNavigationController

-(instancetype)initWithBlazeFlow:(BlazeFlow*)blazeFlow
{
    BlazeFlowTableViewController *vc = [[BlazeFlowTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.blazeFlow = vc.blazeFlow = blazeFlow;
    __weak typeof(self) weakSelf = self;
    self.blazeFlow.stateFinished = ^{
        [weakSelf pushNextBlazeState];
    };
    self.blazeFlow.nextOnLastState = ^{
        NSLog(@"Last state reached");
    };
    self.blazeFlow.previousOnFirstState = ^{
        NSLog(@"First state reached");
    };
    self = [super initWithRootViewController:vc];
    if(self) {
        self.delegate = self;
    }
    return self;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if(navigationController.viewControllers.count != 1 && !self.showRightBarItem) {
        return;
    } else if(navigationController.viewControllers.count != 1 && self.showRightBarItem) {
        UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"BlazeFlow_RightBarItem_Title" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarItemAction)];
        [viewController.navigationItem setRightBarButtonItem:rightBarItem];
    } else if(self.viewControllers.count == 1) {
        if(self.showLeftBarItemOnFirstState) {
            UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"BlazeFlow_LeftBarItemOnFirstState_Title" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarItemAction)];
            [viewController.navigationItem setLeftBarButtonItem:leftBarItem];
        }
        if(self.showRightBarItemOnFirstState) {
            UIBarButtonItem *rightBarItemFirstState = [[UIBarButtonItem alloc] initWithTitle:@"BlazeFlow_RightBarItemOnFirstState_Title" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarItemActionFirstState)];
            [viewController.navigationItem setRightBarButtonItem:rightBarItemFirstState];
        }
    }
    
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    id poppedViewController = [super popViewControllerAnimated:animated];
    if(poppedViewController) {
        if([self.blazeFlow isKindOfClass:[BlazeFlowTree class]]) {
            [((BlazeFlowTree*)self.blazeFlow).previousStates removeLastObject];
        } else {
            self.blazeFlow.currentState--;
        }
    } else {
        [self previousOnFirstState];
    }
    return poppedViewController;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
}

-(void)pushNextBlazeState
{
    //For tree Flow set the correct state
    if([self.blazeFlow isKindOfClass:[BlazeFlowTree class]]) {
        [((BlazeFlowTree
           *)self.blazeFlow).previousStates addObject:@(self.blazeFlow.currentState)];
        self.blazeFlow.currentState = ((BlazeFlowTree
                                        *)self.blazeFlow).nextState;
    }
    if(self.blazeFlow.currentState == 0) {
        [self nextOnLastState];
        return;
    }
    else if([self.blazeFlow isLastState:self.blazeFlow.currentState]
            && ![self.blazeFlow isKindOfClass:[BlazeFlowTree class]])
    {
        [self nextOnLastState];
        return;
    }
    else if(![self.blazeFlow isKindOfClass:[BlazeFlowTree class]]){
        self.blazeFlow.currentState++;
    }

    [self pushViewController:[self blazeFlowTableViewController] animated:true];
}

#pragma mark - BlazeFlow

-(BlazeFlowTableViewController*)blazeFlowTableViewController
{
    BlazeFlowTableViewController *blazeFlowTableViewController = [[BlazeFlowTableViewController alloc] initWithStyle:UITableViewStylePlain];
    blazeFlowTableViewController.blazeFlow = self.blazeFlow;
    return blazeFlowTableViewController;
}

-(void)previousOnFirstState
{
    [self close];
}

-(void)nextOnLastState
{
    [self close];
}

#pragma Actions

-(void)leftBarItemAction
{
    [self close];
}

-(void)rightBarItemActionFirstState
{
    [self close];
}

-(void)rightBarItemAction
{
    [self close];
}

-(void)close
{
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
