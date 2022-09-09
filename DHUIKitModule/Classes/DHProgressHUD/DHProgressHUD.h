//
//  DHProgressHUD.h
//
//
//  Created by ext.zhaoxueli1 on 2022/7/15.
//  Copyright © 2022 刘沛. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DHProgressHUD : UIView

+ (void)showHUDAddedTo:(UIView *)view;
/**
 *  hide loadingView
 */
+ (void)hide;

@end

NS_ASSUME_NONNULL_END
