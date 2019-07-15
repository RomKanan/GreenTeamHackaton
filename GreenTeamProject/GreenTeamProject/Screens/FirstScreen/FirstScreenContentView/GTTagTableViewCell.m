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
    [self addSubview:self.colorView];
    self.colorView.backgroundColor = [UIColor redColor];
    self.colorView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.colorView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10],
        [self.colorView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.colorView.widthAnchor constraintEqualToConstant:10],
        [self.colorView.heightAnchor constraintEqualToConstant:10]]];
    
    self.nameLabel = [[UILabel alloc] init];
    [self addSubview:self.nameLabel];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.nameLabel.leadingAnchor constraintEqualToAnchor:self.colorView.trailingAnchor constant:8],
        [self.nameLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]]];
    self.nameLabel.numberOfLines = 0;
    
    self.redirectingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.redirectingButton];
    self.redirectingButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.redirectingButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10],
        [self.redirectingButton.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.redirectingButton.heightAnchor constraintEqualToConstant:15],
        [self.redirectingButton.widthAnchor constraintEqualToConstant:30]]];
    
    [self.redirectingButton setImage:[UIImage imageNamed:@"playButton"] forState:UIControlStateNormal];
    
    [self.redirectingButton addTarget:self action:@selector(movedButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
}

// Redirect to viewCotroller

- (void)movedButtonDidPress:(id)sender {
    NSDictionary *userInfo = @{@"tag" : self.tagItem};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RedirectToVideoScreen" object:nil userInfo:userInfo];
}

@end
