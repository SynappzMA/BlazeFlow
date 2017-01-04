//
//  LoginViewController.m
//  BlazeFlow
//
//  Created by Roy Derks on 26/11/2016.
//  Copyright © 2016 Roy Derks. All rights reserved.
//

#import "LoginFlow.h"
#import "LoginViewController.h"
#import "UIView+SimpleAnimations.h"
#import "BlazeFlowTableViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.pageControl.numberOfPages = self.blazeFlow.numberOfStates-1;
}

-(void)currentStateChanged:(NSInteger)currentState
{
    [super currentStateChanged:currentState];
    if(((LoginFlow*)self.blazeFlow).currentSkippableType == BlazeFlowSkippableTypeSkip){
        self.pageControl.currentPage = MAX(0,currentState-((LoginFlow*)self.blazeFlow).skippableTypeSkipFirstState-1);
    } else {
        self.pageControl.currentPage = MAX(0,currentState-2);
    }
}

-(BOOL)next
{
    BOOL result = [super next];
    [self shouldDisplayAccessories:true];
    if(result) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Last state reached!" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"General_Ok", nil) style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
    }
    return result;
}

-(BOOL)previous
{
    BOOL result = [super previous];
    if(result) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"First state reached!" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"General_Ok", nil) style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
    } else if([self.blazeFlow isFirstState:self.blazeFlow.currentState]) {
           [self shouldDisplayAccessories:false];
    }
    
    return result;
}

-(BOOL)close
{
    BOOL result = [super close];
    if(result) {
        //Do stuff
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Closing!" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"General_Ok", nil) style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:true completion:nil];
    return result;
}

-(void)shouldDisplayAccessories:(NSInteger)show
{
    NSTimeInterval duration = 0.25;
    switch (show) {
        case -1:
        case false:
        {
            [self.backContainerView hideWithDuration:duration];
            [self.pageControl hideWithDuration:duration];
            break;
        }
        case true:
        default:
            [self.backContainerView showWithDuration:duration];
            [self.pageControl showWithDuration:duration];
            break;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.blazeFlow = [LoginFlow new];
    self.blazeFlow.numberOfStates = LoginStateDone;
    //To test skipabillity uncomment comment block below
    
    //((LoginFlow*)self.blazeFlow).currentSkippableType = BlazeFlowSkippableTypeSkip;
    //((LoginFlow*)self.blazeFlow).skippableTypeSkipFirstState = LoginStateName;
    
    [super prepareForSegue:segue sender:sender];
    [self shouldDisplayAccessories:false];
}

@end
