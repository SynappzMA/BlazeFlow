//
//  SimpleFlow.m
//  BlazeFlow
//
//  Created by Roy Derks on 04/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import "SimpleFlow.h"
#import <Blaze/BlazeTableViewController.h>



@implementation SimpleFlow

-(BlazeSection *)sectionForState:(NSInteger)state
{
    BlazeSection *section = [BlazeSection new];
    [section addRow:[BlazeRow rowWithXibName:@"CardTopSection"]];
    BlazeRow *row = [BlazeRow rowWithXibName:@"CardTitleTableViewCell"];
    row.title = @"Simple!";
    [section addRow:row];
    
    row = [BlazeRow rowWithXibName:@"CardButtonTableViewCell"];
    row.buttonCenterTitle = @"Progress";
    row.buttonCenterTapped = ^{
        if(self.stateFinished) {
            self.stateFinished();
        }
    };
    [section addRow:row];
    [section addRow:[BlazeRow rowWithXibName:@"CardBottomSection"]];
    return section;
}

@end
