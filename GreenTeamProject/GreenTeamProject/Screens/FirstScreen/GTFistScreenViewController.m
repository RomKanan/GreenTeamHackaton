//
//  GTFistScreenViewController.m
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "GTFistScreenViewController.h"
#import "GTTopicTableViewCell.h"
#import "GTTopic.h"

@interface GTFistScreenViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray<GTTopic *> *items;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation GTFistScreenViewController

static NSString * const reuseIdentifier = @"cellId";

- (void)createTopics {
    GTTag *tag = [[GTTag alloc] initWithColor:[UIColor greenColor] andName:@"TableView delegates"];
    
    GTTopic *topic1 = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[tag]] topics:[[NSMutableArray alloc] initWithArray:@[]] andName:@"TableView"];
    
    GTTopic *topic2 = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[]] topics:[[NSMutableArray alloc] initWithArray:@[]] andName:@"App Life Cycle"];
    GTTopic *topic3 = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[]] topics:[[NSMutableArray alloc] initWithArray:@[]] andName:@"CollectionView"];
    
    GTTopic *topicS = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[]] topics:[[NSMutableArray alloc] initWithArray:@[topic1, topic2, topic3]] andName:@"Objective C"];
    
    GTTopic *topicF = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[]] topics:[[NSMutableArray alloc] initWithArray:@[]] andName:@"Swift"];
    
    GTTopic *topic = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[]] topics:[[NSMutableArray alloc] initWithArray:@[topicF, topicS]] andName:@"iOS"];
    GTTopic *stopic = [[GTTopic alloc] initWithTags:[[NSMutableArray alloc] initWithArray:@[]] topics:[[NSMutableArray alloc] initWithArray:@[]] andName:@"Coocking"];
    
    self.items = @[topic, stopic];
}

- (void)loadView {
    [super loadView];
    
    [self createTopics];
    
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:10],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-10],
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:10],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-5]]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass:GTTopicTableViewCell.class forCellReuseIdentifier:reuseIdentifier];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 300;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewRowHeightDidChanged:) name:@"TableViewDidChanged" object:nil];
}

#pragma mark - TableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GTTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSMutableArray *arrayForTopicsAndTags = [[NSMutableArray alloc] initWithArray:self.items[indexPath.row].topics];
    [arrayForTopicsAndTags addObjectsFromArray:self.items[indexPath.row].tags];
    
    cell.nameLabel.text = self.items[indexPath.row].name;
    cell.manager.items = arrayForTopicsAndTags;
    [cell.moreButton setTitle:@"more" forState:UIControlStateNormal];
    [cell.moreButton setTitle:@"less" forState:UIControlStateHighlighted];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

#pragma mark - Notifications

- (void)tableViewRowHeightDidChanged:(NSNotification *)notification {
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

@end
