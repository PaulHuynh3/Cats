//
//  FlickrPhoto.m
//  Cats
//
//  Created by Paul on 2017-09-25.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "FlickrPhoto.h"

@implementation FlickrPhoto

-(instancetype)initWithInfo:(NSDictionary<NSString *,id> *)info{

    self = [super init];
    
    if (self) {
    _flickrID = info[@"id"];
    _owner = info[@"owner"];
    _secret = info[@"secret"];
    _server = info[@"server"];
    _title = info[@"title"];
    _farm = [info[@"farm"] integerValue];
    
    }
    return self;

}



- (NSURL *)url
{
    return [NSURL URLWithString:
            [NSString stringWithFormat:
             @"https://farm%ld.staticflickr.com/%@/%@_%@.jpg",
             self.farm, self.server, self.flickrID, self.secret]];
}



@end
