//
//  StartViewController.h
//  Tiles
//
//  Created by Adam Schor on 10/27/19.
//  Copyright © 2019 AandA Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainDisplayViewController.h"




NS_ASSUME_NONNULL_BEGIN

@interface StartViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (strong, nonatomic) IBOutlet UIButton *btnStart;
- (IBAction)btnStartPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnChooseImage;
- (IBAction)btnChooseImagePressed:(id)sender;

//test

@property (strong,nonatomic) NSMutableArray * arrayGameModes;

@property (strong, nonatomic) IBOutlet UIPickerView *pickerGameMode;
@property NSInteger gameMode;

@property (strong, nonatomic) UIImage* imageSelected;

@property (strong, nonatomic) UIImage *adjImage;

@end

NS_ASSUME_NONNULL_END
