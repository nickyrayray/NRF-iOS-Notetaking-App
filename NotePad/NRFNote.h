//
//  NRFNote.h
//  NotePad
//
//  Created by Nicholas Falba on 5/6/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRFNote : NSObject

@property (nonatomic) NSString *content;
@property (nonatomic) NSString *title;
@property (nonatomic) NSDate *date;
@property (nonatomic) NSDateFormatter *formatter;
@property (nonatomic) UIImage *image;

-(instancetype) init;

@end
