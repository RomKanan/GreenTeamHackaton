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
        NSDictionary *nameAndAuthor = [self videoNameAndAuthorByID:_ID];
        _name = nameAndAuthor[@"name"];
        _author = nameAndAuthor[@"author"];
    }
    return self;
}

// TEST !!!
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

- (NSDictionary<NSString *, NSString *> *)videoNameAndAuthorByID:(NSString *)ID {
    NSString *urlString =
    [NSString stringWithFormat:@"https://noembed.com/embed?url=https://www.youtube.com/watch?v=%@", ID];
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url) { return nil; }
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (!data) { return nil; }
    NSError *error;
    NSDictionary<NSString *, id> *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (!json) { return nil; }
    NSDictionary *videoNameAndAuthor = @{@"name": json[@"title"], @"author": json[@"author_name"]};
    return videoNameAndAuthor;
}


@end
