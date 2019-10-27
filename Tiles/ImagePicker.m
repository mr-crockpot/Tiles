//
//  ImagePicker.m
//  Tiles
//
//  Created by Adam Schor on 10/26/19.
//  Copyright © 2019 AandA Development. All rights reserved.
//

#import "ImagePicker.h"

@implementation ImagePicker

-(UIImage*)selectedImage{
    

    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    //photoPicker.delegate =self;
    
    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImage *selectedImage = [[UIImage alloc] init];
    
    return selectedImage;
}

@end
