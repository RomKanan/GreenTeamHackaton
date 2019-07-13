//
//  VideoLauncher.m
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "VideoLauncher.h"
#import "VideoLauncherConstants.h"
#import "VideoPlayerView.h"


@interface VideoLauncher ()

@property (nonatomic, strong) UIView *videoPlayerPageView;
@property (nonatomic, strong) VideoPlayerView *videoPlayerView;

@end

@implementation VideoLauncher

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)showVideoWithURL:(NSString *)urlString {
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    if (!keyWindow) {
        return;
    }
    [self setupStatusBar];
    [self setupVideoPlayerViewWithURL:urlString];
    [self setupVidepPlayerPageView];
    CGSize size = keyWindow.frame.size;
    [self setupSubviewsConstraintsWithSize:size];
    self.videoPlayerPageView.frame =
    CGRectMake(size.width - videoLauncherConstants.videoPlayerVideStartWidth,
               size.height - videoLauncherConstants.videoPlayerVideStartHeight,
               size.width,
               size.height);
    [keyWindow addSubview:self.videoPlayerPageView];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.videoPlayerPageView.frame = keyWindow.frame;
    } completion:^(BOOL finished) {
        // may be nil...
    }];
}

- (void)setupStatusBar {
    
}

- (void)setupVidepPlayerPageView {
    self.videoPlayerPageView = [UIView new];
    self.videoPlayerPageView.backgroundColor = [UIColor whiteColor];
    [self.videoPlayerPageView addSubview:self.videoPlayerView];
}

- (void)setupVideoPlayerViewWithURL:(NSString *)urlString {
    self.videoPlayerView = [[VideoPlayerView alloc] initWithURL:urlString];
    self.videoPlayerView.backgroundColor = [UIColor blackColor];
    self.videoPlayerView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setupSubviewsConstraintsWithSize:(CGSize)size {
    [NSLayoutConstraint activateConstraints:@[
                                              [self.videoPlayerView.leadingAnchor constraintEqualToAnchor:self.videoPlayerPageView.leadingAnchor],
                                              [self.videoPlayerView.topAnchor constraintEqualToAnchor:self.videoPlayerPageView.topAnchor],
                                              [self.videoPlayerView.widthAnchor constraintEqualToConstant:size.width],
                                              [self.videoPlayerView.heightAnchor constraintEqualToConstant:size.width * videoLauncherConstants.widthProportion / videoLauncherConstants.heightProportion],
                                              ]];
}

@end
