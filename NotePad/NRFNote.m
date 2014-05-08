//
//  NRFNote.m
//  NotePad
//
//  Created by Nicholas Falba on 5/6/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFNote.h"

@implementation NRFNote

-(instancetype) init
{
    self = [super init];
    if(self){
        self.formatter = [[NSDateFormatter alloc] init];
        [self.formatter setDateStyle:NSDateFormatterMediumStyle];
        [self.formatter setTimeStyle:NSDateFormatterMediumStyle];
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)decoder
{
    if(self = [super init])
    {
        self.title = [decoder decodeObjectForKey:@"title"];
        self.content = [decoder decodeObjectForKey:@"content"];
        self.date = [decoder decodeObjectForKey:@"date"];
        self.formatter = [decoder decodeObjectForKey:@"formatter"];
        self.image = [decoder decodeObjectForKey:@"image"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.content forKey:@"content"];
    [coder encodeObject:self.date forKey:@"date"];
    [coder encodeObject:self.formatter forKey:@"formatter"];
    [coder encodeObject:self.image forKey:@"image"];
}

@end
