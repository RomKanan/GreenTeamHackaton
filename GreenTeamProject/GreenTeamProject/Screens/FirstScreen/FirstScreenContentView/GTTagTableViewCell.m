//
//  GTTagTableViewCell.m
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "GTTagTableViewCell.h"

@implementation GTTagTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setup {
    self.colorView = [[UIView alloc] init];
    [self.contentView addSubview:self.colorView];
    self.colorView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.colorView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:5],
        [self.colorView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [self.contentView.widthAnchor constraintEqualToConstant:10],
        [self.colorView.heightAnchor constraintEqualToConstant:10]]];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.nameLabel.leadingAnchor constraintEqualToAnchor:self.colorView.trailingAnchor constant:5],
        [self.nameLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor]]];
    
    self.movedButton = [[UIButton alloc] init];
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
