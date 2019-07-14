//
//  UIColor+CustomColor.m
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/14/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)

+ (UIColor *)colorFromRGBString:(NSString *)rgbString {
    NSScanner *scanner = [NSScanner scannerWithString:rgbString];
    unsigned int rgbValue = 0;
    [scanner setScanLocation:2]; // ignore '0x'
    if ([scanner scanHexInt:&rgbValue]) {
        return [[UIColor alloc] initWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0
                                      green:((rgbValue & 0x00FF00) >> 8) / 255.0
                                       blue:(rgbValue & 0x0000FF) / 255.0
                                      alpha:1];
    }
    return [UIColor redColor];
}

@end
