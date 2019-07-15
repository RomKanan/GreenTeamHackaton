//
//  Tag.m
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "GTTag.h"

@implementation GTTag

- (instancetype)initWithVideo:(GTVideo *)video
                            color:(UIColor *)color
                             name:(NSString *)name
                             time:(float)time {
    if (self = [super init]) {
        _video = video;
        _color = color;
        _name = name;
        _time = time;
    }
    return self;
}

@end
