//
//  Defaults.h
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/15/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTVideo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Defaults : NSObject

+ (instancetype)shared;
- (void)saveVideo:(GTVideo *)video;
- (NSDictionary *)getVideos;

@end

NS_ASSUME_NONNULL_END
