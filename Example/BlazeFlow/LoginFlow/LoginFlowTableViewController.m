//
//  LoginFlowTableViewController.m
//  BlazeFlow
//
//  Created by Roy Derks on 26/11/2016.
//  Copyright © 2016 Roy Derks. All rights reserved.
//

#import "LoginFlow.h"
#import "LoginFlowTableViewController.h"

@interface LoginFlowTableViewController ()

@end

@implementation LoginFlowTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.loadContentOnAppear = false;
    [self loadTableContent];
}

-(void)loadTableContent
{
    //Clear
    [self.tableArray removeAllObjects];
    
    //Blaze
    BlazeSection *section = [self.loginFlow sectionForState:self.loginFlow.currentState];
    [self addSection:section];
    self.tableView.scrollEnabled = false;
}


@end
