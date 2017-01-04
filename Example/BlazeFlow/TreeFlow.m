//
//  TreeFlow.m
//  BlazeFlow
//
//  Created by Roy Derks on 04/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import "TreeFlow.h"
@import Blaze;

@implementation TreeFlow

-(BlazeSection *)sectionForState:(NSInteger)state
{
    BlazeSection *section = [BlazeSection new];
    [section addRow:[BlazeRow rowWithXibName:@"CardTopSection"]];
    
    BlazeRow *row = [BlazeRow rowWithXibName:@"CardTitleTableViewCell"];
    row.title = [NSString stringWithFormat:@"This is state nr. %ld", state];
    [section addRow:row];
    
    NSArray<BlazeRow*> *buttonRows;
    
    switch (state) {
        case TreeFlowStateNone:
        case TreeFlowStateInitial:
            break;
        case TreeFlowState11:
            buttonRows = [self rowsForState11];
            break;
        case TreeFlowState12:
            buttonRows = [self rowsForState12];
            break;
        case TreeFlowState13:
            buttonRows = [self rowsForState13];
            break;
        case TreeFlowState21:
            buttonRows = [self rowsForState21];
            break;
        case TreeFlowState22:
            buttonRows = [self rowsForState22];
            break;
        case TreeFlowState31:
            buttonRows = [self rowsForState31];
            break;
        case TreeFlowState41:
            buttonRows = [self rowsForState41];
            break;
        case TreeFlowState42:
            buttonRows = [self rowsForState42];
            break;
        case TreeFlowState43:
            buttonRows = [self rowsForState43];
            break;
        default:
            break;
    }
    for(id x in buttonRows) {
        [section addRow:x];
    }
    
    [section addRow:[BlazeRow rowWithXibName:@"CardBottomSection"]];
    return section;
}

-(BlazeRow*)buttonRowWithNextState:(NSInteger)nextState
{
    BlazeRow *row = [BlazeRow rowWithXibName:@"CardButtonTableViewCell"];
    row.buttonCenterTitle = [NSString stringWithFormat:@"Next : %ld", nextState];
    __weak typeof(self) weakSelf = self;
    row.buttonCenterTapped = ^{
        weakSelf.nextState = nextState;
        weakSelf.stateFinished();
    };
    return row;
}

-(BlazeRow*)buttonRowWithFinish:(NSInteger)currentState
{
    BlazeRow *row = [BlazeRow rowWithXibName:@"CardButtonTableViewCell"];
    row.buttonCenterTitle = [NSString stringWithFormat:@"Last state! : %ld", currentState];
    __weak typeof(self) weakSelf = self;
    row.buttonCenterTapped = ^{
        weakSelf.nextState = 0;
        weakSelf.stateFinished();
    };
    return row;
}


-(NSArray<BlazeRow*>*)rowsForState11
{
    return @[[self buttonRowWithNextState:12], [self buttonRowWithNextState:21]];
}

-(NSArray<BlazeRow*>*)rowsForState12
{
    return @[[self buttonRowWithNextState:13], [self buttonRowWithNextState:31]];
}

-(NSArray<BlazeRow*>*)rowsForState13
{
    return @[[self buttonRowWithFinish:TreeFlowState13]];
}

-(NSArray<BlazeRow*>*)rowsForState21
{
    return @[[self buttonRowWithNextState:22], [self buttonRowWithNextState:41]];
}

-(NSArray<BlazeRow*>*)rowsForState22
{
    return @[[self buttonRowWithFinish:TreeFlowState22]];
}

-(NSArray<BlazeRow*>*)rowsForState31
{
    return @[[self buttonRowWithFinish:TreeFlowState31], [self buttonRowWithNextState:41]];
}

-(NSArray<BlazeRow*>*)rowsForState41
{
    return @[[self buttonRowWithNextState:42]];
}

-(NSArray<BlazeRow*>*)rowsForState42
{
    return @[[self buttonRowWithNextState:43]];
}

-(NSArray<BlazeRow*>*)rowsForState43
{
    return @[[self buttonRowWithFinish:TreeFlowState43]];
}

@end
