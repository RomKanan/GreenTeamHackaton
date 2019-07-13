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

static NSString * const reuseTopicIdentifier = @"cellTopic";
static NSString * const reuseTagIdentifier = @"cellTag";

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
    
    self.moreButton = [[UIButton alloc] init];
    [self.contentView addSubview:self.moreButton];
    self.moreButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.moreButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-5],
        [self.moreButton.centerYAnchor constraintEqualToAnchor:self.moreButton.centerYAnchor]]];
    
    [self.moreButton addTarget:self action:@selector(moreButtomDidPress:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc] init];
    [self.contentView addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:15],
        [self.tableView.topAnchor constraintEqualToAnchor:self.nameLabel.bottomAnchor constant:5],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-5],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor]]];
    
    [self.tableView registerClass:GTTagTableViewCell.class forCellReuseIdentifier:reuseTagIdentifier];
    [self.tableView registerClass:GTTopicTableViewCell.class forCellReuseIdentifier:reuseTopicIdentifier];
    
    self.manager = [[GTTopicTableViewManager alloc] init];
    self.tableView.dataSource = self.manager;
    self.tableView.delegate = self.manager;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    self.contentMode = UIViewContentModeTopLeft;
    
    self.tableView.hidden = YES;
}

- (void)moreButtomDidPress:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TableViewDidChanged" object:nil];
    self.tableView.hidden = !self.tableView.hidden;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}


@end
