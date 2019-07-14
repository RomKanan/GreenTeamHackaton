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
#import "VideoLauncher/VideoLauncher TableView/GTTag.h"

@interface ViewController ()

@property (nonatomic, strong) VideoLauncher *videoLauncher;

@end

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
    NSString *videoName = @"VIDEO NAME";
    GTTag *firstTag = [[GTTag alloc] initWithURLString:@"URL_1" color:[UIColor blackColor] name:@"TAG_NAME_1" time:1];
    GTTag *secondTag = [[GTTag alloc] initWithURLString:@"URL_2" color:[UIColor redColor] name:@"TAG_NAME_2" time:2];
    GTTag *thirdTag = [[GTTag alloc] initWithURLString:@"URL_3" color:[UIColor blueColor] name:@"TAG_NAME_3" time:3];
    NSMutableArray *tags = [NSMutableArray arrayWithArray:@[firstTag, secondTag, thirdTag]];
    self.videoLauncher = [[VideoLauncher alloc] initWithTags:tags videoName:videoName];
    [self.videoLauncher showVideoWithID:videoID];
}

@end
