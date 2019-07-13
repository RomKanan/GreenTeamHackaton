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

@interface TagTableViewCell : UITableViewCell

- (void)setVideoTag:(GTTag *)tag;

@end

NS_ASSUME_NONNULL_END
