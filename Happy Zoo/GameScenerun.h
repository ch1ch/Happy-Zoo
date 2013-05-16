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
#import "Player.h"
#import "SimpleAudioEngine.h"
extern int game3thing;

//typedef enum
////{
//	LayerTagGameLayer,
//	LayerTagUILayer,
//} MultiLayerSceneTags;


@interface GameScenerun : CCLayer {


    CCSprite * backgroundmenu;
    CCLabelTTF *label1;
    CCLayer *menulayer;
    CCLayer *landlayer;
    CGPoint newpigpostion;
    CGPoint oldpigpostion;
    CCSprite *game3treasures;
    
    
}


@end