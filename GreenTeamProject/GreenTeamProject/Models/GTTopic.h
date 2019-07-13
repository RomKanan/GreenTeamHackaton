//
//  Topic.h
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTTag.h"

NS_ASSUME_NONNULL_BEGIN

@interface GTTopic : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray<GTTag *> *tags;
@property (nonatomic, strong) NSMutableArray<GTTopic *> *topics;
- (instancetype)initWithTags:(NSMutableArray *)tags topics:(NSMutableArray *)topics
                     andName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
