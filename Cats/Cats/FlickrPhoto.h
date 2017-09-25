//
//  FlickrPhoto.h
//  Cats
//
//  Created by Paul on 2017-09-25.
//  Copyright © 2017 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FlickrPhoto : NSObject

//create properties relating to the API
@property (nonatomic,strong) NSString* flickrID;
@property (nonatomic,strong) NSString* owner;
@property (nonatomic,strong) NSString* secret;
@property (nonatomic,strong) NSString* server;
@property (nonatomic,strong) NSString* title;
@property (nonatomic) NSInteger farm;

@property (nonatomic,strong) UIImage* image;



- (instancetype)initWithInfo:(NSDictionary<NSString*,id>*)info;

- (NSURL*) url;

@end
