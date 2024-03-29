//
//  clipImage.h
//  Tiles
//
//  Created by Adam Schor on 12/24/18.
//  Copyright © 2018 AandA Development. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClipImage : UIImage

+(UIImage *)cropImage: (UIImage *)imageSelected xPosition: (float)xPos yPosition:(float)yPos width: (float)width height: (float)height orientation:(NSInteger)orientation;

@end

NS_ASSUME_NONNULL_END
