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

@end
