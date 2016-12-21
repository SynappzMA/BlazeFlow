//
//  BlazeFlow.m
//  Pods
//
//  Created by Roy Derks on 25/11/2016.
//
//

@import Blaze;

#import "BlazeFlow.h"


@interface BlazeFlow()

@end

@implementation BlazeFlow

#pragma mark State
-(BOOL)isFirstState:(NSInteger)state
{
    if(state <= 1 && (self.currentSkippableType == BlazeFlowSkippableTypeNone || self.currentSkippableType == BlazeFlowSkippableTypeDontSkip)) {
        return true;
    } else if(state <= self.skippableTypeSkipFirstState) {
        return true;
    }
    return false;
}

-(BOOL)isLastState:(NSInteger)state
{
    NSLog(@"LastState : %ld", self.numberOfStates+self.skippableTypeSkipFirstState-1);
    NSLog(@"test state : %ld", state);
    BOOL result = false;
    NSInteger calcState = state;
    if(state >= self.numberOfStates && (self.currentSkippableType == BlazeFlowSkippableTypeNone || self.currentSkippableType == BlazeFlowSkippableTypeDontSkip)) {
        result = true;
    } else if(state-self.skippableTypeSkipFirstState+1 >= self.numberOfStates && self.currentSkippableType == BlazeFlowSkippableTypeSkip) {
        calcState = state-self.skippableTypeSkipFirstState+1;
        result = true;
    }
    if(self.currentSkippableType == BlazeFlowSkippableTypeSkip || self.currentSkippableType == BlazeFlowSkippableTypePartialSkip){
        if(calcState+1 >= self.numberOfStates) {
            if(self.shouldDisplayaccessories) {
                self.shouldDisplayaccessories(1);
            }
        } else {
            if(self.shouldDisplayaccessories) {
                self.shouldDisplayaccessories(0);
            }
        }
    }
    return result;
}

-(void)setNumberOfStates:(NSInteger)numberOfStates
{
    _numberOfStates = numberOfStates;
    if(_skippableTypeSkipFirstState) {
        _numberOfStates -= (_skippableTypeSkipFirstState-1);
    }
}


-(void)setSkippableTypeSkipFirstState:(NSInteger)skippableTypeSkipFirstState
{
    _skippableTypeSkipFirstState = skippableTypeSkipFirstState;
    self.currentState = skippableTypeSkipFirstState;
    if(_numberOfStates) {
        _numberOfStates -= (_skippableTypeSkipFirstState-1);
    }
}

-(void)setCurrentState:(NSInteger)currentState
{
    if(self.currentSkippableType == BlazeFlowSkippableTypeDontSkip || BlazeFlowSkippableTypeNone) {
        _currentState = currentState;
    } else {
        _currentState = currentState;
    }
}

-(void)close
{
    //To override
    if(self.closedSuccesfully) {
        self.closedSuccesfully(false);
    }
}

-(BOOL)next
{
    if([self isLastState:self.currentState]) {
        return true;
    }
    self.currentState++;
    [self.blazeTableViewController loadTableContent];
        
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFillMode:kCAFillModeBoth];
    [animation setDuration:.3];
    [[self.blazeTableViewController.tableView layer] addAnimation:animation forKey:@"UITableViewReloadDataAnimationKey"];
    [self.blazeTableViewController.tableView reloadData];
    
    return false;
}

-(BOOL)previous
{
    if([self isFirstState:self.currentState]) {
        return true;
    }
    self.currentState--;
    [self.blazeTableViewController loadTableContent];
    
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFillMode:kCAFillModeBoth];
    [animation setDuration:.3];
    [[self.blazeTableViewController.tableView layer] addAnimation:animation forKey:@"UITableViewReloadDataAnimationKey"];
    [self.blazeTableViewController.tableView reloadData];
    
    return false;
}

#pragma mark Flow

-(BlazeSection *)sectionForState:(NSInteger)state
{
    //To override
    return [BlazeSection new];
}

#pragma mark - Utility

-(void)alertWithMessage:(NSString*)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"General_OK", nil) style:UIAlertActionStyleCancel handler:nil]];
    [self.blazeTableViewController presentViewController:alertController animated:true completion:nil];
}

@end
