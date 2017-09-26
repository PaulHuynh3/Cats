//
//  ViewController.m
//  Cats
//
//  Created by Paul on 2017-09-25.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "ViewController.h"
#import "FlickrAPI.h"
#import "CatPhotoCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

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
    [FlickrAPI searchFor:@"cats" complete:^(NSArray<FlickrPhoto *> *results) {
        self.catPhotoArray = results;
        
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.collectionView reloadData];
    }];
        NSLog(@"loaded photo results");
        
    }];
    
    NSLog(@"view did load finish loading");//happens before loaded photo results
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.catPhotoArray.count;

}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CatPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    //we set our array equal to the array of the json even tho it was wrapped around a dictionary
    [cell setFlickrPhoto:self.catPhotoArray[indexPath.item]];
    

    return cell;
}





@end
