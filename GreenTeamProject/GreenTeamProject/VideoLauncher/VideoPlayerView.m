//
//  VideoPlayerView.m
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "VideoPlayerView.h"
#import "YTPlayerView.h"

@interface VideoPlayerView () <YTPlayerViewDelegate>

@property (weak, nonatomic) IBOutlet YTPlayerView *playerView;
@property (weak, nonatomic) IBOutlet UIView *controlsView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;


@end

@implementation VideoPlayerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        [self setupPlayerView];
    }
    return self;
}

- (void)setupPlayerView {
    [NSBundle.mainBundle loadNibNamed:@"VideoPlayerView"
                                owner:self
                              options:nil];
    [self addSubview:_playerView];
    _playerView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_playerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                              [_playerView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
                                              [_playerView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [_playerView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
                                              ]
     ];
    _playerView.backgroundColor = [UIColor lightGrayColor];
    _playerView.delegate = self;
    [_loadingIndicator startAnimating];
    _controlsView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
}

- (void)setVideoID:(NSString *)ID {
    [_playerView loadWithVideoId:ID];
    [_playerView playVideo]; // doesn't work at this place:(
}

#pragma mark - YTPlayerViewDelegate

- (void)playerViewDidBecomeReady:(nonnull YTPlayerView *)playerView {
    [self.loadingIndicator stopAnimating];
}

- (void)playerView:(nonnull YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
    switch (state) {
        case kYTPlayerStatePlaying:
            NSLog(@"VideoPlayerView: Started playing video!");
            [self.controlsView setHidden:YES];
            [self.loadingIndicator stopAnimating];
            break;
        case kYTPlayerStatePaused:
            NSLog(@"VideoPlayerView: Paused playing video!");
            [self.loadingIndicator stopAnimating];
            [self.controlsView setHidden:NO];
        default:
            break;
    }
}

- (void)playerView:(nonnull YTPlayerView *)playerView didChangeToQuality:(YTPlaybackQuality)quality {
    //implement part loading when quality is getting worse or better...
    [playerView seekto]
}

- (void)playerView:(nonnull YTPlayerView *)playerView receivedError:(YTPlayerError)error {
    //HANDLE ERROR: start indicating if it has been stopped...
    NSLog(@"%li", error);
}

- (void)playerView:(nonnull YTPlayerView *)playerView didPlayTime:(float)playTime {
    NSLog(@"%f", playTime);
}

- (nonnull UIColor *)playerViewPreferredWebViewBackgroundColor:(nonnull YTPlayerView *)playerView {
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
}

//Something inside custom indicator. Not tested, used own!
//- (nullable UIView *)playerViewPreferredInitialLoadingView:(nonnull YTPlayerView *)playerView {
//
//}

@end
