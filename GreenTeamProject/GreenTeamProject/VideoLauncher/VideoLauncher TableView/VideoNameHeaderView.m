//
//  VideoNameHeaderView.m
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/14/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "VideoNameHeaderView.h"

@interface VideoNameHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation VideoNameHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor lightGrayColor];
}

- (void)setVideoName:(NSString *)videoName {
    self.nameLabel.text = videoName;
}

@end
