//
//  GamepadCenter.h
//  Happy Zoo
//
//  Created by f on 4/19/13.
//
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "Box2D/Box2D.h"
#import"GLES-Render.h"
#import"MyContactListener.h"

extern int game4level;
extern int game4thing;

@interface GamepadCenter : CCLayer{
    CCArray *allanmial;
    CCArray *allthings;
    
    CCSprite * selSprite;
    
    int phystay;
  
    CCLabelTTF *label1;

    b2World *_world;
    b2World *world;
    
    GLESDebugDraw *_debugDraw;
    
    MyContactListener *_contactListener;
    CCSpriteBatchNode* list1;
    CCSpriteBatchNode* list2;
    CCSpriteBatchNode* list3;
    CCSpriteBatchNode* list4;
    CCSpriteBatchNode* list5;
    CCSpriteBatchNode* list6;
    CCSpriteBatchNode* list7;
    CCSpriteBatchNode* list8;
    CCSpriteBatchNode* list9;
    CCSpriteBatchNode* list10;
    CCSpriteBatchNode* list11;
    CCSpriteBatchNode* list12;
    CCSpriteBatchNode* list13;
    CCSpriteBatchNode* list14;
    CCSpriteBatchNode* list15;
    CCSpriteBatchNode* list16;
    CCSpriteBatchNode* list17;
    CCSpriteBatchNode* list18;
    CCSpriteBatchNode* list19;
    CCSpriteBatchNode* list20;
    CCSpriteBatchNode* list21;
    CCSpriteBatchNode* list22;
    int thing1key;
    CCSprite *game4treasure;
    int waittimetrea;
    CCSpriteBatchNode *game4treasures;
    //CCSpriteBatchNode *thing1;
    
    
    
}

@end
