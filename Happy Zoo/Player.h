//
//  Player.h
//  SimpleBox2dScroller
//
//  Created by min on 3/17/11.
//  Copyright 2011 Min Kwon. All rights reserved.
//

#import "cocos2d.h"
#import "Box2D.h"
#import "GameObject.h"

@interface Player1 : GameObject {
    b2Body          *body;
}

-(void) createBox2dObject:(b2World*)world;
-(void) jump;
-(void) down;
-(void) moveRight;

@property (nonatomic, readwrite) b2Body *body;
@end
