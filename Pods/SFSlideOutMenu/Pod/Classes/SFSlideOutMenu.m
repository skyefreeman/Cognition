//
//  SFSlideOutMenu.m
//  Pods
//
//  Created by Skye on 1/9/16.
//
//

#import "SFSlideOutMenu.h"

@interface SFSlideOutMenu()
@end

@implementation SFSlideOutMenu

- (instancetype)initWithStyle:(SFSlideOutMenuStyle)style {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (!self) return nil;
    
    _style = style;
    
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    [self _commonInitWithMenuFrame:CGRectMake(screenFrame.size.width, 0, screenFrame.size.width/10 * 4, self.frame.size.height)];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;

    [self _commonInitWithMenuFrame:frame];
    
    return self;
}

- (void)_commonInitWithMenuFrame:(CGRect)frame {
    self.container = [[UIView alloc] initWithFrame:frame];
    [self addSubview:self.container];
    
    self.buttonSpacing = 0;
    self.buttonCornerRadius = 0;
    self.buttonHeight = 50;
    self.buttonWidth = self.container.bounds.size.width;
    self.buttonBackgroundColor = [UIColor clearColor];
    self.buttonTitleColor = [UIColor blackColor];
    self.buttonFont = [UIFont systemFontOfSize:16];

    self.animationDuration = 0.5;
    
    self.windowLevel = UIWindowLevelStatusBar;
}

#pragma mark - Method Overrides
- (void)layoutSubviews {
    CGFloat headerHeight = (self.headerView) ? self.headerView.frame.size.height : 0;
    CGFloat currentOriginHeight = self.buttonSpacing + headerHeight;
    
    for (UIButton *button in self.container.subviews) {
        if (![button isKindOfClass:[UIButton class]]) continue;
        
        [button setFrame:CGRectMake(self.container.frame.size.width/2 - self.buttonWidth/2, currentOriginHeight,self.buttonWidth,self.buttonHeight)];
        [button setBackgroundColor:self.buttonBackgroundColor];
        [button setTitleColor:self.buttonTitleColor forState:UIControlStateNormal];
        [button.titleLabel setFont:self.buttonFont];
        [button.layer setCornerRadius:self.buttonCornerRadius];
        
        currentOriginHeight += button.frame.size.height + self.buttonSpacing;
    }
}

- (void)setButtonSpacing:(CGFloat)buttonSpacing {
    _buttonSpacing = buttonSpacing;
    [self setNeedsLayout];
}

- (void)setButtonCornerRadius:(CGFloat)buttonCornerRadius {
    _buttonCornerRadius = buttonCornerRadius;
    [self setNeedsLayout];
}

- (void)setButtonHeight:(CGFloat)buttonHeight {
    _buttonHeight = buttonHeight;
    [self setNeedsLayout];
}

- (void)setButtonWidth:(CGFloat)buttonWidth {
    _buttonWidth = buttonWidth;
    [self setNeedsLayout];
}

- (void)setButtonBackgroundColor:(UIColor *)buttonBackgroundColor {
    _buttonBackgroundColor = buttonBackgroundColor;
    [self setNeedsLayout];
}

- (void)setButtonTitleColor:(UIColor *)buttonTitleColor {
    _buttonTitleColor = buttonTitleColor;
    [self setNeedsLayout];
}

- (void)setButtonFont:(UIFont *)buttonFont {
    _buttonFont = buttonFont;
    [self setNeedsLayout];
}

- (void)setHeaderView:(UIView *)headerView {
    [_headerView removeFromSuperview];
    _headerView = headerView;
    
    [self.container addSubview:_headerView];
    [self setNeedsLayout];
}

- (void)setFooterView:(UIView *)footerView {
    [_footerView removeFromSuperview];
    _footerView = footerView;
    
    CGSize footerSize = footerView.frame.size;
    CGPoint footerOrigin = footerView.frame.origin;
    
    _footerView.frame = CGRectMake(footerOrigin.x, self.container.frame.size.height - footerSize.height, footerSize.width, footerSize.height);
    
    [self.container addSubview:_footerView];
    [self setNeedsLayout];
}

- (void)setButtonTitles:(NSArray *)buttonTitles {
    _buttonTitles = buttonTitles;
    for (int i = 0; i < buttonTitles.count; i++) {
        UIButton *button = [self _buttonWithTitle:[buttonTitles objectAtIndex:i]];
        [button setTag:i + 1];
        [self.container addSubview:button];
    }
}

#pragma mark - Touch Input
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    if (CGRectContainsPoint(self.container.frame, location) == NO) {
        [self toggleActive];
    }
}

#pragma mark - Public Methods
- (void)toggleActive {
    [self toggleActiveWithCompletion:nil];
}

- (void)toggleActiveWithCompletion:(void (^)())completion {
    CGPoint origin = self.container.frame.origin;
    CGSize size = self.container.frame.size;
    CGFloat newY = (self.isActive) ? (origin.x + size.width) : (origin.x - size.width);

    if (self.isActive == NO) self.hidden = NO;
    self.active = (self.isActive) ? NO : YES;
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.backgroundColor = (self.isActive == NO) ? [UIColor clearColor] : [UIColor colorWithWhite:0.000 alpha:0.500];
        self.container.frame = CGRectMake(newY, origin.y, size.width, size.height);
    } completion:^(BOOL finished) {
        if (!self.isActive) self.hidden = YES;
        if (completion) completion();
    }];
}

#pragma mark - Private Methods
- (UIButton*)_buttonWithTitle:(NSString*)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(_buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)_buttonSelected:(UIButton*)button {
    if (self.delegate) [self.delegate slideOutMenuButtonSelected:button];
}

@end
