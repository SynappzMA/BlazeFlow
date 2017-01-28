//
//  NavBasedTableViewController.m
//  BlazeFlow
//
//  Created by Roy Derks on 28/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import "NavBasedTableViewController.h"

@interface NavBasedTableViewController ()

@end

@implementation NavBasedTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *v = [[UIView alloc] initWithFrame:self.view.bounds];
    [v setBackgroundColor:[UIColor blueColor]];
    self.tableView.backgroundView = v;
}

@end
