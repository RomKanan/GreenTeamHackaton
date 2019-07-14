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
#import "VideoLauncher TableView/GTTag.h"
#import "VideoLauncher TableView/VideoNameHeaderView.h"
#import <WebKit/WebKit.h>

@interface VideoLauncher () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *videoPlayerPageView;
@property (nonatomic, strong) WKWebView *videoPlayerWebView;
@property (nonatomic, strong) UITableView *tagsTableView;
@property (nonatomic, strong) UIButton *addTagButton;

@property (nonatomic, strong) NSMutableArray<GTTag *> *tags; //create tag class with appropriate info
@property (nonatomic, strong) NSString *videoName;

@end

@implementation VideoLauncher

- (instancetype)initWithTags:(NSMutableArray *)tags videoName:(NSString *)videoName {
    self = [super init];
    if (self) {
        [self setupVideoPlayerPageView];
        [self setupVideoPlayerView];
        [self setupTagsTableView];
        [self setupActionButtons];
        _tags = tags;
        _videoName = videoName;
    }
    return self;
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
    WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
    webViewConfiguration.allowsInlineMediaPlayback = NO;
    _videoPlayerWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:webViewConfiguration];
    
    NSURL *url = [[NSURL alloc] initWithString:@"https://www.youtube.com/embed/VXu2Od_lCe8?start=68"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [_videoPlayerWebView loadRequest:urlRequest];
    _videoPlayerWebView.translatesAutoresizingMaskIntoConstraints = NO;
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    if (!keyWindow) {
        return;
    }
    [_videoPlayerPageView addSubview:_videoPlayerWebView];
    _videoPlayerWebView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_videoPlayerWebView.leadingAnchor constraintEqualToAnchor:_videoPlayerPageView.leadingAnchor],
                                              [_videoPlayerWebView.topAnchor constraintEqualToAnchor:_videoPlayerPageView.topAnchor],
                                              [_videoPlayerWebView.widthAnchor constraintEqualToConstant:keyWindow.frame.size.width],
                                              [_videoPlayerWebView.heightAnchor constraintEqualToConstant:keyWindow.frame.size.width * videoLauncherConstants.heightProportion / videoLauncherConstants.widthProportion],
                                              ]
     ];
}

- (void)setupTagsTableView {
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    if (!keyWindow) {
        return;
    }
    _tagsTableView = [UITableView new];
    _tagsTableView.tableFooterView = [UIView new];
    _tagsTableView.backgroundColor = [UIColor whiteColor];
    //edit separator to leading = superView leading
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
                                              [_tagsTableView.topAnchor constraintEqualToAnchor:_videoPlayerWebView.bottomAnchor],
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
    //add tag
}

- (void)showVideoWithID:(NSString *)videoID {
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    if (!keyWindow) {
        return;
    }
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.videoPlayerPageView.frame = keyWindow.frame;
    } completion:^(BOOL finished) {
    }];
    
    //give VideoPlayerView an image of video to place it instead of video while loading
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //to see loading indicator...
//        [self.videoPlayerView setVideoID:videoID];
    });
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

@end
