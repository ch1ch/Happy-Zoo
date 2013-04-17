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


@interface LandLayer : CCLayer{
    Player1 *pig;
    CCSprite *startsign;
    CCSpriteBatchNode  *pig_sun;
    CCSprite * selSprite;
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
    CCLayer *menulayer;
    CCLayer *landlayer;
    int firsttime;
    int pigjump;
    CGPoint pos9;
    CCLabelTTF *label1;
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
