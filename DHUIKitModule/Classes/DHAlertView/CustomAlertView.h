//
//  CustomAlertView.h
//  testSingature
//
//  Created by rilakkuma on 2022/7/10.
//  Copyright © 2022 zk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomAlertView : UIView
@property (nonatomic, strong) UIView *dialogView;    // Dialog's container view
@property (nonatomic, strong) UIView *containerView; // Container within the dialog (place your ui elements here)
@property (nonatomic, retain) NSArray *buttonTitles;

- (void)show;
- (void)close;
@end

NS_ASSUME_NONNULL_END
