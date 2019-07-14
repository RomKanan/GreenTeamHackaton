//
//  VideoImageLoader.m
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/13/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "VideoImageLoader.h"

@implementation VideoImageLoader

+ (instancetype)shared {
    static VideoImageLoader *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [VideoImageLoader new];
    });
    return shared;
}

- (void)loadImageAtVideoID:(NSString *)videoID
         completionHandler:(void(^)(UIImage *image))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg", videoID]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    completion([UIImage imageWithData:data]);
}

@end
