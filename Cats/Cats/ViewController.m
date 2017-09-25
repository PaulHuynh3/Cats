//
//  ViewController.m
//  Cats
//
//  Created by Paul on 2017-09-25.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "ViewController.h"
#import "FlickrAPI.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic,strong) NSArray <FlickrPhoto*> *catPhotoArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // what we want to do is this
    //    self.catPhotos = [FlickrAPI searchFor:@"cats"];
    // but the search process happens in the background asynchronously so we can't
    // so one way of dealing with this is moving the return type to a block parameter
    // so we pass in a block that gets the "return value" and does what we would like
    // to do with the return value
    // (another/older way would be to make this class the delegate of the api object
    // and have a delegate method that would get the results (but that would mean
    // we couldn't just use a class method, would actually need to alloc&init a FlickrAPI object
    [FlickrAPI searchFor:@"cats" complete:^(NSArray<FlickrPhoto *> *results) {
        self.catPhotoArray = results;
        NSLog(@"photos are loaded");
        
        FlickrPhoto *catPhoto = self.catPhotoArray.firstObject;
        if(catPhoto.image){
            self.imageView.image = catPhoto.image;
        } else {
        [FlickrAPI loadImageForPhoto:catPhoto complete:^(UIImage *result) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.imageView.image = result;
            }];
            
        }];
        
        }
    }];
    NSLog(@"view did load finish loading");//happens before loaded photo results
    
}






@end
