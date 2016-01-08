//
//  HNAdditions.m
//  HackerNewz
//
//  Created by Skye on 12/5/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "CAdditions.h"

#pragma mark - NSObject Additions
@implementation NSObject (CAdditions)
+(NSString*)standardReuseIdentifier {
    return NSStringFromClass(self);
}
@end

#pragma mark - UIColor Additions
@implementation UIColor (CAdditions)
+ (UIColor*)COrange {
    return [UIColor colorWithRed:1.000 green:0.270 blue:0.252 alpha:1.000];
}

+ (UIColor*)CDarkGray {
    return [UIColor colorWithWhite:0.168 alpha:1.000];
}

+ (UIColor*)CSystemBlue {
    return [UIColor colorWithRed:0.000 green:0.479 blue:1.000 alpha:1.000];
}

+ (UIColor*)CLightGray {
    return [UIColor colorWithWhite:0.871 alpha:1.000];
}
@end

#pragma mark - UILabel Additions
@implementation UILabel (CAdditions)
- (void)setSubstituteFont:(UIFont*)font {
    self.font = [self.font fontWithSize:self.font.pointSize];
}
@end

#pragma mark - UIFont Additions
@implementation UIFont (CAdditions)
+ (UIFont*)hnFont:(CGFloat)fontSize {
    return [UIFont fontWithName:@"HelveticaNeue-Thin" size:fontSize];
}
@end

#pragma mark - UIImage Additions
@implementation UIImage (CAdditions)
+ (UIImage*)upImage {
    return [UIImage imageNamed:@"upIcon"];
}

+ (UIImage*)downImage {
    return [UIImage imageNamed:@"downIcon"];
}

+ (UIImage*)cancelImage {
    return [UIImage imageNamed:@"cancelIcon"];
}

+ (UIImage*)leftImage {
    return [UIImage imageNamed:@"leftIcon"];
}

+ (UIImage*)rightImage {
    return [UIImage imageNamed:@"rightIcon"];
}

+ (UIImage*)uploadImage {
    return [UIImage imageNamed:@"uploadIcon"];
}
@end

