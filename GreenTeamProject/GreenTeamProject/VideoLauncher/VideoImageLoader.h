//
//  VideoImageLoader.h
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/13/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoImageLoader : NSObject

+ (instancetype)shared;
- (void)loadImageAtVideoID:(NSString *)videoID
         completionHandler:(void(^)(UIImage *image))completion;

@end

NS_ASSUME_NONNULL_END
