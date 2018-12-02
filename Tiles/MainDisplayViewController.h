//
//  MainDisplayViewController.h
//  Tiles
//
//  Created by Adam Schor on 11/22/18.
//  Copyright © 2018 AandA Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tiles.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainDisplayViewController : UIViewController

@property (strong, nonatomic) IBOutlet Tiles *testTile;
@property (strong, nonatomic) NSMutableArray *arrButtons;
@property (strong, nonatomic) NSMutableArray *arrAboveFreeButtons;
@property (strong, nonatomic) NSMutableArray *arrBelowFreeButtons;
@property (strong, nonatomic) NSMutableArray *arrRightFreeButtons;
@property (strong, nonatomic) NSMutableArray *arrLeftFreeButtons;

@property float animationSpeed;


@property float width;
@property float height;
@property float screenWidth;
@property float screenHeight;


@property NSInteger columns;


@property NSInteger freeSpaceRow;
@property NSInteger freeSpaceColumn;

@end

NS_ASSUME_NONNULL_END
