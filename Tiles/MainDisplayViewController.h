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
    <UIPickerViewDelegate, UIPickerViewDelegate>


@property (strong, nonatomic) IBOutlet UILabel *lblTimer;
@property (strong, nonatomic) IBOutlet UILabel *lblMoves;

@property (strong, nonatomic) NSTimer *timer;
@property float time;


@property (strong, nonatomic) IBOutlet UIStepper *stepperGrid;
- (IBAction)stepperGridChanged:(id)sender;

@property (strong, nonatomic) IBOutlet Tiles *testTile;
@property (strong, nonatomic) NSMutableArray *arrButtons;
@property (strong, nonatomic) NSMutableArray *arrAboveFreeButtons;
@property (strong, nonatomic) NSMutableArray *arrBelowFreeButtons;
@property (strong, nonatomic) NSMutableArray *arrRightFreeButtons;
@property (strong, nonatomic) NSMutableArray *arrLeftFreeButtons;

@property float animationSpeed;

@property NSInteger numberOfMoves;

@property float width;
@property float height;
@property float screenWidth;
@property float screenHeight;


@property NSInteger columns;


@property NSInteger freeSpaceRow;
@property NSInteger freeSpaceColumn;
- (IBAction)btnStart:(id)sender;



@end

NS_ASSUME_NONNULL_END
