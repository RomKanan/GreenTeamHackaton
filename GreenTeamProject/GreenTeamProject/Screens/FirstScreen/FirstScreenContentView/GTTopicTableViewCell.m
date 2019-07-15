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
    
    self.subCountLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.subCountLabel];
    self.subCountLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.subCountLabel.leadingAnchor constraintEqualToAnchor:self.nameLabel.trailingAnchor constant:10],
        [self.subCountLabel.centerYAnchor constraintEqualToAnchor:self.nameLabel.centerYAnchor]]];
    self.subCountLabel.font = [UIFont systemFontOfSize:12.f];
    
    self.tagCountLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.tagCountLabel];
    self.tagCountLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.tagCountLabel.leadingAnchor constraintEqualToAnchor:self.subCountLabel.trailingAnchor constant:5],
        [self.tagCountLabel.centerYAnchor constraintEqualToAnchor:self.nameLabel.centerYAnchor]]];
    self.tagCountLabel.font = [UIFont systemFontOfSize:12.f];
    
    self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.moreButton];
    self.moreButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.moreButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-5],
        [self.moreButton.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor]]];
    
    [self.moreButton setImage:[UIImage imageNamed:@"Icon-20"] forState:UIControlStateNormal];
    [self.moreButton setTintColor:[UIColor blackColor]];
    [self.moreButton addTarget:self action:@selector(moreButtomDidPress:) forControlEvents:UIControlEventTouchUpInside];
    

}

- (void)moreButtomDidPress:(id)sender {
    NSMutableArray *arrayOfTopicsAndTags = [[NSMutableArray alloc] initWithArray:self.topic.topics];
    [arrayOfTopicsAndTags addObjectsFromArray:self.topic.tags];
    
    NSDictionary *userInformation = @{@"items" : arrayOfTopicsAndTags,
                                      @"topicName" : self.topic.name,
                                      @"topic": self.topic
                                      };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RedirectToNextViewController" object:nil userInfo:userInformation];
}


@end
