//
//  CatPhotoCollectionViewCell.m
//  Cats
//
//  Created by Paul on 2017-09-25.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "CatPhotoCollectionViewCell.h"
#import "FlickrPhoto.h"
#import "FlickrAPI.h"

@interface CatPhotoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *catNameLabel;


@end

@implementation CatPhotoCollectionViewCell

-(void)setFlickrPhoto:(FlickrPhoto *)flickrPhoto{
    _flickrPhoto = flickrPhoto;

    //load photos
    [FlickrAPI loadImageForPhoto:flickrPhoto complete:^(UIImage *result) {
    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.imageView.image = result;
        self.catNameLabel.text = flickrPhoto.title;
        }];
    }];

    
}
    



@end
