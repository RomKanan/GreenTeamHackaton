//
//  GTVideo.h
//  GreenTeamProject
//
//  Created by Roma on 7/14/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTVideo : NSObject

@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *tags;

- (instancetype)initWithURLString:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
