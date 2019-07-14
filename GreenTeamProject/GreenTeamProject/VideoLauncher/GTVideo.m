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
    self = [super init];
    if (self) {
        _urlString = urlString;
        _tags = [NSMutableArray new];
        NSString *ID = [self extractYoutubeIdFromLink:urlString];
        _name = [self videoNameByID:ID];
    }
    return self;
}

// TEST!
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

- (NSString *)videoNameByID:(NSString *)ID {
    NSString *urlString =
    [NSString stringWithFormat:@"https://noembed.com/embed?url=https://www.youtube.com/watch?v=%@", ID];
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url) { return nil; }
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (!data) { return nil; }
    NSError *error;
    NSDictionary<NSString *, id> *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (!json) { return nil; }
    return json[@"title"];
}


@end
