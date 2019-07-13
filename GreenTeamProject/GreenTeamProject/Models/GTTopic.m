//
//  Topic.m
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "GTTopic.h"

@implementation GTTopic

@synthesize topics, tags, name;

- (instancetype)initWithTags:(NSMutableArray *)tags topics:(NSMutableArray *)topics
                     andName:(NSString *)name {
    if (self = [super init]) {
        self.topics = topics;
        self.tags = tags;
        self.name = name;
    }
    return self;
}

@end
