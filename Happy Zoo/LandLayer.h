//
//  LandLayer.h
//  Happy Zoo
//
//  Created by f on 4/11/13.
//
//

#import "cocos2d.h"
#import "Box2D/Box2D.h"
#import"GLES-Render.h"
#import"MyContactListener.h"
#import "CCLayer.h"
#import "Player.h"
#import "SimpleAudioEngine.h"

extern int game3level;
extern int game3thing;

@interface LandLayer : CCLayer{
    Player1 *pig;
    CCSprite *startsign;
    CCSpriteBatchNode  *pig_sun;
    CCSprite * selSprite;
    CCSprite *pig_pig;
    
    CCSprite  *land1;
    CCSprite  *land2;
    CCSpriteBatchNode  *land3;
    CCSpriteBatchNode  *land3_2;
    CCSpriteBatchNode  *land4;
    CCSpriteBatchNode  *land5;
    CCSpriteBatchNode  *land6;
    CCSpriteBatchNode  *land6_2;
    CCSpriteBatchNode  *land6_3;
    CCSpriteBatchNode  *land7;
    CCSpriteBatchNode  *land8_1;
    CCSpriteBatchNode  *land8_2;
    CCSprite  *land9;
    CCSpriteBatchNode  *land10;
    CCSpriteBatchNode  *land11;
    CCSpriteBatchNode  *land12;
    CCSpriteBatchNode  *land13;
    CCSpriteBatchNode  *land14;
    CCSprite *monster1;
    CCSprite *monster2;
    CCSprite *monster3;
    CCSprite *monster4;
        CCSprite *monster7_1;
    CCSprite *monster5;
    CCSprite *monster6;
    CCLayer *menulayer;
    CCLayer *landlayer;
    
    CCMenu *menu7;
    CCMenu *menu2;
    CCMenu *menu5;
    
    int firsttime;
    int gametime;
    CCSprite *game3treasure;
    CCSpriteBatchNode *game3treasures;
    CGPoint pos9;
    CCLabelTTF *label1;
    int pigjumping;
    //CGSize screenSize;
    
    CGPoint newpigpostion;
    CGPoint oldpigpostion;
    
    NSMutableArray *allland;
    
    
    b2World *_world;
    b2World *world;
    
    GLESDebugDraw *_debugDraw;
    
    MyContactListener *_contactListener;
}

@end
