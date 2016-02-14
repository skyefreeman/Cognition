//
//  SFSlideOutMenu.h
//  Pods
//
//  Created by Skye on 1/9/16.
//
//

#import <UIKit/UIKit.h>

@protocol SFSlideOutMenuDelegate <NSObject>
- (void)slideOutMenuButtonSelected:(UIButton*)button;
@end

typedef NS_ENUM(NSInteger,SFSlideOutMenuStyle) {
    SFSlideOutMenuStyleRight,
    SFSlideOutMenuStyleLeft,
    SFSlideOutMenuStyleTop,
    SFSlideOutMenuStyleBottom,
};

@interface SFSlideOutMenu : UIWindow

/** @brief Custom initialization */
- (instancetype)initWithStyle:(SFSlideOutMenuStyle)style;

@property (nonatomic, weak) id <SFSlideOutMenuDelegate> delegate;

/** @brief The NSString values for each UIButton subviews  */
@property (nonatomic, copy) NSArray *buttonTitles;

/** @brief Boolean value indicating whether the menu is active or not */
@property (nonatomic, getter=isActive) BOOL active;

/** @brief The duration of the menu toggle animation  */
@property (nonatomic) CGFloat animationDuration;

/** @brief The style of the menu */
@property (nonatomic) SFSlideOutMenuStyle style;

/** @brief The container view of the menu */
@property (nonatomic, strong) UIView *container;

/** @brief The header view of the menu */
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

/* Button customization */
@property (nonatomic) CGFloat buttonSpacing;
@property (nonatomic) CGFloat buttonCornerRadius;
@property (nonatomic) CGFloat buttonHeight;
@property (nonatomic) CGFloat buttonWidth;
@property (nonatomic) UIColor *buttonBackgroundColor;
@property (nonatomic) UIColor *buttonTitleColor;
@property (nonatomic) UIFont *buttonFont;

/** @brief Toggles the menu */
- (void)toggleActive;

/** @brief Toggles the menu with a completion block  */
- (void)toggleActiveWithCompletion:(void (^)())completion;

// TODO:
// Scroll view
// different sides
// background color dim

@end

