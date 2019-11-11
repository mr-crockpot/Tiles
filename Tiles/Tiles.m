//
//  Tiles.m
//  Tiles
//
//  Created by Adam Schor on 11/22/18.
//  Copyright © 2018 AandA Development. All rights reserved.
//

#import "Tiles.h"

@implementation Tiles


-(Tiles *)TileButton: (UIColor *)backcolor xPosition:(float)xPosition yPosition: (float)yPosition width: (float)width height: (float) height tag: (NSInteger) tag label: (NSString *)label row:(NSInteger)row column:(NSInteger)column gameMode:(NSInteger)gameMode numberColumns: (NSInteger)numberColumns imageSelected: (UIImage *)imageSelected{
    
 
    float imageWidth = [imageSelected size].width;
    float imageHeight = [imageSelected size].height;
    
    
    switch (gameMode) {
        case 1:
            _label = label;
            self.backgroundColor = backcolor;
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.jpg"]];
            self.layer.cornerRadius = 15;
            self.clipsToBounds = YES;
            
           
            
            break;
        case 2:
            NSLog(@"Make colors work");
            break;
            
        case 3:
            
            //0 = Landscape Right
            //1 = Landscape Left
            //2 = Portrait Down
            //3 = Portrait Up
            switch (imageSelected.imageOrientation) {
                case 0:
                     [self setImage:[ClipImage cropImage:imageSelected
                     xPosition: (column-1)*imageWidth/numberColumns
                     yPosition: (row-1)*imageHeight/numberColumns
                     width:imageWidth/numberColumns
                     height:imageHeight/numberColumns
                     orientation:imageSelected.imageOrientation]
                     forState:UIControlStateNormal];
                    break;
                case 1:
                    [self setImage:[ClipImage cropImage:imageSelected xPosition:imageWidth-column*(imageWidth/numberColumns)  yPosition:imageHeight-row*(imageHeight/numberColumns) width:imageWidth/numberColumns height:imageHeight/numberColumns orientation:imageSelected.imageOrientation] forState:UIControlStateNormal];
                    break;
                    
                case 2:
                    [self setImage:[ClipImage cropImage:imageSelected
                        xPosition:(numberColumns-row)*imageHeight/numberColumns
                        yPosition:(column-1)*imageWidth/numberColumns
                        width:imageHeight/numberColumns
                        height:imageWidth/numberColumns
                        orientation:imageSelected.imageOrientation] forState:UIControlStateNormal];
                    break;
                    
                case 3:
                    [self setImage:[ClipImage cropImage:imageSelected xPosition:imageHeight-(numberColumns+1-row)*(imageHeight/numberColumns)  yPosition:imageWidth-column*(imageWidth/numberColumns) width:imageHeight/numberColumns height:imageWidth/numberColumns orientation:imageSelected.imageOrientation] forState:UIControlStateNormal];
                    break;
                    
                default:
                    break;
            }
            
            
            
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
