//
//  Defaults.m
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/15/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import "Defaults.h"

@implementation Defaults

+ (instancetype)shared {
    static Defaults *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [Defaults new];
    });
    return shared;
}

//- (void)saveTags: {
//    NSUserDefaults.standardUserDefaults setValue:<#(nullable id)#> forKey:<#(nonnull NSString *)#>
//}

@end
