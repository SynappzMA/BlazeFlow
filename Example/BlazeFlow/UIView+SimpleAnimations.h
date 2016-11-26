//
//  UIView+SimpleAnimations.h
//  Clinicards
//
//  Created by Roy Derks on 17/11/2016.
//  Copyright © Roy Derks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SimpleAnimations)

//Show/Hide with alpha component
-(void)hideWithDuration:(CGFloat)duration;
-(void)showWithDuration:(CGFloat)duration;
-(void)showWithDuration:(CGFloat)duration completion:(void (^)(BOOL finished))completion;
-(void)hideWithDuration:(CGFloat)duration completion:(void (^)(BOOL finished))completion;

//Pop/recede
-(void)pop:(void(^)())completion;
-(void)popWithScale:(CGFloat)scale completion:(void(^)())completion;
-(void)popWithScale:(CGFloat)scale andDuration:(CGFloat)duration completion:(void(^)())completion;
-(void)recede:(void(^)())completion;
-(void)recedeWithScale:(CGFloat)scale completion:(void(^)())completion;
-(void)recedeWithScale:(CGFloat)scale andDuration:(CGFloat)duration completion:(void(^)())completion;
@end
