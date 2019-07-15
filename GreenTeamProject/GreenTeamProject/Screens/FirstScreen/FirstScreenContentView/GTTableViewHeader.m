//
//  GTTableViewHeader.m
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/14/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "GTTableViewHeader.h"

@implementation GTTableViewHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.backButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [self.contentView addSubview:self.backButton];
    self.backButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.backButton.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:5],
        [self.backButton.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor]]];
    
    [self.backButton setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    [self.backButton setTintColor:[UIColor blackColor]];
    [self.backButton addTarget:self action:@selector(backButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.directoryNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.directoryNameLabel];
    self.directoryNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.directoryNameLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [self.directoryNameLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor]]];
    self.directoryNameLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:22.f];
}

- (void)backButtonDidPress:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RedirectToPreviosViewController" object:nil];
}

@end
