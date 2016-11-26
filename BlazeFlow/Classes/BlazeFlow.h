//
//  BlazeFlow.h
//  Pods
//
//  Created by Roy Derks on 25/11/2016.
//
//

@import Foundation;
#import "BlazeTableViewController.h"

@class BlazeRow, BlazeSection;

@interface BlazeFlow : NSObject

@property(nonatomic,assign) NSInteger numberOfStates;
@property(nonatomic,assign) NSInteger currentState;
@property(nonatomic,copy) void (^shouldDisplayAccessoires)(NSInteger display);
@property(nonatomic,copy) void (^stateFinishedSuccesfully)();
@property(nonatomic,strong) BlazeTableViewController *blazeTableViewController;

-(BlazeSection*)sectionForState:(NSInteger)state;
-(BOOL)isLastState:(NSInteger)state;
-(BOOL)isFirstState:(NSInteger)state;
-(void)alertWithMessage:(NSString*)message;

//Returns true if can't go forwards
-(BOOL)next;
//Return true if can't go backwards
-(BOOL)previous;

@end
