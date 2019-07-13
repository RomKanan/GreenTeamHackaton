//
//  ViewController.m
//  GreenTeamProject
//
//  Created by Roma on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "ViewController.h"
#import "VideoLauncher/VideoLauncher.h"
#import "VideoLauncher/VideoImageLoader.h"

@interface ViewController ()

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
    NSString *videoID = @"13flvY-cbUw";
//    VideoImageLoader *videoImageLoader = [VideoImageLoader new];
//    [videoImageLoader loadImageAtURL: videoURL];
//    return;
    self.statusBarHidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    VideoLauncher *videoLauncher = [VideoLauncher new];
    [videoLauncher showVideoWithID:videoID];
}

@end
