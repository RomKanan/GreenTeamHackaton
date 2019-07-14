//
//  UIColor+CustomColor.h
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/14/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (CustomColor)

+ (UIColor *)colorFromRGBString:(NSString *)rgbString;

@end

NS_ASSUME_NONNULL_END
