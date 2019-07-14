//
//  VideoNameHeaderView.m
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/14/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "VideoNameHeaderView.h"
#import "../../UIColor Category/UIColor+CustomColor.h"

@interface VideoNameHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation VideoNameHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor blackColor];
    self.nameLabel.textColor = [UIColor blackColor];
    [self editBackgroundView];
}

- (void)editBackgroundView {
    UIView *backgroundView = [UIView new];
    [backgroundView setOpaque:YES];
    backgroundView.backgroundColor = [UIColor colorFromRGBString:@"0xF9F9F9"];
    self.backgroundView = backgroundView;
}

- (void)setVideoName:(NSString *)videoName {
    self.nameLabel.text = videoName;
}

@end
