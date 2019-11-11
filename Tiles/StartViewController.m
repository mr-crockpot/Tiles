//
//  StartViewController.m
//  Tiles
//
//  Created by Adam Schor on 10/27/19.
//  Copyright © 2019 AandA Development. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createModeArray];
}

-(void)createModeArray{
    
    _arrayGameModes = [[NSMutableArray alloc] initWithObjects:@"Numbers",@"Colors",@"Pictures", nil];
    
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _arrayGameModes.count;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = _arrayGameModes[row];
    return title;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _gameMode = row;
   
    
}
- (IBAction)btnStartPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"segueStartToMainDisplay" sender:self];
}
- (IBAction)btnChooseImagePressed:(id)sender {
    
     UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
     photoPicker.delegate = self;
     photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
     
     photoPicker.allowsEditing = NO;
     
     [self presentViewController:photoPicker animated:YES completion:nil];
     
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    
  _imageSelected = [info objectForKey:UIImagePickerControllerOriginalImage];
                      
    [picker dismissViewControllerAnimated:YES completion:nil];
}







-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"segueStartToMainDisplay"]) {
        MainDisplayViewController *vcMainDisplay = [segue destinationViewController];
        vcMainDisplay.gameMode = _gameMode;
        vcMainDisplay.imageSelected = _imageSelected;
        
        
    }
    
  
    
}




@end
