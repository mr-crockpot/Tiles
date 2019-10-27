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
-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad {
    
    
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
   
    photoPicker.allowsEditing = NO;
    
    [self presentViewController:photoPicker animated:YES completion:nil];
    
    [self setGameMode];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"darkWood.jpg"]];
   
   
   
    

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setGameMode {
    NSInteger gameMode = 2;
    _stepperGrid.value = 4;
    _stepperGrid.maximumValue = 10;
    _stepperGrid.minimumValue = 2;
    _numberOfMoves = 0;
    [self createTilesByMode:gameMode columns:4];
    
    
}

-(void)createTilesByMode: (NSInteger) gameMode columns: (NSInteger) columns{
    gameMode = 3;
    _screenWidth = [UIScreen mainScreen].bounds.size.width;
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
    
     _columns = columns;
    
    _animationSpeed = 2;
    
    _width = _screenWidth/(_columns+1);
    _height = _width;
    
    float startX = _width/2;
    float startY = _width+100;
    float xPosition = 0.0;
    float yPosition = 0.0;
    NSInteger column = 0;
    NSInteger row = 0;
    NSInteger index;
    NSString *label;
    _freeSpaceRow = _columns;
    _freeSpaceColumn = _columns;
   
    _arrButtons = [[NSMutableArray alloc] init];
    
    UIColor *tileBackground;
    
    
    for (int x=0; x<_columns; x++) {
        
        for (int y = 0; y<_columns; y++) {
            xPosition = startX + (_width * y);
            yPosition= startY + (x*_height);
            column = y+1;
            row = x+1;
            
            if (row != _freeSpaceRow || column !=_freeSpaceColumn){
                label = [NSString stringWithFormat:@"%li",(x*_columns)+y+1];
                index = [[NSString stringWithFormat:@"%i%i", x+1,y+1]  integerValue];
                _tile = [[Tiles alloc] init];
               
               //NSLog(@"The game mode is %li",gameMode);
                switch (gameMode) {
                    case 1:
                        tileBackground = [UIColor blueColor];
                         [_tile TileButton:tileBackground xPosition:xPosition yPosition:yPosition width:_width height:_height tag:index label:label row:row column:column gameMode:gameMode numberColumns:columns imageName:_imageName];
                        break;
                    case 2://Colors
                       
                        if (index %2 ) {
                            tileBackground = [UIColor greenColor];
                        }
                        else {
                           tileBackground = [UIColor redColor];
                        }
                       
                        
                        break;
                    case 3://Photos
                         _imageName = @"faces.jpg";
                        NSLog(@"The mainDisplay image name is %@",_imageName);
                        [_tile TileButton:tileBackground xPosition:xPosition yPosition:yPosition width:_width height:_height tag:index label:@"" row:row column:column gameMode:gameMode numberColumns:columns imageName:_imageName];
                        break;
                    default:
                        break;
                }
               
              
                [self.view addSubview:_tile];
               [_arrButtons addObject:_tile];
                [_tile addTarget:self action:@selector(adjustButtons:) forControlEvents:UIControlEventTouchDown];
            }
        }
    }
    
    [self createShadow];
   
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
    [self createShadow];
    if ([self Check]) {
        [_timer invalidate];
        
    }
    _numberOfMoves = _numberOfMoves + 1;
    _lblMoves.text = [NSString stringWithFormat:@"%li moves",_numberOfMoves];
}
    
-(void)createShadow {
    
    for (Tiles *eachTile in _arrButtons) {
        if (eachTile.column == _columns) {
            eachTile.layer.shadowOffset = CGSizeMake(2.0, 0.0);
            eachTile.layer.shadowColor = [[UIColor blackColor] CGColor];
            eachTile.layer.shadowRadius = 2.0;
            eachTile.layer.shadowOpacity = 0.8;}
        else {
            eachTile.layer.shadowRadius = 0.0;
            eachTile.layer.shadowOpacity = 0.0;
            eachTile.layer.shadowColor = nil;
        }
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

- (IBAction)start:(id)sender {
    [self makeRandomMove];
}


-(void)makeRandomMove {
    _animationSpeed = 1.5;
    
    NSInteger random;
    NSMutableArray *arrFreeColumnTiles =[[NSMutableArray alloc] init];
    NSMutableArray *arrFreeRowTiles = [[NSMutableArray alloc] init];
    BOOL UseColumn = YES;
    
    for (int x = 1; x<100; x++) {
        
    
        [arrFreeRowTiles removeAllObjects];
        [arrFreeColumnTiles removeAllObjects];
        
        for (Tiles *freeTiles in _arrButtons){
            
            if (freeTiles.row == _freeSpaceRow) {
                [arrFreeRowTiles addObject:freeTiles];
                
            }
            if (freeTiles.column == _freeSpaceColumn) {
                [arrFreeColumnTiles addObject:freeTiles];
                
            }
        }
        
       
    
    random = arc4random_uniform(arrFreeColumnTiles.count);
       
        if (UseColumn) {
          [self adjustButtons:[arrFreeColumnTiles objectAtIndex:random]];
            
        }
        if (!UseColumn) {
          [self adjustButtons:[arrFreeRowTiles objectAtIndex:random]];
        }
        
        
        UseColumn = !UseColumn;
        
        
    }
    _animationSpeed = 0.01;
    _time = 0;
    _numberOfMoves = 0;
    
    [self runTimer];
    
}

- (IBAction)btnStart:(id)sender {
}


-(BOOL)Check {
    
    NSInteger total;
    BOOL inPlace = YES;
    
    for (Tiles *checkTiles in _arrButtons) {
        total = (checkTiles.row-1) * _columns + (checkTiles.column);
        if ([checkTiles.label integerValue] != total) {
            inPlace = NO;
        }
    }
    return inPlace;
   
}


- (IBAction)stepperGridChanged:(UIStepper*)sender {
   _columns = _stepperGrid.value;
    for (Tiles *existingTiles in _arrButtons) {
        [existingTiles removeFromSuperview];
    }
    [self createTilesByMode:1 columns:_columns];

}
-(void)runTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timerFunction) userInfo:nil repeats:YES];
    
}

- (void)timerFunction {
    _time = _time + 0.1;
   // _lblTimer.text = [NSString stringWithFormat:@"%.0f",_time];
    
     NSDateComponentsFormatter *componentFormatter = [[NSDateComponentsFormatter alloc] init];
     componentFormatter.unitsStyle = NSDateComponentsFormatterUnitsStylePositional;
     componentFormatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDefault;
     
     NSTimeInterval interval = _time;
     NSString *formattedString = [componentFormatter stringFromTimeInterval:interval];
     
     _lblTimer.text = formattedString;
    float fontSize = _lblTimer.bounds.size.height * .8;
    _lblTimer.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    
    
    
    
}
@end
