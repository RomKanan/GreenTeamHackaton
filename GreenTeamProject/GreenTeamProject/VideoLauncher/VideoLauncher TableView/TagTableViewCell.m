//
//  TagTableViewCell.m
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/13/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "TagTableViewCell.h"

@interface TagTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *tagNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (assign, nonatomic) float time;

@end

@implementation TagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnCell:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)tapOnCell:(UITapGestureRecognizer *)tapGestureRecognizer {
    if ([self.listener conformsToProtocol:@protocol(TagTableViewCellListener)]) {
        [self.listener tapOnCellRecognized:self.time];
    }
}

- (void)setVideoTag:(GTTag *)tag {
    self.time = tag.time;
    self.tagNameLabel.text = tag.name;
    self.tagNameLabel.textColor = tag.color;
    self.timeLabel.text = [NSString stringWithFormat:@"%f", tag.time];
    self.timeLabel.textColor = tag.color;
}

@end
