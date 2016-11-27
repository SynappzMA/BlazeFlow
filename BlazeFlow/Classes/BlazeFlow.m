//
//  BlazeFlow.m
//  Pods
//
//  Created by Roy Derks on 25/11/2016.
//
//

#import "BlazeFlow.h"

@interface BlazeFlow()

@end

@implementation BlazeFlow

-(BOOL)isFirstState:(NSInteger)state
{
    //Override
    return false;
}

-(BOOL)isLastState:(NSInteger)state
{
    //Override
    return false;
}

-(BlazeSection *)sectionForState:(NSInteger)state
{
    //Override
    return nil;
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


-(void)alertWithMessage:(NSString*)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"General_OK", nil) style:UIAlertActionStyleCancel handler:nil]];
    [self.blazeTableViewController presentViewController:alertController animated:true completion:nil];
}

@end
