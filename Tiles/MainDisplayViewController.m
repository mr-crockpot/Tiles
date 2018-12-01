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
 
    float startX = 100;
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
    
    
    for (int x=1; x<6; x++) {
        if (x<3) {
            xPosition = startX;
            yPosition = startY * x;
            column = 1;
            row = x;
        }
        
        if (x>2) {
            xPosition = startX + 100;
            yPosition = startY * (x-2);
            column = 2;
            row = x-2;
        }
        
    index = [[NSString stringWithFormat:@"%li%li",row,column] integerValue];
       
    _testTile = [[Tiles alloc] init];
    [_testTile TileButton:[UIColor orangeColor] xPosition:xPosition yPosition:yPosition width:width height:height tag:index];
    [self.view addSubview:_testTile];
        
    [_arrButtons addObject:_testTile];
    [_testTile addTarget:self action:@selector(adjustButtons:) forControlEvents:UIControlEventTouchUpInside];
        
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
    
    NSLog(@"The clicked row is %li vs free %li and clicked column in %li vs free %li",tileRowK,_freeSpaceRow,tileColumnK,_freeSpaceColumn);
    
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
    NSLog(@"Action number is %li",actionNumber);
    switch (actionNumber) {
        case 1:
            [self moveLeft:tileRowK column:tileColumnK];
            break;
        case 2:
            [self moveRight:tileRowK column:tileColumnK];
            break;
        case 3:
            [self moveUp:tileRowK column:tileColumnK];
            NSLog(@"Move Up From Here");
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
 //   NSLog(@"The column is %li and the freeSpace Column is %li",columnK,_freeSpaceColumn);
  //  NSLog(@"The row is %li and the freeSpace row is %li",rowK,_freeSpaceRow);
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
//    NSLog(@"There are %li buttons in array",_arrAboveFreeButtons.count);
    
    [UIView animateWithDuration:1 animations:^{
        for (Tiles *activeTile in self.arrAboveFreeButtons) {
            activeTile.frame = CGRectMake(activeTile.frame.origin.x, activeTile.frame.origin.y+100, 50, 50);
            
        }
    }];
    
   
    //Re-establish FreeSpace
    
    _freeSpaceRow = rowK;
    _freeSpaceColumn = columnK;
    
   NSLog(@"The free space is %li,%li",rowK,columnK);
    
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
    //    NSLog(@"There are %li buttons in array",_arrAboveFreeButtons.count);
    
    [UIView animateWithDuration:1 animations:^{
        for (Tiles *activeTile in self.arrBelowFreeButtons) {
            activeTile.frame = CGRectMake(activeTile.frame.origin.x, activeTile.frame.origin.y-100, 50, 50);
            
        }
    }];
    
    
    //Re-establish FreeSpace
    
    _freeSpaceRow = rowK;
    _freeSpaceColumn = columnK;
    
    NSLog(@"The free space is %li,%li",rowK,columnK);
    
}

-(void)moveLeft: (NSInteger)rowK column:(NSInteger)columnK {
    
    NSInteger tileRow;
    NSInteger tileColumn;
    
    _arrRightFreeButtons = [[NSMutableArray alloc] init];
    
    
    for (Tiles *downTiles in _arrButtons) {
        
        tileRow = floor(downTiles.tag/10);
        tileColumn = downTiles.tag - tileRow*10;
        NSInteger newTag;
        
        if (rowK  == _freeSpaceRow && columnK > _freeSpaceColumn && rowK == tileRow && columnK >= tileColumn && tileRow == _freeSpaceRow) {
            [_arrRightFreeButtons addObject:downTiles];
            newTag = tileRow*10+tileColumn-1;
            downTiles.tag = newTag;
        }
        
    }
    //    NSLog(@"There are %li buttons in array",_arrAboveFreeButtons.count);
    
    [UIView animateWithDuration:1 animations:^{
        for (Tiles *activeTile in self.arrRightFreeButtons) {
            activeTile.frame = CGRectMake(activeTile.frame.origin.x-100, activeTile.frame.origin.y, 50, 50);
            
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
        
        if (rowK  == _freeSpaceRow && columnK < _freeSpaceColumn && rowK == tileRow && columnK <= tileColumn && tileRow == _freeSpaceRow) {
            [_arrLeftFreeButtons addObject:downTiles];
            newTag = tileRow*10+tileColumn+1;
            downTiles.tag = newTag;
        }
        
    }
    //    NSLog(@"There are %li buttons in array",_arrAboveFreeButtons.count);
    
    [UIView animateWithDuration:1 animations:^{
        for (Tiles *activeTile in self.arrLeftFreeButtons) {
            activeTile.frame = CGRectMake(activeTile.frame.origin.x+100, activeTile.frame.origin.y, 50, 50);
            
        }
    }];
    
    
    //Re-establish FreeSpace
    
    _freeSpaceRow = rowK;
    _freeSpaceColumn = columnK;
    
    
    
}

@end
