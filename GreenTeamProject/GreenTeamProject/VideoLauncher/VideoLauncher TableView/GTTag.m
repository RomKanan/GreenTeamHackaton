//
//  Tag.m
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "GTTag.h"

@implementation GTTag

- (instancetype)initWithURLString:(NSString *)urlString
                            color:(UIColor *)color
                             name:(NSString *)name
                             time:(float)time {
    if (self = [super init]) {
        self.urlString = urlString;
        self.color = color;
        self.name = name;
        self.time = time;
    }
    return self;
}

@end
