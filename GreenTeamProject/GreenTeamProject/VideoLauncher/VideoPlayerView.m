//
//  VideoPlayerView.m
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "VideoPlayerView.h"

@interface VideoPlayerView ()

@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) UIView *playerControls;

@end

@implementation VideoPlayerView

- (instancetype)initWithURL:(NSString *)urlString {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        [self setupPlayerWithURL:urlString];
        //[self setupPlayerControls];
    }
    return self;
}

- (void)setupPlayerControls {
    _playerControls = [UIView new];
    _playerControls.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self addSubview:_playerControls];
    _playerControls.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_playerControls.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                              [_playerControls.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
                                              [_playerControls.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
                                              [_playerControls.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              ]
     ];
}

- (void)setupPlayerWithURL:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url) {
        return;
    }
    _player = [[AVPlayer alloc] initWithURL:url];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    playerLayer.frame = self.frame;
    [self.layer addSublayer:playerLayer];
    [_player play];
}

@end
