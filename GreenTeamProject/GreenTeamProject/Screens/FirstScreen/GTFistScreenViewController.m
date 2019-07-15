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

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(redirectToVideoScreen:) name:@"RedirectToVideoScreen" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Get items from NSUserDefaults
    // self.items =
    
    
    GTTableViewController *tableViewController = [[GTTableViewController alloc] init];
    
    [self addChildViewController:tableViewController];
    [tableViewController didMoveToParentViewController:self];
    tableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableViewController.tableView];
    tableViewController.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [tableViewController.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
                                              [tableViewController.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
                                              [tableViewController.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:10],
                                              [tableViewController.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-20]]];
    
    
    tableViewController.items = self.items;
}

- (void)redirectToVideoScreen:(NSNotification *)notification {
    
}

@end
