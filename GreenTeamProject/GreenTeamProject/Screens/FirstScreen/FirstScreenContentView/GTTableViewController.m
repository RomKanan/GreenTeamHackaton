//
//  GTTableViewController.m
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/14/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "GTTableViewController.h"
#import "GTTableViewHeader.h"
#import "GTTagTableViewCell.h"
#import "GTTopicTableViewCell.h"
#import "GTTopic.h"
#import "GTTag.h"

@interface GTTableViewController ()
@end

@implementation GTTableViewController

static NSString * const reuseTopicIdentifier = @"cellTopic";
static NSString * const reuseTagIdentifier = @"cellTag";
static NSString * const reuseHeaderIdentifier = @"header";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsSelection = NO;
    
    [self.tableView registerClass:GTTagTableViewCell.class forCellReuseIdentifier:reuseTagIdentifier];
    [self.tableView registerClass:GTTopicTableViewCell.class forCellReuseIdentifier:reuseTopicIdentifier];
    [self.tableView registerClass:GTTableViewHeader.class forHeaderFooterViewReuseIdentifier:reuseHeaderIdentifier];
    
    self.tableView.estimatedRowHeight = 50.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(redirectToNextViewController:) name:@"RedirectToNextViewController" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(redirectToPreviosViewController:) name:@"RedirectToPreviosViewController" object:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.items[indexPath.row] isKindOfClass:GTTopic.class]) {
        GTTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseTopicIdentifier forIndexPath:indexPath];
        cell.nameLabel.text = ((GTTopic *)self.items[indexPath.row]).name;
        if (((GTTopic *)self.items[indexPath.row]).topics.count > 0)
            cell.subCountLabel.text = [NSString stringWithFormat:@"subs:%ld", ((GTTopic *)self.items[indexPath.row]).topics.count];
        if (((GTTopic *)self.items[indexPath.row]).tags.count > 0)
            cell.tagCountLabel.text = [NSString stringWithFormat:@"tags:%ld", ((GTTopic *)self.items[indexPath.row]).tags.count];
        cell.topic = ((GTTopic *)self.items[indexPath.row]);
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.parentViewController isKindOfClass:GTTableViewController.class]) {
        GTTableViewHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseHeaderIdentifier];
        header.contentView.backgroundColor = [UIColor colorWithRed:255.f/255.f green:36.f/255.f blue:0.f alpha:1.f];
        header.directoryNameLabel.text = self.parentDirectoryName;
        return header;
    }
    else {
        UITableViewHeaderFooterView *header = [[UITableViewHeaderFooterView alloc] init];
        header.contentView.backgroundColor = [UIColor colorWithRed:255.f/255.f green:36.f/255.f blue:0.f alpha:1.f];
        return header;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.f;
}

- (void)redirectToNextViewController:(NSNotification *)notification {
    GTTableViewController *tableViewController = [[GTTableViewController alloc] init];
    
    [self addChildViewController:tableViewController];
    [tableViewController didMoveToParentViewController:self];
    
    [self.view addSubview:tableViewController.tableView];
    tableViewController.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [tableViewController.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
                                              [tableViewController.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
                                              [tableViewController.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                              [tableViewController.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]]];
    
    tableViewController.items = notification.userInfo[@"items"];
    tableViewController.parentDirectoryName = notification.userInfo[@"topicName"];
}

- (void)redirectToPreviosViewController:(NSNotification *)notification {
    GTTableViewController *viewController = self.childViewControllers.lastObject;
    [viewController willMoveToParentViewController:nil];
    [viewController.tableView removeFromSuperview];
    [viewController removeFromParentViewController];
}

@end
