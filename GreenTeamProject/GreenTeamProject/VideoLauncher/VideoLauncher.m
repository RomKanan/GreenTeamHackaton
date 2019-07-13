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
#import "VideoLauncher TableView/TagTableViewCell.h"
#import "VideoLauncher TableView/GTTag.h"
#import "VideoLauncher TableView/VideoNameHeaderView.h"

@interface VideoLauncher () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *videoPlayerPageView;
@property (nonatomic, strong) VideoPlayerView *videoPlayerView;
@property (nonatomic, strong) UITableView *tagsTableView;
@property (nonatomic, strong) UIButton *deleteTagButton; // + to swipe deletion
@property (nonatomic, strong) UIButton *addTagButton;

@property (nonatomic, strong) NSMutableArray<GTTag *> *tags; //create tag class with appropriate info
@property (nonatomic, strong) NSString *videoName;

@end

@implementation VideoLauncher

- (instancetype)initWithTags:(NSMutableArray *)tags videoName:(NSString *)videoName {
    self = [super init];
    if (self) {
//        tags = [NSMutableArray new];
        GTTag *firstTag = [[GTTag alloc] initWithURLString:@"123" color:[UIColor blackColor] name:@"HELLO!" time:1];
        GTTag *secondTag = [[GTTag alloc] initWithURLString:@"234" color:[UIColor redColor] name:@"TO!" time:2];
        GTTag *thirdTag = [[GTTag alloc] initWithURLString:@"345" color:[UIColor blueColor] name:@"EVERYBODY!" time:3];
        tags = [NSMutableArray arrayWithArray:@[firstTag, secondTag, thirdTag]];
        [self setupVideoPlayerPageView];
        [self setupVideoPlayerView];
        [self setupTagsTableView];
        [self setupActionButtons];
        _tags = tags;
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
    _videoPlayerView = [VideoPlayerView new];
    _videoPlayerView.backgroundColor = [UIColor clearColor];
    [_videoPlayerPageView addSubview:_videoPlayerView];
    _videoPlayerView.translatesAutoresizingMaskIntoConstraints = NO;
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    if (!keyWindow) {
        return;
    }
    [NSLayoutConstraint activateConstraints:@[
                                              [_videoPlayerView.leadingAnchor constraintEqualToAnchor:_videoPlayerPageView.leadingAnchor],
                                              [_videoPlayerView.topAnchor constraintEqualToAnchor:_videoPlayerPageView.topAnchor],
                                              [_videoPlayerView.widthAnchor constraintEqualToConstant:keyWindow.frame.size.width],
                                              [_videoPlayerView.heightAnchor constraintEqualToConstant:keyWindow.frame.size.width * videoLauncherConstants.widthProportion / videoLauncherConstants.heightProportion],
                                              ]
     ];
}

- (void)setupTagsTableView {
    UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    if (!keyWindow) {
        return;
    }
    _tagsTableView = [UITableView new];
    _tagsTableView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
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
                                              [_tagsTableView.heightAnchor constraintEqualToConstant:keyWindow.frame.size.height - videoLauncherConstants.buttonHeight - videoLauncherConstants.tableViewActionButtonSpacing],
                                              ]
     ];
}

- (void)setupActionButtons {
    _deleteTagButton = [UIButton new];
    _addTagButton = [UIButton new];
    [_videoPlayerPageView addSubview:_deleteTagButton];
    [_videoPlayerPageView addSubview:_addTagButton];
    _deleteTagButton.translatesAutoresizingMaskIntoConstraints = NO;
    _addTagButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_deleteTagButton.leadingAnchor constraintEqualToAnchor:_videoPlayerPageView.safeAreaLayoutGuide.leadingAnchor],
                                              [_deleteTagButton.bottomAnchor constraintEqualToAnchor:_videoPlayerPageView.safeAreaLayoutGuide.bottomAnchor],
                                              [_deleteTagButton.heightAnchor constraintEqualToConstant:videoLauncherConstants.buttonHeight],
                                              [_deleteTagButton.widthAnchor constraintEqualToConstant:videoLauncherConstants.buttonWidth],
                                              [_addTagButton.trailingAnchor constraintEqualToAnchor:_videoPlayerPageView.safeAreaLayoutGuide.trailingAnchor],
                                              [_deleteTagButton.bottomAnchor constraintEqualToAnchor:_videoPlayerPageView.safeAreaLayoutGuide.bottomAnchor],
                                              [_deleteTagButton.heightAnchor constraintEqualToConstant:videoLauncherConstants.buttonHeight],
                                              [_deleteTagButton.widthAnchor constraintEqualToConstant:videoLauncherConstants.buttonWidth],
                                              ]
     ];
    //add actions...
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
        [self.videoPlayerView setVideoID:videoID];
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

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:videoLauncherConstants.tagCellIdentifier
                                                             forIndexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    VideoNameHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:videoLauncherConstants.sectionHeaderViewIdentifier];
    [headerView setVideoName:self.videoName];
    return headerView;
}


- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
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
