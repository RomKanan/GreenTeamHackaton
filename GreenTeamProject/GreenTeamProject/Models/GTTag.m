//
//  Tag.m
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "GTTag.h"

@implementation GTTag

- (instancetype)initWithColor:(UIColor *)color name:(NSString *)name {
    if (self = [super init]) {
        self.name = name;
        self.color = color;
    }
    return self;
}

@end