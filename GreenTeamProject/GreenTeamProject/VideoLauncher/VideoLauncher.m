//
//  VideoLauncher.m
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "VideoLauncher.h"
#import "VideoLauncherConstants.h"
#import "VideoLauncher TableView/TagTableViewCell.h"
#import "VideoLauncher TableView/VideoNameHeaderView.h"
#import "WKYTPlayerView.h"
#import "VideoImageLoader.h"

@interface VideoLauncher () <UITableViewDelegate, UITableViewDataSource, WKYTPlayerViewDelegate, TagTableViewCellListener>

@property (nonatomic, strong) UIView *videoPlayerPageView;
@property (nonatomic, strong) WKYTPlayerView *videoPlayerView;
@property (nonatomic, strong) NSLayoutConstraint *videoPlayerViewHeightConstraint;
@property (nonatomic, strong) UITableView *tagsTableView;
@property (nonatomic, strong) UIButton *addTagButton;

@property (nonatomic, strong) NSMutableArray<GTTag *> *tags; //create tag class with appropriate info
@property (nonatomic, strong) NSString *videoName;
@property (nonatomic, strong) NSString *videoURL;
@property (nonatomic, assign) NSTimeInterval startSeconds;

@end

@implementation VideoLauncher

- (instancetype)initWithVideo:(GTVideo *)video {
    self = [super init];
    if (self) {
        [self commonInit];
        _tags = video.tags;
        _videoName = video.name;
        _startSeconds = 0;
    }
    return self;
}

- (instancetype)initWithTag:(GTTag *)tag {
    self = [super init];
    if (self) {
        [self commonInit];
        _videoName = tag.video.name;
        _tags = [NSMutableArray new];
        _startSeconds = tag.time;
    }
    return self;
}

- (void)commonInit {
    [self setupVideoPlayerPageView];
    [self setupVideoPlayerView];
    [self setupTagsTableView];
    [self setupActionButtons];
}

- (void)setupVideoPlayerPageView {
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    if (!keyWindow) {
        return;
    }
    _videoPlayerPageView = [UIView new];
    CGSize size = keyWindow.frame.size;
    self.videoPlayerPageView.frame =
    CGRectMake(size.width - videoLauncherConstants.videoPlayerVideStartWidth,
               size.height - videoLauncherConstants.videoPlayerVideStartHeight,
               videoLauncherConstants.videoPlayerVideStartWidth,
               videoLauncherConstants.videoPlayerVideStartHeight);
    [keyWindow addSubview:self.videoPlayerPageView];
    self.videoPlayerPageView.backgroundColor = [UIColor whiteColor];
}

- (void)setupVideoPlayerView {
    _videoPlayerView = [WKYTPlayerView new];
    _videoPlayerView.delegate = self;
    _videoPlayerView.translatesAutoresizingMaskIntoConstraints = NO;
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    if (!keyWindow) {
        return;
    }
    [_videoPlayerPageView addSubview:_videoPlayerView];
    _videoPlayerView.translatesAutoresizingMaskIntoConstraints = NO;
    _videoPlayerViewHeightConstraint =  [_videoPlayerView.heightAnchor constraintEqualToConstant:keyWindow.frame.size.width * videoLauncherConstants.heightProportion / videoLauncherConstants.widthProportion];
    [NSLayoutConstraint activateConstraints:@[
                                              [_videoPlayerView.leadingAnchor constraintEqualToAnchor:_videoPlayerPageView.leadingAnchor],
                                              [_videoPlayerView.topAnchor constraintEqualToAnchor:_videoPlayerPageView.topAnchor],
                                              [_videoPlayerView.widthAnchor constraintEqualToConstant:keyWindow.frame.size.width],
                                              _videoPlayerViewHeightConstraint,
                                              ]
     ];
    UISwipeGestureRecognizer *swipeDownGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(playerVideoViewSwipeDown:)];
    [_videoPlayerView addGestureRecognizer:swipeDownGestureRecognizer];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playerViewTapped:)];
    [_videoPlayerView addGestureRecognizer:tapGestureRecognizer];
    
}

- (void)playerVideoViewSwipeDown:(UISwipeGestureRecognizer *)swipeGestureRecognizer {
    if (swipeGestureRecognizer.view == self.videoPlayerView) {
        if (self.videoPlayerPageView.bounds.size.width == self.videoPlayerPageView.bounds.size.width) {
            [self compressVideoPlayerView];
        } else {
            [self deleteSubviews];
        }
    }
}

- (void)deleteSubviews {
    [self.addTagButton removeFromSuperview];
    self.addTagButton = nil;
    [self.tagsTableView removeFromSuperview];
    self.tagsTableView = nil;
    [self.videoPlayerView removeFromSuperview];
    self.videoPlayerView = nil;
    [self.videoPlayerPageView removeFromSuperview];
    self.videoPlayerPageView = nil;
    if ([self.listener conformsToProtocol:@protocol(VideoLauncherListener)]) {
        [self.listener deleteVideoLauncher];
    }
}

- (void)playerViewTapped:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (self.videoPlayerView.bounds.size.width == videoLauncherConstants.videoPlayerVideMiddleWidth) {
        [self expandVideoPlayerView];
    }
}

- (void)setupTagsTableView {
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    if (!keyWindow) {
        return;
    }
    _tagsTableView = [UITableView new];
    _tagsTableView.tableFooterView = [UIView new];
    _tagsTableView.backgroundColor = [UIColor whiteColor];
    _tagsTableView.delegate = self;
    _tagsTableView.dataSource = self;
    [_tagsTableView registerNib:[UINib nibWithNibName:videoLauncherConstants.tagCellIdentifier
                                               bundle:nil]
         forCellReuseIdentifier:videoLauncherConstants.tagCellIdentifier
     ];
    [_tagsTableView registerNib:[UINib nibWithNibName:videoLauncherConstants.sectionHeaderViewIdentifier
                                               bundle:nil]
forHeaderFooterViewReuseIdentifier:videoLauncherConstants.sectionHeaderViewIdentifier
     ];
    [_videoPlayerPageView addSubview:_tagsTableView];
    _tagsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_tagsTableView.leadingAnchor constraintEqualToAnchor:_videoPlayerPageView.safeAreaLayoutGuide.leadingAnchor],
                                              [_tagsTableView.trailingAnchor constraintEqualToAnchor:_videoPlayerPageView.safeAreaLayoutGuide.trailingAnchor],
                                              [_tagsTableView.topAnchor constraintEqualToAnchor:_videoPlayerView.bottomAnchor],
                                              [_tagsTableView.bottomAnchor constraintEqualToAnchor:_videoPlayerPageView.bottomAnchor],
                                              ]
     ];
}

- (void)setupActionButtons {
    _addTagButton = [UIButton new];
    _addTagButton.backgroundColor = [UIColor clearColor];
    [_videoPlayerPageView addSubview:_addTagButton];
    _addTagButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_addTagButton.trailingAnchor constraintEqualToAnchor:_videoPlayerPageView.safeAreaLayoutGuide.trailingAnchor
                                                                                           constant:-videoLauncherConstants.tableViewActionButtonSpacing],
                                              [_addTagButton.bottomAnchor constraintEqualToAnchor:_videoPlayerPageView.safeAreaLayoutGuide.bottomAnchor
                                                                                         constant:-videoLauncherConstants.tableViewActionButtonSpacing],
                                              [_addTagButton.heightAnchor constraintEqualToConstant:videoLauncherConstants.buttonHeight],
                                              [_addTagButton.widthAnchor constraintEqualToConstant:videoLauncherConstants.buttonWidth],
                                              ]
     ];
    [_addTagButton setImage:[UIImage imageNamed:videoLauncherConstants.addButtonImageName] forState:UIControlStateNormal];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addTagButtonPressed:)];
    [_addTagButton addGestureRecognizer:tapGestureRecognizer];
}

- (void)addTagButtonPressed:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self.videoPlayerView getDuration:^(NSTimeInterval duration, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"%lf", duration);
        }
    }];
}

- (void)play {
    if ([self expandVideoPlayerView]) {
        NSString *ID = @"13flvY-cbUw"; // CONVERT URL TO ID
        [self.videoPlayerView loadWithVideoId:ID];
    }
}

- (BOOL)expandVideoPlayerView {
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    if (!keyWindow) {
        return NO;
    }
    [self.tagsTableView setHidden:NO];
    [self.addTagButton setHidden:NO];
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.videoPlayerPageView.frame = keyWindow.frame;
        self.videoPlayerViewHeightConstraint.constant = keyWindow.frame.size.width * videoLauncherConstants.heightProportion /  videoLauncherConstants.widthProportion;
    } completion:^(BOOL finished) {
    }];
    return YES;
}

- (BOOL)compressVideoPlayerView {
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    if (!keyWindow) {
        return NO;
    }
    [self.tagsTableView setHidden:YES];
    [self.addTagButton setHidden:YES];
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.videoPlayerPageView.frame = CGRectMake(keyWindow.frame.size.width - videoLauncherConstants.videoPlayerVideMiddleWidth,
                                                    keyWindow.frame.size.height - videoLauncherConstants.videoPlayerVideMiddleHeight,
                                                    videoLauncherConstants.videoPlayerVideMiddleWidth,
                                                    videoLauncherConstants.videoPlayerVideMiddleHeight);
        self.videoPlayerViewHeightConstraint.constant = videoLauncherConstants.videoPlayerVideMiddleHeight;
    } completion:^(BOOL finished) {
    }];
    return YES;
}

#pragma mark - UITableViewDelegate/DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return videoLauncherConstants.sectionsAmount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return videoLauncherConstants.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return videoLauncherConstants.headerHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:videoLauncherConstants.tagCellIdentifier
                                                             forIndexPath:indexPath];
    cell.listener = self;
    [cell setVideoTag:self.tags[indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    VideoNameHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:videoLauncherConstants.sectionHeaderViewIdentifier];
    [headerView setVideoName:self.videoName];
    return headerView;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView
leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *actionTitle = @"Delete";
    __typeof(self) __weak weakSelf = self;
    UIContextualAction *action =
    [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive
                                            title:actionTitle
                                          handler:^(UIContextualAction * _Nonnull action,
                                                    __kindof UIView * _Nonnull sourceView,
                                                    void (^ _Nonnull completionHandler)(BOOL)) {
                                              [weakSelf.tags removeObjectAtIndex:indexPath.row];
                                              [tableView deleteRowsAtIndexPaths:@[indexPath]
                                                               withRowAnimation:UITableViewRowAnimationLeft
                                               ];
                                              completionHandler(YES);
                                          }
     ];
    UISwipeActionsConfiguration *swipeConfiguration = [UISwipeActionsConfiguration configurationWithActions:@[action]];
    return swipeConfiguration;
}

#pragma mark - TagTableViewCellListener

- (void)tapOnCellRecognized:(float)time {
    [self.videoPlayerView seekToSeconds:time allowSeekAhead:YES];
}

@end
