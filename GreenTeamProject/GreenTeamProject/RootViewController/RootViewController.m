//
//  RootViewController.m
//  GreenTeamProject
//
//  Created by Roma on 7/14/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "RootViewController.h"
#import "CollectionViewCell.h"
#import "GTFistScreenViewController.h"
#import "NewVideoViewController.h"



@interface RootViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIView *sliderView;
@property (weak, nonatomic) IBOutlet UIImageView *tagsNormalImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tagsHighlitedImageView;
@property (weak, nonatomic) IBOutlet UIImageView *videoNormalImageView;
@property (weak, nonatomic) IBOutlet UIImageView *videoHighlitedImageView;
@property (weak, nonatomic) IBOutlet UIButton *tagsButton;
@property (weak, nonatomic) IBOutlet UIButton *videoButton;

@end

@implementation RootViewController
static NSString* const containerCell = @"containerCell";
static NSString* const contentOffset = @"contentOffset";
static NSString* const sliderCenter = @"center";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:containerCell];
    [self.collectionView addObserver:self forKeyPath:contentOffset options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    [self.sliderView addObserver:self forKeyPath:sliderCenter options:NSKeyValueObservingOptionNew context:nil];
    
}

#pragma mark: CollectionViewDelegate and DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:containerCell forIndexPath:indexPath];
    if (indexPath.item == 0) {
        GTFistScreenViewController *tree = [GTFistScreenViewController new];
        [self addChildViewController:tree];
        [cell addSubview:tree.view];
        tree.view.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
            [tree.view.topAnchor constraintEqualToAnchor:cell.containerView.topAnchor],
            [tree.view.leadingAnchor constraintEqualToAnchor:cell.leadingAnchor],
            [tree.view.trailingAnchor constraintEqualToAnchor:cell.trailingAnchor],
            [tree.view.bottomAnchor constraintEqualToAnchor:cell.containerView.bottomAnchor]]];
        [tree didMoveToParentViewController:self];
    } else {
        NewVideoViewController *video = [NewVideoViewController new];
        [self addChildViewController:video];
        [cell addSubview:video.view];
        video.view.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
            [video.view.topAnchor constraintEqualToAnchor:cell.containerView.topAnchor],
            [video.view.leadingAnchor constraintEqualToAnchor:cell.leadingAnchor],
            [video.view.trailingAnchor constraintEqualToAnchor:cell.trailingAnchor],
            [video.view.bottomAnchor constraintEqualToAnchor:cell.containerView.bottomAnchor]]];
       
        [video didMoveToParentViewController:self];

    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds));
}



#pragma mark: Slider and navButtons observing
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:contentOffset]) {
        CGPoint oldOffset = [[change objectForKey:NSKeyValueChangeOldKey] CGPointValue];
        CGPoint newOffset = [[change objectForKey:NSKeyValueChangeNewKey] CGPointValue];
        CGFloat fraction = (newOffset.x - oldOffset.x) / (self.collectionView.contentSize.width - self.collectionView.bounds.size.width);
        CGFloat tagCenter = self.tagsButton.center.x;
        CGFloat videoCenter = self.videoButton.center.x;
        CGFloat selectionWay = videoCenter - tagCenter;
        CGFloat selectorCenter = self.sliderView.center.x;
        if (!isnan(fraction)) {
            self.sliderView.center = CGPointMake(selectorCenter + (selectionWay * fraction), self.sliderView.center.y);
        }
    }
    
    if ([keyPath isEqualToString:sliderCenter]) {
        CGFloat newCenterX = [[change objectForKey:NSKeyValueChangeNewKey] CGPointValue].x;
        CGFloat tagCenter = self.tagsButton.center.x;
        CGFloat videoCenter = self.videoButton.center.x;
        CGFloat visionDistance = (videoCenter - tagCenter);
        
        if (newCenterX <= tagCenter) {
            self.tagsHighlitedImageView.alpha = 1;
            self.videoHighlitedImageView.alpha = 0;
        }
        if ((newCenterX > tagCenter) && (newCenterX < videoCenter)) {
            self.tagsHighlitedImageView.alpha = (videoCenter - newCenterX) / visionDistance;
            self.videoHighlitedImageView.alpha = (newCenterX - tagCenter) / visionDistance;
        }  if (newCenterX >= videoCenter) {
            self.tagsHighlitedImageView.alpha = 0;
            self.videoHighlitedImageView.alpha = 1;
        }


    }
}

#pragma mark: Navigation
- (IBAction)tagsButtonPressed:(id)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [UIView animateWithDuration:0.2 animations:^{
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone  animated:NO];
    }];

}
- (IBAction)videoButtonPressed:(id)sender {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    [UIView animateWithDuration:0.2 animations:^{
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone  animated:NO];
    }];
}



@end
