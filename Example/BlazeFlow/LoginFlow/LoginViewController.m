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
#import "BlazeFlowNavigationController.h"
#import "BlazeFlowNavigationControllerConfiguraton.h"
#import "NavBasedTableViewController.h"

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

//Test navigationController

-(void)viewDidAppear:(BOOL)animated
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [super viewDidAppear:animated];
        BlazeFlow *flow = [self initializeBlazeFlow];
        flow.blazeFlowTableViewControllerSubclass = [NavBasedTableViewController class];
        
        BlazeFlowNavigationControllerConfiguraton *conf = [BlazeFlowNavigationControllerConfiguraton new];
        conf.showPageControl = true;
        conf.pageControlAmountOfPages = 5;
        conf.showRightBarItem = true;
        conf.rightBarItemTitle = @"Close";
        
        BlazeFlowNavigationController* navCon = [[BlazeFlowNavigationController alloc] initWithBlazeFlow:flow];
        __weak typeof(navCon) weakNavCon = navCon;
        conf.rightBarItemAction = ^{
            [weakNavCon dismissViewControllerAnimated:true completion:nil];
        };
        
        flow.blazeFlowNavigationControllerConfiguraton = conf;
        [self presentViewController:navCon animated:true completion:nil];
    });
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
