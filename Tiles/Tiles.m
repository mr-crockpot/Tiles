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
   // self.backgroundColor = backcolor;
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
    
    self.frame = CGRectMake(xPosition, yPosition, width, height);
    self.tag = tag;
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.borderWidth = 2;
    [self setTitle:_label forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:@"Arial" size:width*.8];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   /* self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.8;
    */
   // self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.numberOfLines = 1;
    self.row = row;
    self.column = column;
    
    return  self;
}



    



@end
