//
//  GTCollectionViewManager.m
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/13/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "GTCollectionViewManager.h"
#import "GTTopicCollectionViewCell.h"
#import "GTTagCollectionViewCell.h"
#import "GTTopic.h"
#import "GTTag.h"

@implementation GTCollectionViewManager

static NSString * const topicIdentifier = @"cellTopic";
static NSString * const tagIdentifier = @"cellTag";


- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:@"name1" object:nil];
    }
    return self;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if ([self.items[indexPath.item] isKindOfClass:GTTopic.class]) {
        GTTopicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:topicIdentifier forIndexPath:indexPath];
        
        NSMutableArray *arrayForItems = [[NSMutableArray alloc] initWithArray:((GTTopic *)self.items[indexPath.item]).topics];
        [arrayForItems addObjectsFromArray:((GTTopic *)self.items[indexPath.item]).tags];
        
        cell.nameLabel.text = ((GTTopic *)self.items[indexPath.item]).name;
        cell.manager.items = arrayForItems;
        cell.supertopic = ((GTTopic *)self.items[indexPath.item]);
        cell.superCollectionView = collectionView;
        cell.collectionView.hidden = ((GTTopic *)self.items[indexPath.item]).isSelected ? NO : YES;
//        NSLog(@"%@ - %d", cell.nameLabel.text, cell.supertopic.isSelected );
        
        return cell;
    } else {
        GTTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:tagIdentifier forIndexPath:indexPath];
        cell.nameLabel.text = ((GTTag *)self.items[indexPath.item]).name;
        return cell;
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%f", [self calculateCurrentContentHeightForItemAtIndex:indexPath.item]);
    return CGSizeMake(200, [self calculateCurrentContentHeightForItemAtIndex:indexPath.item]);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.f;
}

- (void)reload {
    
}

- (CGFloat)calculateCurrentContentHeightForItemAtIndex:(NSInteger)index {
    
    return [self calculateSubtopicsHeightOfTopic:self.items[index]];
}

- (CGFloat)calculateSubtopicsHeightOfTopic:(id)object {
    CGFloat defaultHeight = 50.f;
    CGFloat height = 0.f;
    CGFloat insets = 7.f;
    if ([object isKindOfClass:GTTopic.class]) {
        GTTopic *topic = (GTTopic *)object;
        if (topic.topics.count == 0 && topic.tags.count == 0) {
            return defaultHeight;
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
            height += topic.topics.count * insets + topic.tags.count * insets;
        } else {
            height += defaultHeight;
        }
        
    }
    return height;
}

@end
