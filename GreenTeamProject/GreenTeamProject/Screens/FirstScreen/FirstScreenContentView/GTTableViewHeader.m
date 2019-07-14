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
    
}

- (void)backButtonDidPress:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RedirectToPreviosViewController" object:nil];
}

@end
