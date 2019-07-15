//
//  GTVideo.m
//  GreenTeamProject
//
//  Created by Roma on 7/14/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "GTVideo.h"

@implementation GTVideo

-(instancetype)initWithURL:(NSURL*)url{
    self = [super init];
    if (self) {
        _youtubeUrl = url;
        _stringURL = [self extractLinkfromURL:url];
        _name = [self extractVideoNamefromLink:_stringURL];
        _ID = [self extractYoutubeIdFromLink:_stringURL];
        _lengh = [self extractYouVideoLenghtFromLink:_stringURL];
        _tags = [NSMutableArray array];
        
    }
    return self;
    
}

-(instancetype)initWithLink:(NSString*)link{
    self = [super init];
    if (self) {
        _youtubeUrl = [NSURL URLWithString:link];
        _stringURL = link;
        _name = [self extractVideoNamefromLink:_stringURL];
        _ID = [self extractYoutubeIdFromLink:_stringURL];
        _lengh = [self extractYouVideoLenghtFromLink:_stringURL];
        _tags = [NSMutableArray array];
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

- (NSTimeInterval)extractYouVideoLenghtFromLink:(NSString *)link {
    //placeholder
    return 300.0;
}

- (NSString *)extractLinkfromURL:(NSURL *)url {
    return [url absoluteString];
}

- (NSString *)extractVideoNamefromLink:(NSString *)link {
    //placeholder
    return @"sample youtube Video  name  Rolling Scopes lecture";
}






@end
