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
    }
    return self;
}

/* NSCoding required methods */

-(id) initWithCoder:(NSCoder *)decoder
{
    if(self = [super init])
    {
        self.title = [decoder decodeObjectForKey:@"title"];
        self.content = [decoder decodeObjectForKey:@"content"];
        self.dateCreated = [decoder decodeObjectForKey:@"dateCreated"];
        self.lastModified = [decoder decodeObjectForKey:@"lastModified"];
        self.imagePath = [decoder decodeObjectForKey:@"imagePath"];
        self.imageTitle = [decoder decodeObjectForKey:@"imageTitle"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.content forKey:@"content"];
    [coder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [coder encodeObject:self.lastModified forKey:@"lastModified"];
    [coder encodeObject:self.imagePath forKey:@"imagePath"];
    [coder encodeObject:self.imageTitle forKey:@"imageTitle"];
}

/* Method required to copy note objects into arrays */

- (id) copyWithZone:(NSZone *)zone
{
    NRFNote *copy = [[NRFNote allocWithZone:zone] init];
    if(copy){
        copy.title = self.title;
        copy.content = self.content;
        copy.dateCreated = self.dateCreated;
        copy.lastModified = self.lastModified;
        copy.imagePath = self.imagePath;
        copy.imageTitle = self.imageTitle;
    }
    return copy;
}

@end
