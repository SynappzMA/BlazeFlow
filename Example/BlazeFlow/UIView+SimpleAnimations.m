//
//  UIView+SimpleAnimations.m
//  Clinicards
//
//  Created by Roy Derks on 17/11/2016.
//  Copyright © 2016 Roy Derks All rights reserved.
//

#import "UIView+SimpleAnimations.h"

@implementation UIView (SimpleAnimations)

#pragma mark - Show/Hide

-(void)showWithDuration:(CGFloat)duration
{
    [self showWithDuration:duration completion:nil];
}

-(void)hideWithDuration:(CGFloat)duration
{
    [self hideWithDuration:duration completion:nil];
}

-(void)showWithDuration:(CGFloat)duration completion:(void (^)(BOOL finished))completion
{
    self.hidden = false;
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.alpha = 1.0f;
    } completion:completion];
}

-(void)hideWithDuration:(CGFloat)duration completion:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.hidden = true;
        if(completion) {
            completion(finished);
        }
    }];
}

#pragma mark - Pop/Recede

-(void)pop:(void(^)())completion {
    
    [UIView animateWithDuration:0.15  animations:^{
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            if(completion)completion();
        }];
    }];
}

-(void)popWithScale:(CGFloat)scale completion:(void(^)())completion {
    [UIView animateWithDuration:0.15 animations:^{
        self.transform = CGAffineTransformMakeScale(scale, scale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            if(completion)completion();
        }];
    }];
}

-(void)popWithScale:(CGFloat)scale andDuration:(CGFloat)duration completion:(void(^)())completion {
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeScale(scale, scale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            if(completion)completion();
        }];
    }];
}

-(void)recede:(void(^)())completion {
    
    [UIView animateWithDuration:0.15  animations:^{
        self.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            if(completion)completion();
        }];
    }];
}

-(void)recedeWithScale:(CGFloat)scale completion:(void(^)())completion {
    [UIView animateWithDuration:0.15 animations:^{
        self.transform = CGAffineTransformMakeScale(scale, scale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            if(completion)completion();
        }];
    }];
}

-(void)recedeWithScale:(CGFloat)scale andDuration:(CGFloat)duration completion:(void(^)())completion {
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeScale(scale, scale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            if(completion)completion();
        }];
    }];
}


@end
