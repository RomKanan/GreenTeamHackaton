//
//  NewVideoViewController.m
//  GreenTeamProject
//
//  Created by Roma on 7/15/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//
#import "VideoLauncherViewController.h"
#import "NewVideoViewController.h"
#import "GTVideo.h"
#import "Reachability.h"


@interface NewVideoViewController ()
@property (strong, nonatomic)NSMutableDictionary<NSString*, GTVideo*> *videous;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressIndicator;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerConstraint;

@end

@implementation NewVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // placeholder code to upload Dictionary of GTVideo from storage
}




- (IBAction)startButtonPressed:(id)sender {
    self.overlayView.hidden = NO;
    [self.progressIndicator startAnimating];
    [self.urlTextField resignFirstResponder];
    
    if(![self isOnLine]){
        [self presentLineAlert];
        return;
    }
    
    if(![self isYouTubeURL:self.urlTextField.text]){
        [self presentURLAlert];
        return;
    }
    
    
    
    GTVideo *video = [[GTVideo alloc] initWithURLString:self.urlTextField.text];
    
    
    
    GTVideo *videoToPresent;
    if (self.videous == nil) {
        self.videous = [NSMutableDictionary new];
    }
    
    if ([self.videous objectForKey:video.ID]) {
        videoToPresent = [self.videous objectForKey:video.ID];
    } else {
        [self.videous setObject:video forKey:video.ID];
        videoToPresent = video;
    }
    
    // placeholder code to present videoToPresent
    VideoLauncherViewController *videoVC = [[VideoLauncherViewController alloc] initWithVideo:video];
    [self addChildViewController:videoVC];
    [self.containerView addSubview:videoVC.view];
    videoVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
     [videoVC.view.topAnchor constraintEqualToAnchor:self.containerView.topAnchor],
     [videoVC.view.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor],
     [videoVC.view.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor],
     [videoVC.view.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor]]];
    [videoVC didMoveToParentViewController:self];
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.containerConstraint.constant = CGRectGetHeight(self.view.bounds);
    } completion:nil];
    
    [videoVC play];
    
    
}

- (BOOL)isYouTubeURL:(NSString *)url{
    NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                    options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    
    NSArray *array = [regExp matchesInString:url options:0 range:NSMakeRange(0,url.length)];
    if (array.count > 0) {
        return YES;
    }
    return NO;
}

- (BOOL) isOnLine{
    BOOL isConnected = YES;
    Reachability  *checker = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus status = [checker currentReachabilityStatus];
    
    if (status == NotReachable)
        isConnected = NO;
    else
        isConnected = YES;
    return isConnected;
}

- (void) presentURLAlert{
    __weak typeof(self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"It's not YouTube URL" message:@"please enter correct url for youtube video" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *close = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.urlTextField.text = @"";
        [weakSelf.progressIndicator stopAnimating];
        weakSelf.overlayView.hidden = YES;
    }];
    [alert addAction:close];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) presentLineAlert{
    __weak typeof(self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No internet connection" message:@"Establish internet connection and try again" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *close = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.progressIndicator stopAnimating];
        weakSelf.overlayView.hidden = YES;
    }];
    [alert addAction:close];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
