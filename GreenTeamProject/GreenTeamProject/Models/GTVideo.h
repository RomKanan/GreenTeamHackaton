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
@property (strong,nonatomic) NSString *ID;
@property (strong,nonatomic) NSURL *youtubeUrl;
@property (strong,nonatomic) NSString *stringURL;
@property (strong,nonatomic) NSString *name;
@property (assign,nonatomic) NSTimeInterval lengh;
@property (strong,nonatomic) NSMutableArray *tags;

-(instancetype)initWithURL:(NSURL*)url;
-(instancetype)initWithLink:(NSString*)link;
@end

NS_ASSUME_NONNULL_END
