//
//  DHAlertView.h
//  AFNetworking
//
//  Created by rilakkuma on 2022/9/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DHAlertView;
@protocol DHAlertViewDelegate <NSObject>

- (void)alertView:(DHAlertView *)alertView didSelectedOptionButtonWithTag:(NSInteger)index;

@end

@interface DHAlertView : UIView

@property (nonatomic, weak) id<DHAlertViewDelegate>delegate;
- (void)show;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
