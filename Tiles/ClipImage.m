//
//  clipImage.m
//  Tiles
//
//  Created by Adam Schor on 12/24/18.
//  Copyright © 2018 AandA Development. All rights reserved.
//

#import "ClipImage.h"

@implementation ClipImage

+(UIImage *)cropImage: (UIImage *)imageSelected xPosition: (float)xPos yPosition:(float)yPos width: (float)width height: (float)height orientation:(NSInteger)orientation{
    
   
    // +-------------+
    // |             |
    // |             |
    // |             |
    // |             |
    // |        (0,0)|
    // +-------------+
    
   
    CGRect cropRect = CGRectMake(xPos, yPos, width, height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageSelected CGImage], cropRect);
    UIImage *cropped = [[UIImage alloc] init];
   
    switch (orientation) {
        case 0:
            cropped = [UIImage imageWithCGImage:imageRef scale:1 orientation:UIImageOrientationUp];
            break;
            
        case 1:
            cropped = [UIImage imageWithCGImage:imageRef scale:1 orientation:UIImageOrientationDown];
            break;
        case 2:
            cropped = [UIImage imageWithCGImage:imageRef scale:1 orientation:UIImageOrientationLeft];
            
                       break;
        case 3:
            cropped = [UIImage imageWithCGImage:imageRef scale:1 orientation:UIImageOrientationRight];
            break;
            
        default:
            break;
    }
    
    return cropped;
}
@end
