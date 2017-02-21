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

@interface BlazeFlowNavigationController () <UINavigationControllerDelegate>

@property(nonatomic,assign) NSUInteger currentPageIndex;
@property(nonatomic,strong) UIView* customBottomView;

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
        [weakSelf nextOnLastState];
    };
    self.blazeFlow.previousOnFirstState = ^{
        [weakSelf previousOnFirstState];
    };
    self = [super initWithRootViewController:vc];
    if(self) {
        self.delegate = self;
    }
    self.currentPageIndex = 0;
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    [super viewDidDisappear:animated];
    if(self.pageControl) {
        [self.pageControl removeFromSuperview];
        _pageControl = nil;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    self.blazeFlow.blazeFlowTableViewController = viewController;
    [self configureNavbarButtons:navigationController viewController:viewController];
    [self configurePageControl:navigationController viewController:viewController];
    [self customBottomView:navigationController viewController:viewController];
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

-(void)configureNavbarButtons:(UINavigationController*)navigationController viewController:(UIViewController*)viewController
{
    NSInteger currentState = self.blazeFlow.currentState;
    if(self.blazeFlowNavigationControllerDelegate) {
        //Show right button
        if([self.blazeFlowNavigationControllerDelegate respondsToSelector:@selector(blazeFlowNavigationControllerShouldShowRightBarItemForState:)]) {
            BOOL show = [self.blazeFlowNavigationControllerDelegate blazeFlowNavigationControllerShouldShowRightBarItemForState:currentState];
            if(show) {
                //Right item properties
                UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
                item.action = @selector(rightBarItemAction);
                NSString* title = nil;
                NSString* imageName = nil;
                
                //Fill properties through delegate
                if([self.blazeFlowNavigationControllerDelegate respondsToSelector:@selector(blazeFlowNavigationControllerRightBarItemTitleForState:)]) {
                    title = [self.blazeFlowNavigationControllerDelegate blazeFlowNavigationControllerRightBarItemTitleForState:currentState];
                }
                if([self.blazeFlowNavigationControllerDelegate respondsToSelector:@selector(blazeFlowNavigationControllerRightBarItemImageNameForState:)]) {
                    imageName = [self.blazeFlowNavigationControllerDelegate blazeFlowNavigationControllerRightBarItemImageNameForState:currentState];
                }
                //Set image or title. Image has priority.
                if(imageName.length) {
                    UIImage *image = [UIImage imageNamed:imageName];
                    if(image) {
                        item.image = image;
                    } else {
                        item.title = title;
                    }
                } else if(title.length) {
                    item.title = title;
                }
                //If one of them is set, show item.
                if(item.title.length || item.image) {
                    viewController.navigationItem.rightBarButtonItem = item;
                } else {
                    //If no title or image is set, remove the button.
                    viewController.navigationItem.rightBarButtonItem = nil;
                }
            } else {
                viewController.navigationItem.rightBarButtonItem = nil;
            }
        }
        //Show left button
        if([self.blazeFlowNavigationControllerDelegate respondsToSelector:@selector(blazeFlowNavigationControllerShouldShowLeftBarItemForState:)]) {
            BOOL show = [self.blazeFlowNavigationControllerDelegate blazeFlowNavigationControllerShouldShowLeftBarItemForState:currentState];
            if(show) {
                //Left item properties
                UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
                item.action = @selector(leftBarItemAction);
                NSString* title = nil;
                NSString* imageName = nil;
                
                //Fill properties through delegate
                if([self.blazeFlowNavigationControllerDelegate respondsToSelector:@selector(blazeFlowNavigationControllerLeftBarItemTitleForState:)]) {
                    title = [self.blazeFlowNavigationControllerDelegate blazeFlowNavigationControllerLeftBarItemTitleForState:currentState];
                }
                if([self.blazeFlowNavigationControllerDelegate respondsToSelector:@selector(blazeFlowNavigationControllerLeftBarItemImageNameForState:)]) {
                    imageName = [self.blazeFlowNavigationControllerDelegate blazeFlowNavigationControllerLeftBarItemImageNameForState:currentState];
                }
                //Set image or title. Image has priority.
                if(imageName.length) {
                    UIImage *image = [UIImage imageNamed:imageName];
                    if(image) {
                        item.image = image;
                    } else {
                        item.title = title;
                    }
                } else if(title.length) {
                    item.title = title;
                }
                //If one of them is set, show item.
                if(item.title.length || item.image) {
                    viewController.navigationItem.leftBarButtonItem = item;
                } else {
                    //If no title or image is set, remove the button.
                    viewController.navigationItem.leftBarButtonItem = nil;
                }
            } else if([self.blazeFlowNavigationControllerDelegate respondsToSelector:@selector(blazeFlowNavigationControllerShouldHideBackLeftBarItemForState:)]) {
                [self.navigationItem setHidesBackButton:[self.blazeFlowNavigationControllerDelegate blazeFlowNavigationControllerShouldHideBackLeftBarItemForState:currentState] animated:false];
            } else {
                viewController.navigationItem.leftBarButtonItem = nil;
            }
        }
    } else {
        //Default values
        viewController.navigationItem.rightBarButtonItem = nil;
        viewController.navigationItem.leftBarButtonItem = nil;
    }
}

-(void)configurePageControl:(UINavigationController*)navigationController viewController:(UIViewController*)viewController
{
    NSInteger currentState = self.blazeFlow.currentState;
    if(self.blazeFlowNavigationControllerDelegate) {
        if([self.blazeFlowNavigationControllerDelegate respondsToSelector:@selector(blazeFlowNavigationControllerShouldShowPageControlForState:)]) {
            if([self.blazeFlowNavigationControllerDelegate blazeFlowNavigationControllerShouldShowPageControlForState:currentState]
               && [self.blazeFlowNavigationControllerDelegate respondsToSelector:@selector(blazeFlowNavigationControllerAmountOfPageForPageControl)]) {
                if(!self.pageControl) {
                    CGRect f = CGRectMake(0, CGRectGetMaxY(self.view.bounds)-100, CGRectGetWidth(self.view.bounds), 40);
                    _pageControl = [[UIPageControl alloc] initWithFrame:f];
                    self.pageControl.numberOfPages = [self.blazeFlowNavigationControllerDelegate blazeFlowNavigationControllerAmountOfPageForPageControl];
                    [self.pageControl sizeToFit];
                    CGPoint center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds)-CGRectGetHeight(_pageControl.bounds));
                    self.pageControl.center = center;
                    self.pageControl.alpha = 0.0f;
                    if([self.blazeFlowNavigationControllerDelegate respondsToSelector:@selector(customizePageControl:)]) {
                        [self.blazeFlowNavigationControllerDelegate customizePageControl:self.pageControl];
                    }
                    
                    NSTimeInterval duration = 0.225;
                    if([self.blazeFlowNavigationControllerDelegate respondsToSelector:@selector(blazeFlowNavigationControllerAnimationDurationForPageControl)]) {
                        duration = [self.blazeFlowNavigationControllerDelegate blazeFlowNavigationControllerAnimationDurationForPageControl];
                    }
                    
                    [[[UIApplication sharedApplication] keyWindow] addSubview:self.pageControl];
                    [self showWithDuration:self.pageControl duration:duration completion:nil];
                }
                else if(!self.pageControl.superview) {
                    NSTimeInterval duration = 0.225;
                    if([self.blazeFlowNavigationControllerDelegate respondsToSelector:@selector(blazeFlowNavigationControllerAnimationDurationForPageControl)]) {
                        duration = [self.blazeFlowNavigationControllerDelegate blazeFlowNavigationControllerAnimationDurationForPageControl];
                    }
                    
                    [[[UIApplication sharedApplication] keyWindow] addSubview:self.pageControl];
                    [self showWithDuration:self.pageControl duration:duration completion:nil];

                }
            } else {
                NSTimeInterval duration = 0.225;
                if([self.blazeFlowNavigationControllerDelegate respondsToSelector:@selector(blazeFlowNavigationControllerAnimationDurationForPageControl)]) {
                    duration = [self.blazeFlowNavigationControllerDelegate blazeFlowNavigationControllerAnimationDurationForPageControl];
                }
                [self hideWithDuration:self.pageControl duration:duration completion:^(BOOL finished) {
                    [self.pageControl removeFromSuperview];
                }];
            }
            self.pageControl.currentPage = self.currentPageIndex;
        }
    } else {
        //If there was a pageControl, remove and nullify
        if(self.pageControl) {
            [self.pageControl removeFromSuperview];
            _pageControl = nil;
        }
    }
}

-(Class)pageControlClass
{
    if([self.blazeFlowNavigationControllerDelegate respondsToSelector:@selector(classForPageControl)])
    {
        return [self.blazeFlowNavigationControllerDelegate classForPageControl];
    }
    return [UIPageControl class];
}

-(void)customBottomView:(UINavigationController*)navigationController viewController:(UIViewController*)viewController
{
    if(![self.blazeFlowNavigationControllerDelegate respondsToSelector:@selector(customBottomViewForState:)]) {
        return;
    }
    NSInteger currentState = self.blazeFlow.currentState;
    UIView *customView = [self.blazeFlowNavigationControllerDelegate customBottomViewForState:currentState];
    if(customView) {
        if(![self.customBottomView isEqual:customView] && self.customBottomView) {
            NSTimeInterval duration = 0.225;
            if(self.customBottomView) {
                [self hideWithDuration:self.customBottomView duration:duration completion:^(BOOL finished) {
                    [self.customBottomView removeFromSuperview];
                    
                    self.customBottomView = customView;
                    customView.alpha = 0.0;
                    [[[UIApplication sharedApplication] keyWindow] addSubview:customView];
                    [self showWithDuration:customView duration:duration completion:nil];
                }];
            }
        } else {
            NSTimeInterval duration = 0.225;
            self.customBottomView = customView;
            self.customBottomView.alpha = 0.0;
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.customBottomView];
            [self showWithDuration:self.customBottomView duration:duration completion:nil];
        }
    } else {
        if(self.customBottomView) {
            NSTimeInterval duration = 0.225;
            [self hideWithDuration:self.customBottomView duration:duration completion:^(BOOL finished) {
                [self.customBottomView removeFromSuperview];
                self.customBottomView = nil;
            }];
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
    self.blazeFlow.blazeFlowTableViewController = blazeFlowTableViewController;
    return blazeFlowTableViewController;
}

-(void)previousOnFirstState
{
    //To override
    [self close];
}

-(void)nextOnLastState
{
    //To override
    [self close];
}

#pragma Actions

-(void)rightBarItemAction
{
    if([self.blazeFlowNavigationControllerDelegate respondsToSelector:@selector(blazeFlowNavigationControllerRightBarItemTappedForState:)]) {
        [self.blazeFlowNavigationControllerDelegate blazeFlowNavigationControllerRightBarItemTappedForState:self.blazeFlow.currentState];
    }
}

-(void)leftBarItemAction
{
    if([self.blazeFlowNavigationControllerDelegate respondsToSelector:@selector(blazeFlowNavigationControllerLeftBarItemTappedForState:)]) {
        [self.blazeFlowNavigationControllerDelegate blazeFlowNavigationControllerLeftBarItemTappedForState:self.blazeFlow.currentState];
    }
}

-(void)currentStateChanged:(NSInteger)currentState
{
    //To override
}

-(void)close
{
    //To override
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - Util

-(void)showWithDuration:(UIView*)view duration:(CGFloat)duration completion:(void (^)(BOOL finished))completion
{
    view.hidden = false;
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        view.alpha = 1.0f;
    } completion:completion];
}

-(void)hideWithDuration:(UIView*)view duration:(CGFloat)duration completion:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        view.hidden = true;
        if(completion) {
            completion(finished);
        }
    }];
}


@end
