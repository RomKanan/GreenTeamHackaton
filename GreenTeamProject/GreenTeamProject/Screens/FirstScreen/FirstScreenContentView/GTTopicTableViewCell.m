//
//  GTTopicTableViewCell.m
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "GTTopicTableViewCell.h"
#import "GTTagTableViewCell.h"

@interface GTTopicTableViewCell ()
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation GTTopicTableViewCell

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
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.nameLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:5],
        [self.nameLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor]]];
    self.nameLabel.numberOfLines = 0;
    
    self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.moreButton];
    self.moreButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.moreButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-5],
        [self.moreButton.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor]]];
    
    [self.moreButton setImage:[UIImage imageNamed:@"Icon-20"] forState:UIControlStateNormal];
    [self.moreButton setTintColor:[UIColor blackColor]];
    [self.moreButton addTarget:self action:@selector(moreButtomDidPress:) forControlEvents:UIControlEventTouchUpInside];
    
    self.layer.borderWidth = .5f;
    self.layer.borderColor = [[UIColor colorWithRed:223.f/255.f green:223.f/255.f blue:223.f/255.f alpha:1.f] CGColor];
}

- (void)moreButtomDidPress:(id)sender {
    NSMutableArray *arrayOfTopicsAndTags = [[NSMutableArray alloc] initWithArray:self.topic.topics];
    [arrayOfTopicsAndTags addObjectsFromArray:self.topic.tags];
    
    NSDictionary *userInformation = @{@"items" : arrayOfTopicsAndTags};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RedirectToNextViewController" object:nil userInfo:userInformation];
}


@end
