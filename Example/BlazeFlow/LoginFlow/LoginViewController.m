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
    self.pageControl.numberOfPages -=1;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"currentState"]) {
        if(self.blazeFlow.currentSkippableType == BlazeFlowSkippableTypeSkip || self.blazeFlow.currentSkippableType == BlazeFlowSkippableTypePartialSkip){
            self.pageControl.currentPage = MAX(0,[change[NSKeyValueChangeNewKey] integerValue]-self.blazeFlow.skippableTypeSkipFirstState-1);
        } else {
            self.pageControl.currentPage = MAX(0,[change[NSKeyValueChangeNewKey] integerValue]-2);
        }
    }
}

-(BOOL)next
{
    BOOL result = [super next];
    if(result) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Last state reached!" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"General_Ok", nil) style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
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
        case 0:
        {
            [self.backContainerView hideWithDuration:duration];
            [self.pageControl hideWithDuration:duration];
            break;
        }
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
    /*
    self.blazeFlow.currentSkippableType = BlazeFlowSkippableTypeSkip;
    self.blazeFlow.skippableTypeSkipFirstState = LoginStateName;
    */
    [super prepareForSegue:segue sender:sender];
}

@end
