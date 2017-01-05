//
//  LoginFlow.m
//  BlazeFlow
//
//  Created by Roy Derks on 26/11/2016.
//  Copyright © 2016 Roy Derks. All rights reserved.
//

#import "User.h"
#import "BlazeFlowTableViewController.h"
#import "BlazeRow.h"
#import "LoginFlow.h"
#import "BlazeSection.h"

@interface LoginFlow()


@end

@implementation LoginFlow

-(instancetype)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    self.user = [User new];
    return self;
}

#pragma mark - State logic

-(BlazeSection *)sectionForState:(NSInteger)state
{
    BlazeSection *section = [BlazeSection new];
    NSMutableArray<BlazeRow*> *rows = [NSMutableArray new];
    [rows addObject:[BlazeRow rowWithXibName:@"CardTopSection"]];
    BlazeRow *row = [BlazeRow rowWithXibName:kCardMiddleSection];
    row.rowHeight = 34.0f;
    [rows addObject:row];
    
    switch (state) {
        case LoginStateLogin:
            [rows addObjectsFromArray:[self loginRows]];
            break;
        case LoginStateName:
            [rows addObjectsFromArray:[self nameRows]];
            break;
        case LoginStateMessage:
            [rows addObjectsFromArray:[self messageRows]];
            break;
        case LoginStateDone:
            [rows addObjectsFromArray:[self doneRows]];
             break;
    }
    [rows addObject:[BlazeRow rowWithXibName:@"CardBottomSection"]];
    section.rows = rows;
    return section;
}

#pragma mark - Rows for section

-(NSArray<BlazeRow*>*)loginRows
{
    NSMutableArray<BlazeRow*>* rows = [NSMutableArray new];
    BlazeRow *row;
    
    row = [BlazeRow rowWithXibName:kCardTitleTableViewCell];
    row.title = @"Hey there!";
    [rows addObject:row];
    
    row = [BlazeRow rowWithXibName:kCardMiddleSection];
    row.rowHeight = 22.0f;
    [rows addObject:row];
    
    row = [BlazeRow rowWithXibName:kCardTextFieldTableViewCell];
    row.placeholder = @"Email address";
    row.floatingTitle = @"Email";
    row.floatingLabelEnabled = true;
    [row setAffectedObject:self.user affectedPropertyName:[self.user stringForPropertyName:@selector(email)]];
    [rows addObject:row];
    
    row = [BlazeRow rowWithXibName:kCardTextFieldTableViewCell];
    row.placeholder = @"Password";
    row.floatingTitle = @"Password";
    row.floatingLabelEnabled = true;
    __block NSString *password = nil;
    __weak typeof(row) weakRow = row;
    row.valueChanged = ^{
        password = weakRow.value;
    };
    [rows addObject:row];
    
    row = [BlazeRow rowWithXibName:kCardForgotPasswordTableViewCell];
    row.buttonRightTitle = @"Forgot password?";
    row.buttonRightTapped = ^{
        
        [self alertWithMessage:@"Todo!"];
        
    };
    [rows addObject:row];
    
    row = [BlazeRow rowWithXibName:kCardButtonTableViewCell];
    row.buttonCenterTitle = @"Login";
    row.buttonCenterTapped = ^{
        /*if(!self.user.email.length) {
            [self alertWithMessage:@"Please provide an email address"];
        } else if(!password.length) {
            [self alertWithMessage:@"Please provide a password"];
        }
        else {
            if(self.stateFinished) {
                self.stateFinished();
            }
        }*/
        if(self.stateFinished) {
            self.stateFinished();
        }
    };
    [rows addObject:row];
    
    return rows;
}

-(NSArray<BlazeRow*>*)nameRows
{
    NSMutableArray<BlazeRow*>* rows = [NSMutableArray new];
    BlazeRow *row;
    
    row = [BlazeRow rowWithXibName:kCardTitleTableViewCell];
    row.title = @"This is the second state!";
    [rows addObject:row];
    
    row = [BlazeRow rowWithXibName:kCardMiddleSection];
    row.rowHeight = 22.0f;
    [rows addObject:row];
    
    row = [BlazeRow rowWithXibName:kCardTextFieldTableViewCell];
    row.placeholder = @"Message";
    row.floatingTitle = @"Type a message";
    row.floatingLabelEnabled = true;
    [rows addObject:row];
    
    row = [BlazeRow rowWithXibName:kCardButtonTableViewCell];
    row.buttonCenterTitle = @"Continue!";
    row.buttonCenterTapped = ^{
        if(self.stateFinished) {
            self.stateFinished();
        }
    };
    [rows addObject:row];
    return rows;
}

-(NSArray<BlazeRow*>*)messageRows
{
    NSMutableArray<BlazeRow*>* rows = [NSMutableArray new];
    BlazeRow *row;
    
    row = [BlazeRow rowWithXibName:kCardTitleTableViewCell];
    row.title = @"Another state";
    [rows addObject:row];
    
    row = [BlazeRow rowWithXibName:kCardMiddleSection];
    row.rowHeight = 22.0f;
    [rows addObject:row];
    
    row = [BlazeRow rowWithXibName:kCardButtonTableViewCell];
    row.buttonCenterTitle = @"Forwards!";
    row.buttonCenterTapped = ^{
        if(self.stateFinished) {
            self.stateFinished();
        }
    };
    [rows addObject:row];
    return rows;
}

-(NSArray<BlazeRow*>*)doneRows
{
    NSMutableArray<BlazeRow*>* rows = [NSMutableArray new];
    BlazeRow *row;
    
    row = [BlazeRow rowWithXibName:kCardTitleTableViewCell];
    row.title = @"You're all done!";
    [rows addObject:row];
    
    row = [BlazeRow rowWithXibName:kCardMiddleSection];
    row.rowHeight = 22.0f;
    [rows addObject:row];
    
    row = [BlazeRow rowWithXibName:kCardButtonTableViewCell];
    row.buttonCenterTitle = @"Done!";
    row.buttonCenterTapped = ^{
        if(self.stateFinished) {
            self.stateFinished();
        }
    };
    [rows addObject:row];
    return rows;
}



@end
