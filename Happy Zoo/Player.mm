//
//  Player.m
//  SimpleBox2dScroller
//
//  Created by min on 3/17/11.
//  Copyright 2011 Min Kwon. All rights reserved.
//

#import "Player.h"
#import "Constants.h"
#define PTM_RATIO 32.0

@implementation Player1
@synthesize body;

- (id) init {
	if ((self = [super init])) {
		type = kGameObjectPlayer;
	}
	return self;
}

-(void) createBox2dObject:(b2World*)world {
    b2BodyDef playerBodyDef;
	playerBodyDef.type = b2_dynamicBody;
	playerBodyDef.position.Set(self.position.x/PTM_RATIO, self.position.y/PTM_RATIO);
	playerBodyDef.userData = self;
	playerBodyDef.fixedRotation = true;
	
	body = world->CreateBody(&playerBodyDef);
	
	b2CircleShape circleShape;
	circleShape.m_radius = 0.7;
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &circleShape;
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 1.0f;
	fixtureDef.restitution =  0.0f;
	body->CreateFixture(&fixtureDef);
}

-(void) moveRight {
    b2Vec2 impulse = b2Vec2(7.0f, 0.0f);
    body->ApplyLinearImpulse(impulse, body->GetWorldCenter());
}

-(void) jump {
    b2Vec2 impulse = b2Vec2(0.0f, 180.0f);
    body->ApplyLinearImpulse(impulse, body->GetWorldCenter());
    NSLog(@"jump~~~");
}
-(void) down {
    b2Vec2 impulse = b2Vec2(0.0f, -190.0f);
    body->ApplyLinearImpulse(impulse, body->GetWorldCenter());
     NSLog(@"down~~~");
}
@end
