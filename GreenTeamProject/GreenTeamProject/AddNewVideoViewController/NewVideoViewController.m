//
//  NewVideoViewController.m
//  GreenTeamProject
//
//  Created by Roma on 7/15/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "NewVideoViewController.h"
#import "GTVideo.h"


@interface NewVideoViewController ()
@property (strong, nonatomic)NSMutableDictionary<NSString*, GTVideo*> *videous;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progressIndicator;

@end

@implementation NewVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // placeholder code to upload Dictionary of GTVideo from storage
}

- (IBAction)startButtonPressed:(id)sender {
    self.overlayView.hidden = NO;
    [self.progressIndicator startAnimating];
    
    if(![self isYouTubeURL:self.urlTextField.text]){
        [self presentURLAlert];
        return;
    }
    
    if(![self isOnLine]){
        [self presentLineAlert];
        return;
    }
    
    GTVideo *video = [[GTVideo alloc] initWithLink:self.urlTextField.text];
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
    
    
}

- (BOOL)isYouTubeURL:(NSString *)url{
    //placeholder
    return YES;
}

- (BOOL) isOnLine{
    //placeholder
    return YES;
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
