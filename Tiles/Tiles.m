//
//  Tiles.m
//  Tiles
//
//  Created by Adam Schor on 11/22/18.
//  Copyright © 2018 AandA Development. All rights reserved.
//

#import "Tiles.h"

@implementation Tiles


-(Tiles *)TileButton: (UIColor *)backcolor xPosition:(float)xPosition yPosition: (float)yPosition width: (float)width height: (float) height tag: (NSInteger) tag label: (NSString *)label row:(NSInteger)row column:(NSInteger)column{
    
    _label = label;
   //self.backgroundColor = backcolor;
   // self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
  //  self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"faces.jpg"]];
  //  [self setImage:[UIImage imageNamed: @"faces.jpg"] forState:UIControlStateNormal];
    self.clipsToBounds = YES;
  /*  self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    self.imageView.contentMode = UIViewContentModeScaleApectFit;
*/

    [self setImage:[clipImage cropImage:[UIImage imageNamed:@"faces.jpg"] xPosition:1000 yPosition:1000 width:500 height:500] forState:UIControlStateNormal];
    
    self.frame = CGRectMake(xPosition, yPosition, width, height);
    self.tag = tag;
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.borderWidth = 2;
    [self setTitle:_label forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:@"Arial" size:width*.8];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
 //   self.layer.cornerRadius = 15;
   
    
   // self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.numberOfLines = 1;
    self.row = row;
    self.column = column;
    
    return  self;
}



    



@end
