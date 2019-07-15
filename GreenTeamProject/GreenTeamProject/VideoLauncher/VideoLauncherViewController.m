//
//  VideoLauncherViewController.m
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/15/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//


#import "VideoLauncherViewController.h"
#import "VideoLauncherConstants.h"
#import "VideoLauncher TableView/TagTableViewCell.h"
#import "VideoLauncher TableView/VideoNameHeaderView.h"
#import "WKYTPlayerView.h"

@interface VideoLauncherViewController () <UITableViewDelegate, UITableViewDataSource, WKYTPlayerViewDelegate, TagTableViewCellListener>

@property (nonatomic, strong) UIView *videoPlayerPageView;
@property (nonatomic, strong) WKYTPlayerView *videoPlayerView;
@property (nonatomic, strong) UIImageView *videoPlayerImageView;
@property (nonatomic, strong) UIActivityIndicatorView *videoPlayerIndicator;
@property (nonatomic, strong) NSLayoutConstraint *videoPlayerViewHeightConstraint;
@property (nonatomic, strong) UITableView *tagsTableView;
@property (nonatomic, strong) UIButton *addTagButton;

@property (nonatomic, strong) GTVideo *video;
@property (nonatomic, strong) NSString *videoName;
@property (nonatomic, strong) NSString *videoAuthor;
@property (nonatomic, strong) NSString *videoImageURL;
@property (nonatomic, assign) NSTimeInterval startSeconds;

@end

@implementation VideoLauncherViewController

- (instancetype)initWithVideo:(GTVideo *)video {
    if (self = [super init]) {
        _video = video;
        _startSeconds = 0;
    }
    return self;
}

- (instancetype)initWithTag:(GTTag *)tag {
    if (self = [super init]) {
        _video = tag.video;
        _startSeconds = tag.time;
    }
    return self;
}

- (void)viewDidLoad {
    [self commonInit];
}

- (void)commonInit {
    [self setupVideoPlayerPageView];
    [self setupVideoPlayerView];
    [self setupTagsTableView];
    [self setupActionButtons];
    __typeof(self) __weak weakSelf = self;
    [self.video loadVideoInfo:^(NSMutableDictionary *info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.videoName = info[@"name"];
            weakSelf.videoAuthor = info[@"author"];
            weakSelf.videoImageURL = info[@"image_url"];
            [self loadImageAtURL:self.videoImageURL completionHandler:^(UIImage *image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.videoPlayerImageView.image = image;
                });
            }];
            [weakSelf.tagsTableView reloadData];
        });
    }];
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
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    if (!keyWindow) {
        return;
    }
    _videoPlayerView = [WKYTPlayerView new];
    _videoPlayerView.delegate = self;
    [_videoPlayerPageView addSubview:_videoPlayerView];
    _videoPlayerView.translatesAutoresizingMaskIntoConstraints = NO;
    _videoPlayerViewHeightConstraint =
    [_videoPlayerView.heightAnchor constraintEqualToConstant:keyWindow.frame.size.width * videoLauncherConstants.heightProportion / videoLauncherConstants.widthProportion];
    [NSLayoutConstraint activateConstraints:@[
                                              [_videoPlayerView.leadingAnchor constraintEqualToAnchor:_videoPlayerPageView.leadingAnchor],
                                              [_videoPlayerView.topAnchor constraintEqualToAnchor:_videoPlayerPageView.topAnchor],
                                              [_videoPlayerView.widthAnchor constraintEqualToConstant:keyWindow.frame.size.width],
                                              _videoPlayerViewHeightConstraint,
                                              ]
     ];
    [_videoPlayerView setHidden:YES];
    CGRect commonFrame = CGRectMake(0,
                                    0,
                                    keyWindow.frame.size.width,
                                    _videoPlayerViewHeightConstraint.constant);
    _videoPlayerIndicator = [[UIActivityIndicatorView alloc] initWithFrame:commonFrame];
    _videoPlayerImageView =
    [[UIImageView alloc] initWithFrame:commonFrame];
    _videoPlayerIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [_videoPlayerIndicator startAnimating];
    [self.videoPlayerPageView addSubview:_videoPlayerImageView];
    [self.videoPlayerPageView addSubview:_videoPlayerIndicator];
}

- (void)loadImageAtURL:(NSString *)imageURL
     completionHandler:(void(^)(UIImage *image))completion {
    NSURL *url = [NSURL URLWithString:imageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    completion([UIImage imageWithData:data]);
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.videoPlayerView loadWithVideoId:self.video.ID];
        });
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
    return self.video.tags.count;
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
    [cell setVideoTag:self.video.tags[indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    VideoNameHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:videoLauncherConstants.sectionHeaderViewIdentifier];
    [headerView setVideoName:self.videoName];
    [headerView setAuthorName:self.videoAuthor];
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
                                              [weakSelf.tagsTableViewListener deleteTag:weakSelf.video.tags[indexPath.row]];
                                              [weakSelf.video.tags removeObjectAtIndex:indexPath.row];
                                              [tableView deleteRowsAtIndexPaths:@[indexPath]
                                                               withRowAnimation:UITableViewRowAnimationLeft
                                               ];
                                              completionHandler(YES);
                                          }
     ];
    UISwipeActionsConfiguration *swipeConfiguration = [UISwipeActionsConfiguration configurationWithActions:@[action]];
    return swipeConfiguration;
}

#pragma mark - Conforming to TagTableViewCellListener

- (void)tapOnCellRecognized:(float)time {
    [self.videoPlayerView seekToSeconds:time allowSeekAhead:YES];
}

#pragma mark - Conforming to WKYTPlayerViewDelegate

- (void)playerViewDidBecomeReady:(WKYTPlayerView *)playerView {
    [_videoPlayerImageView setHidden:YES];
    [_videoPlayerView setHidden:NO];
    [_videoPlayerIndicator stopAnimating];
}

@end

