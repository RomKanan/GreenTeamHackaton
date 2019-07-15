//
//  Defaults.m
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/15/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "Defaults.h"

static NSString *videosKey = @"videos";

@implementation Defaults

+ (instancetype)shared {
    static Defaults *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [Defaults new];
    });
    return shared;
}

- (void)saveVideo:(GTVideo *)video {
    NSDictionary<NSString *, GTVideo *> *dictionary = [self getVideos];
    NSMutableDictionary<NSString *, GTVideo *> *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [mutableDictionary setObject:video forKey:video.ID];
    [NSUserDefaults.standardUserDefaults setValue:dictionary forKey:videosKey];
}

- (NSDictionary *)getVideos {
    return [NSUserDefaults.standardUserDefaults valueForKey:videosKey];
}

@end
