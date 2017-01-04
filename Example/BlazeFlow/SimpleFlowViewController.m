//
//  SimpleFlowViewController.m
//  BlazeFlow
//
//  Created by Roy Derks on 04/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import "SimpleFlowViewController.h"
#import "SimpleFlow.h"

@interface SimpleFlowViewController ()

@end

@implementation SimpleFlowViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.backLabel.text = NSLocalizedString(@"BlazeFlow_Navbar_Item_Cancel", nil);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.blazeFlow = [SimpleFlow new];
    self.blazeFlow.numberOfStates = 5;
    self.blazeFlow.currentState = 1;
    [super prepareForSegue:segue sender:sender];
}

-(void)currentStateChanged:(NSInteger)currentState
{
    self.backLabel.text = currentState == 1? NSLocalizedString(@"BlazeFlow_Navbar_Item_Cancel", nil):NSLocalizedString(@"BlazeFlow_Navbar_Item_Back", nil);
    self.pageControl.currentPage = MAX(0,currentState-1);
}

-(BOOL)previous
{
    BOOL firstStateImminent = [self.blazeFlow isFirstState:self.blazeFlow.currentState-1];
    if(firstStateImminent) {
        self.backLabel.text = NSLocalizedString(@"BlazeFlow_Navbar_Item_Cancel", nil);
    }
    BOOL previousOnLastState = [super previous];
    if(previousOnLastState) {
        //Do stuff, for example, dismiss this viewController
        [self.blazeFlow alertWithMessage:@"First state reached!"];
    }
    return previousOnLastState;
}

-(BOOL)next
{
    if([self.backLabel.text isEqualToString:NSLocalizedString(@"BlazeFlow_Navbar_Item_Cancel", nil)]) {
        self.backLabel.text = NSLocalizedString(@"BlazeFlow_Navbar_Item_Back", nil);
    }
    
    BOOL nextOnLastState = [super next];
    if(nextOnLastState) {
        //Do stuff, for example, dismiss this viewController
        [self.blazeFlow alertWithMessage:@"Last state reached!"];
    }
    return nextOnLastState;
}

-(BOOL)close
{
    return [super close];
}

@end
