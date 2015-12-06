//
//  HNAdditions.h
//  HackerNewz
//
//  Created by Skye on 12/5/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (HNAdditions)
+ (UIColor*)HNOrange;
+ (UIColor*)HNLightOrange;
+ (UIColor*)HNSystemBlue;
+ (UIColor*)HNDarkGray;
+ (UIColor*)HNLightGray;
@end

@interface UIImage (HNAdditions)
+ (UIImage*)upImage;
+ (UIImage*)downImage;
+ (UIImage*)leftImage;
+ (UIImage*)rightImage;
+ (UIImage*)cancelImage;
+ (UIImage*)uploadImage;
@end

@interface UILabel (HNAdditions)
- (void)setSubstituteFont:(UIFont*)font;
@end

@interface UIFont (HNAdditions)
+ (UIFont*)hnFont:(CGFloat)fontSize;
@end

@interface NSObject (HNAdditions)
+(NSString*)standardReuseIdentifier;
@end