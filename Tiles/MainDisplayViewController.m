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
    
    
    for (int x=1; x<columns*columns; x++) {
        
        label = [NSString stringWithFormat:@"%i",x];
        if (x<=columns) {
            xPosition = startX + (_width* (x-1));
            yPosition = startY;
            column = x;
            row = 1;
        }
        
        if (x>columns && x<=columns*2) {
            xPosition = startX +(_width * (x - columns-1));
            yPosition = startY + _width;
            column = x - columns;
            row = 2;
        }
        if (x>columns*2 && x <= columns *3) {
            xPosition = startX +(_width * (x - columns*2-1));
            yPosition = startY + 2*_width;
            column = x-2*columns;
            row = 3;
        }
        if (x>columns*3 && x <= columns *4) {
            xPosition = startX +(_width * (x - columns*3-1));
            yPosition = startY + 3* _width;
            column = x-3*columns;
            row = 4;
        }
        if (x>columns*4 && x <= columns *5) {
            xPosition = startX +(_width * (x - columns*4-1));
            yPosition = startY + 4* _width;
            column = x-4*columns;
            row = 5;
        }
        
    index = [[NSString stringWithFormat:@"%li%li",row,column] integerValue];
       
    _testTile = [[Tiles alloc] init];
        [_testTile TileButton:[UIColor orangeColor] xPosition:xPosition yPosition:yPosition width:_width height:_height tag:index label:label];
    [self.view addSubview:_testTile];
        
    [_arrButtons addObject:_testTile];
  //  [_testTile addTarget:self action:@selector(adjustButtons:) forControlEvents:UIControlEventTouchUpInside];
     [_testTile addTarget:self action:@selector(adjustButtons:) forControlEvents:UIControlEventTouchDown];
        
    }
    //[self createUpArray];
}
   
-(void)adjustButtons: (UIButton*)sender {
   
    //First find row and column of sender
    
    NSInteger tileRowK;
    NSInteger tileColumnK;
    NSInteger actionNumber = 0;
    
    tileRowK = floor(sender.tag/10);
    tileColumnK = sender.tag - tileRowK*10;

    NSLog(@"The row is %li and column in %li",tileRowK,tileColumnK);
    
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
        
        tileRow = floor(upTiles.tag/10);
        tileColumn = upTiles.tag - tileRow*10;
        NSInteger newTag;
        
        if (rowK <_freeSpaceRow && columnK == _freeSpaceColumn && rowK <= tileRow && columnK == tileColumn && tileRow < _freeSpaceRow) {
            [_arrAboveFreeButtons addObject:upTiles];
            newTag = tileRow*10+10+tileColumn;
            upTiles.tag = newTag;
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
        
        tileRow = floor(downTiles.tag/10);
        tileColumn = downTiles.tag - tileRow*10;
        NSInteger newTag;
        
        if (rowK  > _freeSpaceRow && columnK == _freeSpaceColumn && rowK >= tileRow && columnK == tileColumn && tileRow > _freeSpaceRow) {
            [_arrBelowFreeButtons addObject:downTiles];
            newTag = tileRow*10-10+tileColumn;
            downTiles.tag = newTag;
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
        
        tileRow = floor(leftTiles.tag/10);
        tileColumn = leftTiles.tag - tileRow*10;
        NSInteger newTag;
        
        if (rowK  == _freeSpaceRow && columnK > _freeSpaceColumn && rowK == tileRow && columnK >= tileColumn && tileRow == _freeSpaceRow && tileColumn>_freeSpaceColumn) {
            [_arrRightFreeButtons addObject:leftTiles];
            newTag = tileRow*10+tileColumn-1;
            leftTiles.tag = newTag;
         
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
    
    
    for (Tiles *downTiles in _arrButtons) {
        
        tileRow = floor(downTiles.tag/10);
        tileColumn = downTiles.tag - tileRow*10;
        NSInteger newTag;
        
        if (rowK  == _freeSpaceRow && columnK < _freeSpaceColumn && rowK == tileRow && columnK <= tileColumn && tileRow == _freeSpaceRow && tileColumn < _freeSpaceColumn) {
            [_arrLeftFreeButtons addObject:downTiles];
            newTag = tileRow*10+tileColumn+1;
            downTiles.tag = newTag;
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
