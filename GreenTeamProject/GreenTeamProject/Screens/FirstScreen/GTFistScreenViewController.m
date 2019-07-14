//
//  GTFistScreenViewController.m
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "GTFistScreenViewController.h"
#import "GTTableViewController.h"
#import "GTTagTableViewCell.h"
#import "GTTopicTableViewCell.h"
#import "GTTopic.h"
#import "GTTag.h"

@interface GTFistScreenViewController ()
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation GTFistScreenViewController

- (void)createTopics {
    GTTag *tag = [[GTTag alloc] initWithColor:[UIColor greenColor] name:@"TableView delegates"];
    
    GTTopic *topic1 = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[tag]] topics:[[NSMutableArray alloc] initWithArray:@[]] name:@"TableView"];
    
    GTTopic *topic2 = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[]] topics:[[NSMutableArray alloc] initWithArray:@[]] name:@"App Life Cycle"];
    GTTopic *topic3 = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[]] topics:[[NSMutableArray alloc] initWithArray:@[]] name:@"CollectionView"];
    
    GTTopic *topicS = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[tag]] topics:[[NSMutableArray alloc] initWithArray:@[topic1, topic2, topic3]] name:@"Objective C"];
    
    GTTopic *topicF = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[]] topics:[[NSMutableArray alloc] initWithArray:@[]] name:@"Swift"];
    
    GTTopic *topic = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[]] topics:[[NSMutableArray alloc] initWithArray:@[topicF, topicS]] name:@"iOS"];
    GTTopic *stopic = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[]] topics:[[NSMutableArray alloc] initWithArray:@[]] name:@"Coocking"];
    
    self.items = [[NSMutableArray alloc] initWithArray: @[topic, stopic]];
}

- (void)loadView {
    [super loadView];
    
    [self createTopics];
    
    GTTableViewController *tableViewController = [[GTTableViewController alloc] init];
    
    [self addChildViewController:tableViewController];
    [tableViewController didMoveToParentViewController:self];
    
    [self.view addSubview:tableViewController.tableView];
    tableViewController.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [tableViewController.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:20],
        [tableViewController.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-20],
        [tableViewController.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20],
        [tableViewController.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-20]]];
    
    
    tableViewController.items = self.items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
