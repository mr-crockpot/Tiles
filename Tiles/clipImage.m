//
//  clipImage.m
//  Tiles
//
//  Created by Adam Schor on 12/24/18.
//  Copyright © 2018 AandA Development. All rights reserved.
//

#import "clipImage.h"

@implementation clipImage

+(UIImage *)cropImage: (UIImage *)imageToUse xPosition: (float)xPos yPosition:(float)yPos width: (float)width height: (float)height{
    
    imageToUse = [UIImage imageNamed:@"faces.jpg"];
    
    // +-------------+
    // |             |
    // |             |
    // |             |
    // |             |
    // |        (0,0)|
    // +-------------+
    
    
    
    CGRect cropRect = CGRectMake(xPos, yPos, width, height);
    NSLog(@"%f x %f",  [imageToUse size].width, [imageToUse size].height);
    NSLog(@"The x,y,height and width are %f,%f,%f,%f",xPos,yPos,width,height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToUse CGImage], cropRect);
    //UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    UIImage *cropped = [UIImage imageWithCGImage:imageRef scale:1 orientation:UIImageOrientationDown];
    return cropped;
}
@end
