//
//  MainDisplayViewController.m
//  Tiles
//
//  Created by Adam Schor on 11/22/18.
//  Copyright © 2018 AandA Development. All rights reserved.
//

#import "MainDisplayViewController.h"

@interface MainDisplayViewController ()

@end

@implementation MainDisplayViewController

- (void)viewDidLoad {
    [self createTiles];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)createTiles{
    
    _screenWidth = [UIScreen mainScreen].bounds.size.width;
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    NSInteger columns = 5;
    
    _animationSpeed = 0.1;
    
    _width = _screenWidth/(columns+1);
    _height = _width;
    
    float startX = _width/2;
    float startY = _width;
    float xPosition = 0.0;
    float yPosition = 0.0;
    NSInteger column = 0;
    NSInteger row = 0;
    NSInteger index;
    NSString *label;
    _freeSpaceRow = columns;
    _freeSpaceColumn = columns;
   
    _arrButtons = [[NSMutableArray alloc] init];
    
    
    
    for (int x=0; x<columns; x++) {
        
        for (int y = 0; y<columns; y++) {
            xPosition = startX + (_width * y);
            yPosition= startY + (x*_height);
            column = y+1;
            row = x+1;
            
            if (row != _freeSpaceRow || column !=_freeSpaceColumn){
                label = [NSString stringWithFormat:@"%li",(x*columns)+y+1];
                index = [[NSString stringWithFormat:@"%i%i", x+1,y+1]  integerValue];
                _testTile = [[Tiles alloc] init];
               
                [_testTile TileButton:[UIColor blueColor] xPosition:xPosition yPosition:yPosition width:_width height:_height tag:index label:label row:row column:column];
                [self.view addSubview:_testTile];
                [_arrButtons addObject:_testTile];
                [_testTile addTarget:self action:@selector(adjustButtons:) forControlEvents:UIControlEventTouchDown];
            }
        }
    }
    
   
}
   
-(void)adjustButtons: (UIButton*)sender {
   
    //First find row and column of sender
    
    NSInteger tileRowK;
    NSInteger tileColumnK;
    NSInteger actionNumber = 0;
    
    tileRowK = ((Tiles *)sender).row;
    tileColumnK =((Tiles *)sender).column;
    
   
    if (_freeSpaceColumn<tileColumnK && _freeSpaceRow==tileRowK) {
        actionNumber =1;
    }
    
    if (_freeSpaceColumn>tileColumnK && _freeSpaceRow == tileRowK) {
        actionNumber = 2;
    }
    
    if (_freeSpaceRow<tileRowK && _freeSpaceColumn == tileColumnK) {
        actionNumber = 3;
    }
    
    if (_freeSpaceRow>tileRowK && _freeSpaceColumn == tileColumnK) {
        actionNumber = 4;
    }
    
    if (_freeSpaceRow != tileRowK && _freeSpaceColumn != tileColumnK) {
        actionNumber = 5;
    }
    
    //create array based on actions

    switch (actionNumber) {
        case 1:
            [self moveLeft:tileRowK column:tileColumnK];
            break;
        case 2:
            [self moveRight:tileRowK column:tileColumnK];
            break;
        case 3:
            [self moveUp:tileRowK column:tileColumnK];
            break;
        case 4:
            [self moveDown:tileRowK column:tileColumnK];
            break;
        case 5:
            
            break;

            
        default:
            break;
    }
    
    
   
        
        }
    

-(void)moveDown: (NSInteger)rowK column:(NSInteger)columnK {
 
    NSInteger tileRow;
    NSInteger tileColumn;
    
    _arrAboveFreeButtons = [[NSMutableArray alloc] init];
    
    
    for (Tiles *upTiles in _arrButtons) {

        tileRow = upTiles.row;
        tileColumn = upTiles.column;
        
        if (rowK <_freeSpaceRow && columnK == _freeSpaceColumn && rowK <= tileRow && columnK == tileColumn && tileRow < _freeSpaceRow) {
            [_arrAboveFreeButtons addObject:upTiles];
            upTiles.row = upTiles.row + 1;
            //newTag = tileRow*10+10+tileColumn;
            //upTiles.tag = newTag;
        }
        
        }
 
    
    [UIView animateWithDuration:_animationSpeed animations:^{
        for (Tiles *activeTile in self.arrAboveFreeButtons) {
            activeTile.frame = CGRectMake(activeTile.frame.origin.x, activeTile.frame.origin.y+self->_height, self->_width, self->_height);
            
        }
    }];
    
   
    //Re-establish FreeSpace
    
    _freeSpaceRow = rowK;
    _freeSpaceColumn = columnK;
    
  
    
}

-(void)moveUp: (NSInteger)rowK column:(NSInteger)columnK {
    
    NSInteger tileRow;
    NSInteger tileColumn;
    
    _arrBelowFreeButtons = [[NSMutableArray alloc] init];
    
    
    for (Tiles *downTiles in _arrButtons) {
        
        tileRow = downTiles.row;
        tileColumn = downTiles.column;
        
        if (rowK  > _freeSpaceRow && columnK == _freeSpaceColumn && rowK >= tileRow && columnK == tileColumn && tileRow > _freeSpaceRow) {
            [_arrBelowFreeButtons addObject:downTiles];
            
            downTiles.row = downTiles.row -1;
           
        }
        
    }
   
    
    [UIView animateWithDuration:_animationSpeed animations:^{
        for (Tiles *activeTile in self.arrBelowFreeButtons) {
            activeTile.frame = CGRectMake(activeTile.frame.origin.x, activeTile.frame.origin.y-self->_width, self->_width, self->_height);
            
        }
    }];
    
    
    //Re-establish FreeSpace
    
    _freeSpaceRow = rowK;
    _freeSpaceColumn = columnK;
    
    
    
}

-(void)moveLeft: (NSInteger)rowK column:(NSInteger)columnK {
    
    NSInteger tileRow;
    NSInteger tileColumn;
    
    _arrRightFreeButtons = [[NSMutableArray alloc] init];
    
    
    for (Tiles *leftTiles in _arrButtons) {
        tileRow = leftTiles.row;
        tileColumn = leftTiles.column;
    
        if (rowK  == _freeSpaceRow && columnK > _freeSpaceColumn && rowK == tileRow && columnK >= tileColumn && tileRow == _freeSpaceRow && tileColumn>_freeSpaceColumn) {
            [_arrRightFreeButtons addObject:leftTiles];
            
            leftTiles.column = leftTiles.column - 1;
            
        }
    
    }
    
    
    [UIView animateWithDuration:_animationSpeed animations:^{
        for (Tiles *activeTile in self.arrRightFreeButtons) {
            activeTile.frame = CGRectMake(activeTile.frame.origin.x-self->_width, activeTile.frame.origin.y, self->_width, self->_height);
            
        }
    }];
    
    
    //Re-establish FreeSpace
    
    _freeSpaceRow = rowK;
    _freeSpaceColumn = columnK;
    
    
    
}

-(void)moveRight: (NSInteger)rowK column:(NSInteger)columnK {
    
    NSInteger tileRow;
    NSInteger tileColumn;
    
    _arrLeftFreeButtons = [[NSMutableArray alloc] init];
    
    
    for (Tiles *rightTiles in _arrButtons) {
        
        
        tileRow = rightTiles.row;
        tileColumn = rightTiles.column;
        
        
        if (rowK  == _freeSpaceRow && columnK < _freeSpaceColumn && rowK == tileRow && columnK <= tileColumn && tileRow == _freeSpaceRow && tileColumn < _freeSpaceColumn) {
            [_arrLeftFreeButtons addObject:rightTiles];
            rightTiles.column = rightTiles.column + 1;
        }
        
    }
    
    [UIView animateWithDuration:_animationSpeed animations:^{
        for (Tiles *activeTile in self.arrLeftFreeButtons) {
            activeTile.frame = CGRectMake(activeTile.frame.origin.x+self->_width, activeTile.frame.origin.y, self->_width, self->_height);
            
        }
    }];
    
    
    //Re-establish FreeSpace
    
    _freeSpaceRow = rowK;
    _freeSpaceColumn = columnK;
   
    
}

@end
