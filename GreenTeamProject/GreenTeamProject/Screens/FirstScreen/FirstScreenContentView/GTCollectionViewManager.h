//
//  GTCollectionViewManager.h
//  GreenTeamProject
//
//  Created by Диана Тынкован on 7/13/19.
//  Copyright © 2019 GreenTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTCollectionViewManager : NSObject <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UICollectionView *superCollectionView;
@end

NS_ASSUME_NONNULL_END
