//
//  ViewController.m
//  GreenTeamProject
//
//  Created by Roma on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "ViewController.h"
#import "VideoLauncher/VideoLauncher.h"

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
    self.statusBarHidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    VideoLauncher *videoLauncher = [VideoLauncher new];
    NSString *videoURL =
    @"https://www.youtu.be/watch?v=Ummvu4BXlRA";
    [videoLauncher showVideoWithURL:videoURL];
}

@end
