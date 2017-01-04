//
//  TreeFlow.h
//  BlazeFlow
//
//  Created by Roy Derks on 04/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import "BlazeFlowTree.h"

typedef NS_ENUM(NSInteger, TreeFlowState) {
    TreeFlowStateNone,
    TreeFlowStateInitial = 1,
    TreeFlowState11 = 11,
    TreeFlowState12 = 12,
    TreeFlowState13 = 13,
    TreeFlowState21 = 21,
    TreeFlowState22 = 22,
    TreeFlowState31 = 31,
    TreeFlowState41 = 41,
    TreeFlowState42 = 42,
    TreeFlowState43 = 43
};

@interface TreeFlow : BlazeFlowTree

@end
