//
//  GTTagCollectionViewCell.h
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/13/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTTagCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *movedButton;
@property (nonatomic, strong) UIView *tagColorView;
@end

NS_ASSUME_NONNULL_END
