//
//  GTVideo.m
//  GreenTeamProject
//
//  Created by Roma on 7/14/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "GTVideo.h"

@implementation GTVideo

- (instancetype)initWithURLString:(NSString *)urlString {
    if (self = [super init]) {
        _tags = [NSMutableArray new];
        _ID = [self extractYoutubeIdFromLink:urlString];
    }
    return self;
}

- (NSString *)extractYoutubeIdFromLink:(NSString *)link {
    NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    
    NSArray *array = [regExp matchesInString:link options:0 range:NSMakeRange(0,link.length)];
    if (array.count > 0) {
        NSTextCheckingResult *result = array.firstObject;
        return [link substringWithRange:result.range];
    }
    return nil;
}

- (void)loadVideoInfo:(void(^)(NSMutableDictionary *info))completionHandler {
    NSString *urlString =
    [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/search?part=snippet&q=%@&type=video&videoSyndicated=true&chart=mostPopular&maxResults=10&safeSearch=strict&order=relevance&order=viewCount&type=video&relevanceLanguage=en&regionCode=GB&key=AIzaSyCF_zbjXNZ2TD179bAEVuOVeZqzU4gfxVE", _ID];
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url) { return; }
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    if (!session) { return; }
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data || error) {
            return;
        }
        NSError *jsonError;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:NSJSONReadingMutableContainers
                                                                                       error:&jsonError];
        if (!json) {
            return;
        }
        NSMutableDictionary *items = json[@"items"][0];
        NSMutableDictionary *videoInfo = items[@"snippet"];
        NSMutableDictionary *info = [NSMutableDictionary new];
        info[@"name"] = videoInfo[@"title"];
        info[@"author"] = videoInfo[@"channelTitle"];
        info[@"image_url"] = videoInfo[@"thumbnails"][@"high"][@"url"];
        completionHandler(info);
    }];
    [task resume];
}


@end
