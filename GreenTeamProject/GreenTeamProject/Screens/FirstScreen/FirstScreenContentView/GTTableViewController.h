//
//  GTTableViewController.h
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/14/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTTopic;

NS_ASSUME_NONNULL_BEGIN

@interface GTTableViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) GTTopic *topic;
@end

NS_ASSUME_NONNULL_END
