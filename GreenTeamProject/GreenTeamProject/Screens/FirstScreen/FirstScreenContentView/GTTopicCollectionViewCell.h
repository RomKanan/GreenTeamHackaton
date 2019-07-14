//
//  GTTopicCollectionViewCell.h
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/13/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTCollectionViewManager.h"
#import "GTTopic.h"

NS_ASSUME_NONNULL_BEGIN

@interface GTTopicCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) GTCollectionViewManager *manager;
@property (nonatomic, strong) GTTopic *supertopic;
@property (nonatomic, strong) UICollectionView *superCollectionView;
@end

NS_ASSUME_NONNULL_END
