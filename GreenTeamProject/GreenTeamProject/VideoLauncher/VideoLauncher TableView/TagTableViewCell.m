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

@end

@implementation TagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setVideoTag:(GTTag *)tag {
    self.tagNameLabel.text = tag.name;
    self.tagNameLabel.textColor = tag.color;
    self.timeLabel.text = [NSString stringWithFormat:@"%f", tag.time];
    self.timeLabel.textColor = tag.color;
}

@end
