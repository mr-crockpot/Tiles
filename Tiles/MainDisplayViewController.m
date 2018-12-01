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
    _animationSpeed = 0.2;
    float startX = 50;
    float startY = 100;
    float width = 50;
    float height = 50;
    float xPosition = 0.0;
    float yPosition = 0.0;
    NSInteger column = 0;
    NSInteger row = 0;
    NSInteger index;
    
    _freeSpaceRow = 3;
    _freeSpaceColumn = 1;
    
    _arrButtons = [[NSMutableArray alloc] init];
    
    
    for (int x=1; x<9; x++) {
        if (x<3) {
            xPosition = startX;
            yPosition = startY * x;
            column = 1;
            row = x;
        }
        
        if (x>2 && x<6) {
            xPosition = startX + 100;
            yPosition = startY * (x-2);
            column = 2;
            row = x-2;
        }
        if (x>5) {
            xPosition = startX + 200;
            yPosition = startY * (x-5);
            column = 3;
            row = x-5;
        }
        
    index = [[NSString stringWithFormat:@"%li%li",row,column] integerValue];
       
    _testTile = [[Tiles alloc] init];
    [_testTile TileButton:[UIColor orangeColor] xPosition:xPosition yPosition:yPosition width:width height:height tag:index];
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
            NSLog(@"Nowhere to go");
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
            activeTile.frame = CGRectMake(activeTile.frame.origin.x, activeTile.frame.origin.y+100, 50, 50);
            
        }
    }];
    
   
    //Re-establish FreeSpace
    
    _freeSpaceRow = rowK;
    _freeSpaceColumn = columnK;
    
   NSLog(@"Moved Down. The free space is %li,%li",rowK,columnK);
    
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
            activeTile.frame = CGRectMake(activeTile.frame.origin.x, activeTile.frame.origin.y-100, 50, 50);
            
        }
    }];
    
    
    //Re-establish FreeSpace
    
    _freeSpaceRow = rowK;
    _freeSpaceColumn = columnK;
    
    NSLog(@"Moved up. The free space is %li,%li",rowK,columnK);
    
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
            NSLog(@"The new tag is %li",newTag);
        }
    
    }
    
    
    [UIView animateWithDuration:_animationSpeed animations:^{
        for (Tiles *activeTile in self.arrRightFreeButtons) {
            activeTile.frame = CGRectMake(activeTile.frame.origin.x-100, activeTile.frame.origin.y, 50, 50);
            
        }
    }];
    
    
    //Re-establish FreeSpace
    
    _freeSpaceRow = rowK;
    _freeSpaceColumn = columnK;
    
    NSLog(@"Moved Left. The free space is %li,%li",_freeSpaceRow,_freeSpaceColumn);
    
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
            activeTile.frame = CGRectMake(activeTile.frame.origin.x+100, activeTile.frame.origin.y, 50, 50);
            
        }
    }];
    
    
    //Re-establish FreeSpace
    
    _freeSpaceRow = rowK;
    _freeSpaceColumn = columnK;
    NSLog(@"Moved Right. The free space is %li,%li",rowK,columnK);
    
    
}

@end
