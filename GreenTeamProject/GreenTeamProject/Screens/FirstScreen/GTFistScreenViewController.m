//
//  GTFistScreenViewController.m
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "GTFistScreenViewController.h"
#import "GTTopicCollectionViewCell.h"
#import "GTTopic.h"
#import "GTTag.h"

@interface GTFistScreenViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray<GTTopic *> *items;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation GTFistScreenViewController

static NSString * const topicIdentifier = @"cellTopic";

- (void)createTopics {
    GTTag *tag = [[GTTag alloc] initWithColor:[UIColor greenColor] name:@"TableView delegates"];
    
    GTTopic *topic1 = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[tag]] topics:[[NSMutableArray alloc] initWithArray:@[]] name:@"TableView"];
    
    GTTopic *topic2 = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[]] topics:[[NSMutableArray alloc] initWithArray:@[]] name:@"App Life Cycle"];
    GTTopic *topic3 = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[]] topics:[[NSMutableArray alloc] initWithArray:@[]] name:@"CollectionView"];
    
    GTTopic *topicS = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[]] topics:[[NSMutableArray alloc] initWithArray:@[topic1, topic2, topic3]] name:@"Objective C"];
    
    GTTopic *topicF = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[]] topics:[[NSMutableArray alloc] initWithArray:@[]] name:@"Swift"];
    
    GTTopic *topic = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[]] topics:[[NSMutableArray alloc] initWithArray:@[topicF, topicS]] name:@"iOS"];
    GTTopic *stopic = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[]] topics:[[NSMutableArray alloc] initWithArray:@[]] name:@"Coocking"];
    
    self.items = [[NSMutableArray alloc] initWithArray: @[topic, stopic]];
}

- (void)loadView {
    [super loadView];
    
    [self createTopics];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.collectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:GTTopicCollectionViewCell.class forCellWithReuseIdentifier:topicIdentifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:@"name" object:nil];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GTTopicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:topicIdentifier forIndexPath:indexPath];
    NSMutableArray *arrayForItems = [[NSMutableArray alloc] initWithArray:self.items[indexPath.item].topics];
    [arrayForItems addObjectsFromArray:self.items[indexPath.item].tags];
    
    cell.collectionView.hidden = self.items[indexPath.item].isSelected ? NO : YES;
    cell.nameLabel.text = self.items[indexPath.item].name;
    cell.manager.items = arrayForItems;
    cell.supertopic = self.items[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%f",  [self calculateCurrentContentHeightForItemAtIndex:indexPath.item]);
    return CGSizeMake(self.view.frame.size.width, [self calculateCurrentContentHeightForItemAtIndex:indexPath.item]);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.f;
}

- (void)reload {
    [self.collectionView reloadData];
}

- (CGFloat)calculateCurrentContentHeightForItemAtIndex:(NSInteger)index {
    
    return [self calculateSubtopicsHeightOfTopic:self.items[index]];
}

- (CGFloat)calculateSubtopicsHeightOfTopic:(GTTopic *)topic {
    CGFloat defaultHeight = 50.f;
    CGFloat height = defaultHeight;
    if (topic.topics == nil && topic.tags == nil) {
        return 0.f;
    }
    
    if (topic.isSelected) {
        if (topic.topics != nil) {
            for (GTTopic *topicItem in topic.topics) {
                height += [self calculateSubtopicsHeightOfTopic:topicItem];
            }
        }
        if (topic.tags != nil) {
            for (GTTag *tag in topic.tags) {
                height += defaultHeight;
            }
        }
    }
    return height;
}

- (CGFloat)calculateTagsHeightOfTopic:(GTTopic *)topic {
    return 0;
}

@end
