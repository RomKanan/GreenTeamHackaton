//
//  TagTableViewCell.h
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/13/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTTag.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TagTableViewCellListener <NSObject>

- (void)tapOnCellRecognized:(float)time;

@end

@interface TagTableViewCell : UITableViewCell

@property (weak, nonatomic) id<TagTableViewCellListener> listener;

- (void)setVideoTag:(GTTag *)tag;

@end

NS_ASSUME_NONNULL_END
