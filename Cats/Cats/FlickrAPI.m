//
//  FlickrAPI.m
//  Cats
//
//  Created by Paul on 2017-09-25.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "FlickrAPI.h"
#import "Secret.h"

@implementation FlickrAPI

+(void)searchFor:(NSString *)query complete:(void (^)(NSArray<FlickrPhoto *> *))complete{

    NSURL *queryURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=%@&tags=%@",FLICKR_API_KEY,query]];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:queryURL completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        //happening inside this block of code.
        // this is where we get the results
        if (error != nil) {
            NSLog(@"error in url session: %@", error.localizedDescription);
            abort(); // TODO: display an alert or something
        }
        // TODO: check the response code we got; if it's >= 300 something is wrong
        // remember to check status code, we need to cast response to a NSHTTPURLResponse
        if (((NSHTTPURLResponse*)response).statusCode >= 300) {
            NSLog(@"Unexpected http response: %@", response);
            abort(); // TODO: display an alert or something
        }
        
        NSError *err = nil;
        NSDictionary* result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        if (err != nil) {
            NSLog(@"Something went wrong parsing JSON: %@", err.localizedDescription);
            abort();
        }
        //short way of doing [[NSMutableArray alloc]init];
        NSMutableArray<FlickrPhoto*> *catPhotos = [@[] mutableCopy];
        
        //creates an empty array where i am saving the json's array..
        for (NSDictionary *photoInfo in result[@"photos"][@"photo"]) {
            //use the instance method of flickrPhoto to save the item into the method.
            [catPhotos addObject:[[FlickrPhoto alloc]initWithInfo:photoInfo]];
        }
        //save the mutable array catphotos to the block.
        complete(catPhotos);
        
    }];

    [task resume];
    
}

//the input is the complete block and photo object
+(void)loadImageForPhoto:(FlickrPhoto *)photo complete:(void (^)(UIImage *))complete{

    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[photo url] completionHandler:^(NSData * data, NSURLResponse *  response, NSError * error) {
        
        // this is where we get the results
        if (error != nil) {
            NSLog(@"error in url session: %@", error.localizedDescription);
            abort(); // TODO: display an alert or something
        }
        // TODO: check the response code we got; if it's >= 300 something is wrong
        // remember to check status code, we need to cast response to a NSHTTPURLResponse
        if (((NSHTTPURLResponse*)response).statusCode >= 300) {
            NSLog(@"Unexpected http response: %@", response);
            abort(); // TODO: display an alert or something
        }
        
        UIImage *image = [UIImage imageWithData:data];
        
        //complete is the block input we are putting the return image in it.
        complete(image);
    }];
    [task resume];

}


@end
