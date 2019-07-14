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

@interface GTFistScreenViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation GTFistScreenViewController
static NSString * const reuseTopicIdentifier = @"cellTopic";
static NSString * const reuseTagIdentifier = @"cellTag";

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

    
    
//    [self.tableView registerClass:GTTagTableViewCell.class forCellReuseIdentifier:reuseTagIdentifier];
//    [self.tableView registerClass:GTTopicTableViewCell.class forCellReuseIdentifier:reuseTopicIdentifier];
//
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(redirectToNextViewController:) name:@"RedirectToNextViewController" object:nil];
}

//- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    if ([self.items[indexPath.row] isKindOfClass:GTTopic.class]) {
//        GTTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseTopicIdentifier forIndexPath:indexPath];
//        cell.nameLabel.text = ((GTTopic *)self.items[indexPath.row]).name;
//        return cell;
//    } else if ([self.items[indexPath.row] isKindOfClass:GTTag.class]) {
//        GTTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseTagIdentifier forIndexPath:indexPath];
//        cell.nameLabel.text = ((GTTag *)self.items[indexPath.row]).name;
//        return cell;
//    } else {
//        UITableViewCell *cell = [[UITableViewCell alloc] init];
//        return cell;
//    }
//}
//
//- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.items.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 50.f;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}
//
//- (void)redirectToNextViewController:(NSNotification *)notification {
//
//}

@end
