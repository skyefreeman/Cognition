//
//  CMenu.h
//  Cognition
//
//  Created by Skye on 1/10/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import <SFSlideOutMenu/SFSlideOutMenu.h>
@class CCreditView;

typedef NS_ENUM(NSInteger, MenuButton) {
    MenuButtonTop = 1,
    MenuButtonNew,
    MenuButtonAsk,
    MenuButtonShow,
    MenuButtonJob,
};

@interface CMenu : SFSlideOutMenu

@property (nonatomic, strong) CCreditView *creditView;

- (void)toggleTopStoryButton;
- (void)setActiveButton:(UIButton *)aButton;
@end