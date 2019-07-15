//
//  ViewController.m
//  GreenTeamProject
//
//  Created by Roma on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "ViewController.h"
#import "VideoLauncher/VideoLauncher.h"
#import "VideoLauncher/VideoLauncher TableView/GTTag.h"

@interface ViewController () <VideoLauncherListener>

@property (nonatomic, strong) VideoLauncher *videoLauncher;

@property (assign, nonatomic) BOOL statusBarHidden;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self tapOnVideo];
}

- (BOOL)prefersStatusBarHidden {
    return self.statusBarHidden;
}

- (void)tapOnVideo {
//    VideoImageLoader *videoImageLoader = [VideoImageLoader new];
//    [videoImageLoader loadImageAtURL: videoURL];
//    return;
    self.statusBarHidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    GTVideo *video =
    [[GTVideo alloc] initWithURLString:@"https://www.youtube.com/watch?v=TBCWLZn1970"];
    GTTag *firstTag = [[GTTag alloc] initWithVideo:video color:[UIColor blackColor] name:@"TAG_NAME_1" time:40];
    GTTag *secondTag = [[GTTag alloc] initWithVideo:video color:[UIColor redColor] name:@"TAG_NAME_2" time:50];
    GTTag *thirdTag = [[GTTag alloc] initWithVideo:video color:[UIColor blueColor] name:@"TAG_NAME_3" time:60];
    video.tags = [NSMutableArray arrayWithArray:@[firstTag, secondTag, thirdTag]];
    self.videoLauncher = [[VideoLauncher alloc] initWithVideo:video];
    [self.videoLauncher play];
}

- (void)deleteVideoLauncher {
    self.videoLauncher = nil;
}

@end
