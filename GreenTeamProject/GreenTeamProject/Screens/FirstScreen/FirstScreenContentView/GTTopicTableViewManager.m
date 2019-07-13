//
//  GTTableViewManager.m
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/13/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "GTTopicTableViewManager.h"
#import "GTTopicTableViewCell.h"
#import "GTTagTableViewCell.h"
#import "GTTopic.h"
#import "GTTag.h"


@implementation GTTopicTableViewManager

@synthesize items;

static NSString * const reuseTopicIdentifier = @"cellTopic";
static NSString * const reuseTagIdentifier = @"cellTag";

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    if ([self.items[indexPath.row] isKindOfClass:GTTopic.class]) {
        GTTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseTopicIdentifier forIndexPath:indexPath];
        cell.nameLabel.text = ((GTTopic *)self.items[indexPath.row]).name;
        NSMutableArray *arrayForTopicsAndTags = [[NSMutableArray alloc] initWithArray:((GTTopic *)self.items[indexPath.row]).topics];
        [arrayForTopicsAndTags addObjectsFromArray:((GTTopic *)self.items[indexPath.row]).tags];
        
        cell.manager.items = arrayForTopicsAndTags;
        [cell.moreButton setTitle:@"more" forState:UIControlStateNormal];
        [cell.moreButton setTitle:@"less" forState:UIControlStateHighlighted];
        return cell;
    } else if ([self.items[indexPath.row] isKindOfClass:GTTag.class]) {
        GTTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseTagIdentifier forIndexPath:indexPath];
        cell.nameLabel.text = ((GTTag *)self.items[indexPath.row]).name;
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return self.items.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100.f;
//}

@end
