//
//  GTTagCollectionViewCell.m
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/13/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "GTTagCollectionViewCell.h"

@implementation GTTagCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.tagColorView = [[UIView alloc] init];
    [self.contentView addSubview:self.tagColorView];
    self.tagColorView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.tagColorView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:5],
        [self.tagColorView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [self.tagColorView.widthAnchor constraintEqualToConstant:10],
        [self.tagColorView.heightAnchor constraintEqualToConstant:10]]];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.nameLabel.leadingAnchor constraintEqualToAnchor:self.tagColorView.trailingAnchor constant:5],
        [self.nameLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor]]];
    
    self.movedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.movedButton];
    self.movedButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.movedButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-5],
        [self.movedButton.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor]]];
    
    [self.movedButton addTarget:self action:@selector(movedButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)movedButtonDidPress:(id)sender {
    
}

@end
