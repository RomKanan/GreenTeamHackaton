//
//  VideoImageLoader.m
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/13/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "VideoImageLoader.h"

@implementation VideoImageLoader

- (void)loadImageAtURL:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url) {
        return;
    }
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask =  [NSURLSession.sharedSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data || error) {
            
            return;
        }
        NSError *jsonError;
        NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        if (!jsonError) {
            /*COMPLETION HANDLER.
             Consider making a parameter, identifies size of required image: in response there are multiple sizes...
             
             */
            NSLog(@"%@", jsonResult);
        }
    }];
    [dataTask resume];
}

@end
