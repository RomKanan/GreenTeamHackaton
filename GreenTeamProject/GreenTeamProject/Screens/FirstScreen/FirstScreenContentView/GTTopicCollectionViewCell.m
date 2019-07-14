//
//  GTTopicCollectionViewCell.m
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/13/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "GTTopicCollectionViewCell.h"
#import "GTTagCollectionViewCell.h"

@implementation GTTopicCollectionViewCell

static NSString * const topicIdentifier = @"cellTopic";
static NSString * const tagIdentifier = @"cellTag";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.nameLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:5],
        [self.nameLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:5]]];
    
    self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.moreButton];
    self.moreButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
       [self.moreButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-5],
       [self.moreButton.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:5]]];
    
    [self.moreButton addTarget:self action:@selector(moreButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    
    self.moreButton.backgroundColor = [UIColor greenColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.contentView addSubview:self.collectionView];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.collectionView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:5],
        [self.collectionView.topAnchor constraintEqualToAnchor:self.nameLabel.bottomAnchor constant:8],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-2],
        [self.collectionView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor]]];
    
    self.manager = [[GTCollectionViewManager alloc] init];
    
    self.collectionView.backgroundColor = [UIColor redColor];
    
    self.collectionView.dataSource = self.manager;
    self.collectionView.delegate = self.manager;
    
    [self.collectionView registerClass:GTTopicCollectionViewCell.class forCellWithReuseIdentifier:topicIdentifier];
    [self.collectionView registerClass:GTTagCollectionViewCell.class forCellWithReuseIdentifier:tagIdentifier];
}

- (void)moreButtonDidPress:(id)sender {
    if (self.supertopic.isSelected) {
        [self delesectSubtopicsOfTopic:self.supertopic];
    } else {
        self.supertopic.isSelected = YES;
    }
    [self.collectionView reloadData];
    [self.superCollectionView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"name" object:nil];
}

- (void)delesectSubtopicsOfTopic:(GTTopic *)topic {
    if (topic.isSelected) {
        topic.isSelected = NO;
        if (topic.topics != nil) {
            for (GTTopic *topicItem in topic.topics) {
                [self delesectSubtopicsOfTopic:topicItem];
            }
        } else {
            return;
        }
    } else {
        return;
    }
}

@end
