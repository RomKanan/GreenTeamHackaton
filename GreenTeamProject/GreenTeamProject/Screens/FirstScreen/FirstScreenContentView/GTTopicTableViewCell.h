//
//  GTTopicTableViewCell.h
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTTopic.h"

NS_ASSUME_NONNULL_BEGIN

@interface GTTopicTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *subCountLabel;
@property (nonatomic, strong) UILabel *tagCountLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) GTTopic *topic;

@end

NS_ASSUME_NONNULL_END
