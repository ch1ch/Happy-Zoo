//
//  GameScenepad.h
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
#import "SimpleAudioEngine.h"
static int padbacknumber;

@interface GameScenepad : CCLayer {


    CCSprite * backgroundmenu;
    CCLabelTTF *label1;
    CCLayer *padcenter;
    CCLayer *padmenu;

}


@end