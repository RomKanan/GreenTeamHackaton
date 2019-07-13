//
//  Tag.h
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTTag : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, assign) float time;

- (instancetype)initWithURLString:(NSString *)urlString color:(UIColor *)color name:(NSString *)name time:(float)time;

@end

NS_ASSUME_NONNULL_END
