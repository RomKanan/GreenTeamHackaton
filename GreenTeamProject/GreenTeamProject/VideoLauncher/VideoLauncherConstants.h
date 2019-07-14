//
//  VideoLauncherConstants.h
//  GreenTeamProject
//
//  Created by Anton Sipaylo on 7/12/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

struct VideoLauncherConstants {
    const CGFloat videoPlayerVideStartWidth;
    const CGFloat videoPlayerVideStartHeight;
    const CGFloat widthProportion;
    const CGFloat heightProportion;
    const NSInteger sectionsAmount;
    NSString * const tagCellIdentifier;
    const CGFloat cellHeight;
    NSString * const sectionHeaderViewIdentifier;
    CGFloat buttonHeight;
    CGFloat buttonWidth;
    CGFloat tableViewActionButtonSpacing;
    CGFloat headerHeight;
    NSString * const addButtonImageName;
};

extern const struct VideoLauncherConstants videoLauncherConstants;
