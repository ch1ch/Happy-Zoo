//
//  GameObject.m
//  SimpleBox2dScroller
//
//  Created by min on 3/17/11.
//  Copyright 2011 Min Kwon. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject
@synthesize type;

- (id)init
{
    self = [super init];
    if (self) {
        type = kGameObjectNone;
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
