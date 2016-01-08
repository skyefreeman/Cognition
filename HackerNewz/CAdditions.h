//
//  HNAdditions.h
//  HackerNewz
//
//  Created by Skye on 12/5/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (CAdditions)
+ (UIColor*)COrange;
+ (UIColor*)CSystemBlue;
+ (UIColor*)CDarkGray;
+ (UIColor*)CLightGray;
@end

@interface UIImage (CAdditions)
+ (UIImage*)upImage;
+ (UIImage*)downImage;
+ (UIImage*)leftImage;
+ (UIImage*)rightImage;
+ (UIImage*)cancelImage;
+ (UIImage*)uploadImage;
@end

@interface UILabel (CAdditions)
- (void)setSubstituteFont:(UIFont*)font;
@end

@interface UIFont (CAdditions)
+ (UIFont*)hnFont:(CGFloat)fontSize;
@end

@interface NSObject (CAdditions)
+(NSString*)standardReuseIdentifier;
@end