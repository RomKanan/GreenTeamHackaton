//
//  VideoLauncher.h
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoLauncher : NSObject

- (instancetype)initWithTags:(NSMutableArray *)tags videoName:(NSString *)videoName;
- (void)showVideoWithID:(NSString *)videoID;

@end

NS_ASSUME_NONNULL_END
