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
    if(currentState <= 1) {
        [self shouldDisplayAccessories:false];
    } else {
        [self shouldDisplayAccessories:true];
    }
}

-(void)nextOnLastState
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Last state reached!" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"General_Ok", nil) style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:true completion:nil];
}

-(void)previousOnFirstState
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"First state reached!" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"General_Ok", nil) style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:true completion:nil];
}

-(void)close
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Closing!" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"General_Ok", nil) style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:true completion:nil];
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

-(BlazeFlow *)initializeBlazeFlow
{
    LoginFlow *loginFlow = [LoginFlow new];
    
    loginFlow.numberOfStates = LoginStateDone;
    loginFlow.currentState = LoginStateLogin;
    
    /*
    loginFlow.currentSkippableType = BlazeFlowSkippableTypeSkip;
    loginFlow.skippableTypeSkipFirstState = LoginStateName;
    */
    
    return loginFlow;
}

@end
