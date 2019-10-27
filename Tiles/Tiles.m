//
//  Tiles.m
//  Tiles
//
//  Created by Adam Schor on 11/22/18.
//  Copyright © 2018 AandA Development. All rights reserved.
//

#import "Tiles.h"

@implementation Tiles


-(Tiles *)TileButton: (UIColor *)backcolor xPosition:(float)xPosition yPosition: (float)yPosition width: (float)width height: (float) height tag: (NSInteger) tag label: (NSString *)label row:(NSInteger)row column:(NSInteger)column gameMode:(NSInteger)gameMode numberColumns: (NSInteger)numberColumns imageName: (NSString *)imageName{
    NSLog(@"The image name is %@",imageName);
    
    UIImage* imageToUse = [UIImage imageNamed:imageName];
    float imageWidth = [imageToUse size].width;
    float imageHeight = [imageToUse size].height;
    
    
    
    switch (gameMode) {
        case 1:
            _label = label;
            self.backgroundColor = backcolor;
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
            self.layer.cornerRadius = 15;
         //   self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"faces.jpg"]];
          //  [self setImage:[UIImage imageNamed: @"faces.jpg"] forState:UIControlStateNormal];
            self.clipsToBounds = YES;
            /*  self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
             self.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
             self.imageView.contentMode = UIViewContentModeScaleApectFit;
             */
            break;
        case 2:
            
            break;
           
        case 3:
            [self setImage:[ClipImage cropImage:[UIImage imageNamed:imageName] xPosition:imageWidth-column*(imageWidth/numberColumns)  yPosition:imageHeight-row*(imageHeight/numberColumns) width:imageWidth/numberColumns height:imageHeight/numberColumns imageName:imageName] forState:UIControlStateNormal];
        default:
            break;
    }
    

    self.frame = CGRectMake(xPosition, yPosition, width, height);
    self.tag = tag;
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.borderWidth = 2;
    [self setTitle:_label forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:@"Arial" size:width*.8];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
   
    
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.numberOfLines = 1;
    self.row = row;
    self.column = column;
    
    return  self;
}



    



@end
