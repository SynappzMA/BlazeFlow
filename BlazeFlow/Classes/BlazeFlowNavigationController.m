//
//  BlazeFlowNavigationController.m
//  BlazeFlow
//
//  Created by Roy Derks on 25/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import "BlazeFlowNavigationController.h"
#import "BlazeFlow.h"
#import "BlazeFlowTableViewController.h"
#import "BlazeFlowTree.h"
#import "BlazeFlowNavigationControllerConfiguraton.h"

@interface BlazeFlowNavigationController () <UINavigationControllerDelegate>

@property(nonatomic,assign) NSUInteger currentPageIndex;

@end

#define BFNavConConfig self.blazeFlow.blazeFlowNavigationControllerConfiguraton

@implementation BlazeFlowNavigationController

-(instancetype)initWithBlazeFlow:(BlazeFlow*)blazeFlow
{
    self.blazeFlow = blazeFlow;
    BlazeFlowTableViewController *vc = [self blazeFlowTableViewController];
    
    __weak typeof(self) weakSelf = self;
    self.blazeFlow.stateFinished = ^{
        [weakSelf pushNextBlazeState];
    };
    self.blazeFlow.nextOnLastState = ^{
        NSLog(@"Last state reached");
    };
    self.blazeFlow.previousOnFirstState = ^{
        NSLog(@"First state reached");
    };
    self = [super initWithRootViewController:vc];
    if(self) {
        self.delegate = self;
    }
    self.currentPageIndex = 0;
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!self.pageControl) {
        CGRect f = CGRectMake(0, CGRectGetMaxY(self.view.bounds)-100, CGRectGetWidth(self.view.bounds), 40);
        _pageControl = [[UIPageControl alloc] initWithFrame:f];
        _pageControl.numberOfPages = BFNavConConfig.pageControlAmountOfPages;
        _pageControl.currentPage = self.currentPageIndex;
        [_pageControl sizeToFit];
        CGPoint center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds)-CGRectGetHeight(_pageControl.bounds));
        _pageControl.center = center;
        _pageControl.alpha = 0.0f;
    }
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.pageControl];
}

-(void)viewDidAppear:(BOOL)animated
{
    if(self.pageControl) {
        [UIView animateWithDuration:0.250 animations:^{
            self.pageControl.alpha = 1.0f;
        }];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(self.pageControl) {
        [UIView animateWithDuration:0.250 animations:^{
            self.pageControl.alpha = 0;
        }];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    if(self.pageControl) {
        [self.pageControl removeFromSuperview];
        _pageControl = nil;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self configureDefaultNavbarButtons:navigationController viewController:viewController];
}

-(void)configureDefaultNavbarButtons:(UINavigationController*)navigationController viewController:(UIViewController*)viewController
{
    BlazeFlowNavigationControllerConfiguraton *conf = BFNavConConfig;
    
    if(conf) {
        if(navigationController.viewControllers.count != 1 && !conf.showRightBarItem) {
            return;
        } else if(navigationController.viewControllers.count != 1 && conf.showRightBarItem) {
            UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:conf.rightBarItemTitle style:UIBarButtonItemStyleDone target:self action:@selector(rightBarItemAction)];
            [viewController.navigationItem setRightBarButtonItem:rightBarItem];
        } else if(self.viewControllers.count == 1) {
            if(conf.showLeftBarItemOnFirstState) {
                UIBarButtonItem *leftBarItemOnFirstState = [[UIBarButtonItem alloc] initWithTitle:conf.leftBarItemOnFirstStateTitle style:UIBarButtonItemStyleDone target:self action:@selector(leftBarItemActionOnFirstState)];
                [viewController.navigationItem setLeftBarButtonItem:leftBarItemOnFirstState];
            }
            if(conf.showRightBarItemOnFirstState) {
                UIBarButtonItem *rightBarItemFirstState = [[UIBarButtonItem alloc] initWithTitle:conf.rightBarItemOnFirstStateTitle style:UIBarButtonItemStyleDone target:self action:@selector(rightBarItemActionFirstState)];
                [viewController.navigationItem setRightBarButtonItem:rightBarItemFirstState];
            }
        }
    }
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    self.currentPageIndex--;
    self.pageControl.currentPage = self.currentPageIndex;
    id poppedViewController = [super popViewControllerAnimated:animated];
    if(poppedViewController) {
        if([self.blazeFlow isKindOfClass:[BlazeFlowTree class]]) {
            [((BlazeFlowTree*)self.blazeFlow).previousStates removeLastObject];
        } else {
            self.blazeFlow.currentState--;
        }
    } else {
        [self previousOnFirstState];
    }
    return poppedViewController;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.currentPageIndex++;
    self.pageControl.currentPage = self.currentPageIndex;
    [super pushViewController:viewController animated:animated];
    
}

-(void)pushNextBlazeState
{
    //For tree Flow set the correct state
    if([self.blazeFlow isKindOfClass:[BlazeFlowTree class]]) {
        [((BlazeFlowTree
           *)self.blazeFlow).previousStates addObject:@(self.blazeFlow.currentState)];
        self.blazeFlow.currentState = ((BlazeFlowTree
                                        *)self.blazeFlow).nextState;
    }
    if(self.blazeFlow.currentState == 0) {
        [self nextOnLastState];
        return;
    }
    else if([self.blazeFlow isLastState:self.blazeFlow.currentState]
            && ![self.blazeFlow isKindOfClass:[BlazeFlowTree class]])
    {
        [self nextOnLastState];
        return;
    }
    else if(![self.blazeFlow isKindOfClass:[BlazeFlowTree class]]){
        self.blazeFlow.currentState++;
    }

    [self pushViewController:[self blazeFlowTableViewController] animated:true];
}

#pragma mark - BlazeFlow

-(BlazeFlowTableViewController*)blazeFlowTableViewController
{
    BlazeFlowTableViewController *blazeFlowTableViewController = [[self.blazeFlow.blazeFlowTableViewControllerSubclass alloc] initWithStyle:UITableViewStylePlain];
    blazeFlowTableViewController.blazeFlow = self.blazeFlow;
    return blazeFlowTableViewController;
}

-(void)previousOnFirstState
{
    [self close];
}

-(void)nextOnLastState
{
    [self close];
}

#pragma Actions

-(void)leftBarItemActionOnFirstState
{
    if(BFNavConConfig.leftBarItemOnFirstStateTitle) {
        BFNavConConfig.leftBarItemActionOnFirstState();
    }
}

-(void)rightBarItemActionFirstState
{
    if(BFNavConConfig.rightBarItemActionOnFirstState) {
        BFNavConConfig.rightBarItemActionOnFirstState();
    }
}

-(void)rightBarItemAction
{
    if(BFNavConConfig.rightBarItemAction) {
        BFNavConConfig.rightBarItemAction();
    }
}

-(void)currentStateChanged:(NSInteger)currentState
{
    
}

-(void)close
{
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
