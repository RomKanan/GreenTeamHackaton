//
//  AddTagViewController.m
//  GreenTeamProject
//
//  Created by Roma on 7/14/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "AddTagViewController.h"
#import "GTVideo.h"
#include <math.h>
@interface AddTagViewController ()

@property (strong, nonatomic) GTVideo *video;
@property (assign, nonatomic) NSTimeInterval lenght;
@property (assign, nonatomic) NSTimeInterval curentTime;
@property (weak, nonatomic) IBOutlet UILabel *videoNameLable;
@property (weak, nonatomic) IBOutlet UILabel *curentTimeLable;
@property (weak, nonatomic) IBOutlet UITextField *tagNameTextField;
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;
@property (weak, nonatomic) IBOutlet UILabel *chosenGroupLable;
@property (weak, nonatomic) IBOutlet UILabel *groupPlaceholderLable;
@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;

@end

@implementation AddTagViewController

- (instancetype)initWithVideo:(GTVideo*)video Name:(NSString*)name curentTime:(NSTimeInterval)time lenght:(NSTimeInterval)lenght {
    self = [super init];
    if (self) {
        self.videoNameLable.text = name;
        self.curentTime = time;
        self.lenght = lenght;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupView {
    self.timeSlider.minimumValue = 0.0;
    self.timeSlider.maximumValue = self.lenght;
    [self.timeSlider addTarget:self action:@selector(sliderValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.timeSlider setValue:self.curentTime];
    self.curentTimeLable.text = [self stringFromTimeInterval:self.curentTime];
    self.chosenGroupLable.hidden = YES;
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)time{
    if (time < 60.0){
        return [NSString stringWithFormat:@"0:%f", time];
    } else if (time >= 3600) {
        NSInteger hour = time / 3600;
        NSInteger minute = fmod(time, 3600.0) / 60;
        NSInteger secunds = fmod(time, 60);
        return [NSString stringWithFormat:@"%ld:%ld:%ld", hour, minute, secunds];
    }
    
    NSInteger minute = fmod(time, 3600.0) / 60;
    NSInteger secunds = fmod(time, 60);
    return [NSString stringWithFormat:@"%ld:%ld", minute, secunds];
}

- (UIColor*)randomColor {
    CGFloat red = ((float)arc4random_uniform(255)) / 255.f;
    CGFloat green = ((float)arc4random_uniform(255)) / 255.f;
    CGFloat blue = ((float)arc4random_uniform(255)) / 255.f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
    
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    self.curentTime = sender.value;
    self.curentTimeLable.text = [self stringFromTimeInterval:self.curentTime];
}

- (IBAction)addTag:(id)sender{
    
}

- (IBAction)cancelAdding:(id)sender{
    
}

@end
