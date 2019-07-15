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
    
    if(![self isOnLine]){
        [self presentLineAlert];
        return;
    }
    
    if(![self isYouTubeURL:self.urlTextField.text]){
        [self presentURLAlert];
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
    
    
    
    
    
    __block BOOL isConnected = YES;
        NSURL *url = [[NSURL alloc] initWithString:@"https://www.google.com"];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"aaa");
            if (response) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    isConnected = YES;
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    isConnected = NO;
                });
            }
        }];
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
