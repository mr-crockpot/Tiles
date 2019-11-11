//
//  Tiles.h
//  Tiles
//
//  Created by Adam Schor on 11/22/18.
//  Copyright © 2018 AandA Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClipImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tiles : UIButton


-(Tiles *)TileButton: (UIColor *)backcolor xPosition:(float)xPosition yPosition: (float)yPosition width: (float)width height: (float) height tag: (NSInteger) tag label: (NSString *)label row:(NSInteger)row column:(NSInteger)column gameMode:(NSInteger)gameMode numberColumns: (NSInteger)numberColumns imageSelected: (UIImage *)imageSelected;

@property NSInteger column;
@property NSInteger row;
@property NSString *label;


@end

NS_ASSUME_NONNULL_END
