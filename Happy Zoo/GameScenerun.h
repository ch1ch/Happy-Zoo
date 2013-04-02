//
//  GameScenerun.h
//  Happy Zoo
//
//  Created by f on 1/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D/Box2D.h"

#import"GLES-Render.h"

#import"MyContactListener.h"


//typedef enum
////{
//	LayerTagGameLayer,
//	LayerTagUILayer,
//} MultiLayerSceneTags;


@interface GameScenerun : CCLayer {

    CCMenu *menu1;
    CCMenu *menu2;
    CCMenu *menu3;
    CCMenu *menu4;
    CCMenu *menu5;
    CCSprite * backgroundmenu;
    CCLabelTTF *label1;
    CCSprite *pig;
    CCSprite *startsign;
    CCSpriteBatchNode  *pig_sun;
    CCSprite * selSprite;
    CCSpriteBatchNode  *land1;
    CCSpriteBatchNode  *land2;
    CCSpriteBatchNode  *land3;
    CCSpriteBatchNode  *land4;
    CCSpriteBatchNode  *land5;
    CCSpriteBatchNode  *land6;
    NSMutableArray *allland;
    int pigjumped;
    int pigstarthigh;

    int land2ok;
    int land3ok;
    int land4ok;
    
    b2World *_world;
    
    GLESDebugDraw *_debugDraw;
    
    MyContactListener *_contactListener;

    
    
}

-(void) back;
-(void) gamingmenu;
-(void) gomenu1;
-(void) gomenu2;

@end