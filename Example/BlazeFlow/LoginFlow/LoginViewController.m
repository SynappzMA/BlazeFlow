//
//  LoginViewController.m
//  BlazeFlow
//
//  Created by Roy Derks on 26/11/2016.
//  Copyright © 2016 Roy Derks. All rights reserved.
//

#import "LoginFlow.h"
#import "LoginViewController.h"
#import "UIView+SimpleAnimations.h"
#import "LoginFlowTableViewController.h"

@interface LoginViewController ()

@property(nonatomic,weak) IBOutlet UIButton *backButton;
@property(nonatomic,weak) IBOutlet UILabel *backLabel;
@property(nonatomic,weak) IBOutlet UIImageView *arrowImageView;
@property(nonatomic,weak) IBOutlet UIView *backContainerView;

@property(nonatomic,weak) IBOutlet UIPageControl *pageControl;
@property(nonatomic,weak) IBOutlet UIView *containerView;

@property(nonatomic,strong) LoginFlowTableViewController *loginTableViewController;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pageControl.numberOfPages = LoginStateDone;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.loginTableViewController removeObserver:self forKeyPath:@"currentState"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"currentState"]) {
        self.pageControl.currentPage = MAX(0,[change[NSKeyValueChangeNewKey] integerValue]-1);
    }
}

#pragma mark - Actions

-(IBAction)previousTapped
{
    [self.loginTableViewController.loginFlow previous];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:NSStringFromClass([LoginFlowTableViewController class])]) {
        self.loginTableViewController = segue.destinationViewController;
        
        self.loginTableViewController.loginFlow = [LoginFlow new];
        self.loginTableViewController.loginFlow.blazeTableViewController = self.loginTableViewController;
        
        __weak typeof(self) weakSelf = self;
        self.loginTableViewController.loginFlow.stateFinishedSuccesfully = ^() {
            BOOL result = [weakSelf.loginTableViewController.loginFlow next];
            if(result) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Done!" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
                [weakSelf presentViewController:alert animated:true completion:nil];
            }
        };
        self.loginTableViewController.loginFlow.shouldDisplayAccessoires = ^(NSInteger show) {
            if(show == -1) {
                weakSelf.backContainerView.hidden =
                weakSelf.pageControl.hidden = true;
            }
            else if(!show) {
                NSTimeInterval duration = 0.25f;
                [weakSelf.backContainerView hideWithDuration:duration];
                [weakSelf.pageControl hideWithDuration:duration];
            } else {
                NSTimeInterval duration = 0.25f;
                [weakSelf.backContainerView showWithDuration:duration];
                [weakSelf.pageControl showWithDuration:duration];
            }
        };
        
        [self.loginTableViewController.loginFlow addObserver:self forKeyPath:@"currentState" options:NSKeyValueObservingOptionNew context:nil];
        self.loginTableViewController.loginFlow.shouldDisplayAccessoires(-1);
    }
}


@end
