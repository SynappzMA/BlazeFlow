//
//  BlazeFlowTree.h
//  BlazeFlow
//
//  Created by Roy Derks on 04/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import "BlazeFlow.h"

@interface BlazeFlowTree : BlazeFlow

@property(nonatomic,assign) NSInteger nextState;
@property(nonatomic,strong) NSMutableArray<NSNumber*> *previousStates;

@end
