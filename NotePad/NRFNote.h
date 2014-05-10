//
//  NRFNote.h
//  NotePad
//
//  Created by Nicholas Falba on 5/6/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

/* Header File for Note object */

#import <Foundation/Foundation.h>

@interface NRFNote : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *dateCreated; //Formatted string for date/time note was created
@property (nonatomic, strong) NSString *lastModified; //Same as above except the last time it was modified
@property (nonatomic, strong) NSString *imagePath; //Shows where the image is located in the filesystem so that it can be recreated
@property (nonatomic, strong) NSString *imageTitle;

-(instancetype) init;

@end
