//
//  Tiles.m
//  Tiles
//
//  Created by Adam Schor on 11/22/18.
//  Copyright © 2018 AandA Development. All rights reserved.
//

#import "Tiles.h"

@implementation Tiles



-(Tiles *)TileButton: (UIColor *)backcolor xPosition:(float)xPosition yPosition: (float)yPosition width: (float)width height: (float) height tag: (NSInteger) tag label: (NSString *)label{
    
    self.backgroundColor = backcolor;
    self.frame = CGRectMake(xPosition, yPosition, width, height);
    self.tag = tag;
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.borderWidth = 3;
    [self setTitle:label forState:UIControlStateNormal];
    
    return  self;
}


    



@end
