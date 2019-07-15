//
//  VideoLauncher.h
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTVideo.h"
#import "VideoLauncher TableView/GTTag.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VideoLauncherListener <NSObject>

@required
- (void)deleteVideoLauncher;

@end

@protocol TagsTableViewListener <NSObject>

@required
- (void)deleteTag:(GTTag *)tag;

@end

@interface VideoLauncher : NSObject

@property (weak, nonatomic) id<VideoLauncherListener> videoLauncherListener;
@property (weak, nonatomic) id<TagsTableViewListener> tagsTableViewListener;

- (instancetype)initWithVideo:(GTVideo *)video;
- (instancetype)initWithTag:(GTTag *)tag;
- (void)play;

@end

NS_ASSUME_NONNULL_END
