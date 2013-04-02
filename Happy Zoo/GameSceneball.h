//
//  GameSceneball.h
//  test1
//
//  Created by f on 11/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D/Box2D.h"

#import"GLES-Render.h"

#import"MyContactListener.h"

@interface GameSceneball : CCLayer {
    CCSprite* player;
    CCSprite* ballbackgroup;
    CGPoint playerVelocity;
    CCSpriteBatchNode* spriteBatch;
    CCMenu *menu1;
    CCMenu *menu2;
    CCMenu *menu3;
    CCMenu *menu4;
    CCMenu *menu5;
    CCSprite * backgroundmenu;
    CCSprite * ballself ;
    CCSprite *shelf1;
    
    CCSprite *Animal1;
    CCSprite *Animal2;
    int gameover;


    
    CCLabelTTF *label1;
    BOOL girlvis;
    CCSpriteBatchNode* Sgirl;
    CCSpriteBatchNode* Sgrass;
    CCSpriteBatchNode* Stop;
    
    
    NSMutableArray *obstacle;
    
    b2World *_world;
    
    GLESDebugDraw *_debugDraw;
    
    MyContactListener *_contactListener;


}



@end
