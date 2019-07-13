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
#import "TagTableViewCell/TagTableViewCell.h"


@interface VideoLauncher () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *videoPlayerPageView;
@property (nonatomic, strong) VideoPlayerView *videoPlayerView;
@property (nonatomic, strong) UITableView *tagsTableView;

@property (nonatomic, strong) NSMutableArray *tags; //create tag class with appropriate info

@end

@implementation VideoLauncher

- (instancetype)initWithTags:(NSMutableArray *)tags {
    self = [super init];
    if (self) {
        _videoPlayerPageView = [UIView new];
        self.videoPlayerPageView.backgroundColor = [UIColor whiteColor];
        [self setupVideoPlayerView];
        [self setupTagsTableView];
        _tags = tags;
    }
    return self;
}

- (void)setupVideoPlayerView {
    _videoPlayerView = [VideoPlayerView new];
    self.videoPlayerView.backgroundColor = [UIColor clearColor];
    [self.videoPlayerPageView addSubview:self.videoPlayerView];
    self.videoPlayerView.translatesAutoresizingMaskIntoConstraints = NO;
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    if (!keyWindow) {
        return;
    }
    [NSLayoutConstraint activateConstraints:@[
                                              [self.videoPlayerView.leadingAnchor constraintEqualToAnchor:self.videoPlayerPageView.leadingAnchor],
                                              [self.videoPlayerView.topAnchor constraintEqualToAnchor:self.videoPlayerPageView.topAnchor],
                                              [self.videoPlayerView.widthAnchor constraintEqualToConstant:keyWindow.frame.size.width],
                                              [self.videoPlayerView.heightAnchor constraintEqualToConstant:keyWindow.frame.size.width * videoLauncherConstants.widthProportion / videoLauncherConstants.heightProportion],
                                              ]
     ];
}

- (void)setupTagsTableView {
    _tagsTableView = [UITableView new];
    _tagsTableView.delegate = self;
    _tagsTableView.dataSource = self;
//    _tagsTableView register
    [_videoPlayerPageView addSubview:_tagsTableView];
    _tagsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_tagsTableView.leadingAnchor constraintEqualToAnchor:_videoPlayerPageView.safeAreaLayoutGuide.leadingAnchor],
                                              [_tagsTableView.trailingAnchor constraintEqualToAnchor:_videoPlayerPageView.safeAreaLayoutGuide.trailingAnchor],
                                              [_tagsTableView.topAnchor constraintEqualToAnchor:_videoPlayerPageView.safeAreaLayoutGuide.topAnchor],
                                              [_tagsTableView.bottomAnchor constraintEqualToAnchor:_videoPlayerPageView.safeAreaLayoutGuide.bottomAnchor],
                                              ]
     ];
}

- (void)showVideoWithID:(NSString *)videoID {
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    if (!keyWindow) {
        return;
    }
    CGSize size = keyWindow.frame.size;
    self.videoPlayerPageView.frame =
    CGRectMake(size.width - videoLauncherConstants.videoPlayerVideStartWidth,
               size.height - videoLauncherConstants.videoPlayerVideStartHeight,
               videoLauncherConstants.videoPlayerVideStartWidth,
               videoLauncherConstants.videoPlayerVideStartHeight);
    [keyWindow addSubview:self.videoPlayerPageView];
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.videoPlayerPageView.frame = keyWindow.frame;
    } completion:^(BOOL finished) {
    }];
    
    //give VideoPlayerView an image of video to place it instead of vide while loading
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.videoPlayerView setVideoID:videoID];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return videoLauncherConstants.sectionsAmount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
