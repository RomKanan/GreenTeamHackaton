//
//  GTTagTableViewCell.h
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoLauncherViewController.h"
#import "GTTag.h"

NS_ASSUME_NONNULL_BEGIN

@interface GTTagTableViewCell : UITableViewCell
@property (nonatomic, strong) GTTag *tagItem;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *redirectingButton;
@property (nonatomic, strong) UIView *colorView;
@end

NS_ASSUME_NONNULL_END
