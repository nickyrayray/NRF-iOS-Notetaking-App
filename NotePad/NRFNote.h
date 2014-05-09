//
//  NRFNote.h
//  NotePad
//
//  Created by Nicholas Falba on 5/6/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRFNote : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *dateCreated;
@property (nonatomic, strong) NSString *lastModified;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *imageTitle;

-(instancetype) init;

@end
