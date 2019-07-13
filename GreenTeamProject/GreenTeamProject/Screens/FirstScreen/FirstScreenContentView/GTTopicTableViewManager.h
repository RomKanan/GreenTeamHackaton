//
//  GTTableViewManager.h
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/13/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTTopicTableViewManager : NSObject <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *items;
@end

NS_ASSUME_NONNULL_END
