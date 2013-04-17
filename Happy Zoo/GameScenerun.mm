//
//  GameScenerun.m
//  Happy Zoo
//
//  Created by f on 1/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameScenerun.h"
#import "GameScenepie.h"
#import "GameOverScene.h"
#import "LoadingScene.h"
#import "FirstScene.h"
#import "GamingMain.h"
#import "MenuLayer.h"
#import "LandLayer.h"

#define PTM_RATIO 32.0

@implementation GameScenerun



static FirstScene* multiLayerSceneInstance;

+(FirstScene*) sharedLayer
{
	NSAssert(multiLayerSceneInstance != nil, @"MultiLayerScene not available!");
	return multiLayerSceneInstance;
}


-(ListLayer*) listLayer
{
	CCNode* layer = [self getChildByTag:LayerTagGameLayer];
	return (ListLayer*)layer;
}




+(id) scene
{
    CCScene *scene=[CCScene node];
    CCLayer* layer =[GameScenerun node];
    [scene addChild:layer];
    return scene;
}


-(id) init
{
    if ((self=[super init]))
    {
        CCLOG(@" %@ : %@",NSStringFromSelector(_cmd),self);
        CGSize screenSize=[[CCDirector sharedDirector] winSize];
        
        menulayer=[MenuLayer node];
        
        landlayer=[LandLayer node];
        [self addChild:menulayer z:10 tag:LayerTagGameLayer];
        [self addChild:landlayer z:10 tag:200];

        //背景，两张轮换
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pig-sky.plist"];
        CCSpriteBatchNode* Spsbackgroup = [CCSprite spriteWithSpriteFrameName:@"pigrun-sky01.png"];
        [Spsbackgroup setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
        [self addChild:Spsbackgroup z:0];
        CCAnimation *anibackgroup = [CCAnimation animation];
        for(unsigned int i = 1; i <3; i++)
        {
            NSString *naback = [NSString stringWithFormat:@"pigrun-sky0%d.png", i];
            [anibackgroup  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
        }
        [anibackgroup setDelayPerUnit:0.5f];
        id actback =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.5f], [CCAnimate  actionWithAnimation:anibackgroup], NULL]];
        [Spsbackgroup  runAction:actback];
        
        
        

        CCSprite *pig_sun=[CCSprite spriteWithFile:@"pigrun-sun02.png"];
        pig_sun.position=CGPointMake(screenSize.width*0.7 ,screenSize.height*0.715);
        [self addChild:pig_sun z:3 tag:72];
        /*
        //云
        CCSpriteBatchNode  *pig_cloud=[CCSprite spriteWithFile:@"pigrun-cloud01.png"];
        pig_cloud.position=CGPointMake(screenSize.width*0.6 ,screenSize.height*0.615);
        [self addChild:pig_cloud z:3 tag:72];
        */
        [self schedule:@selector(tick:)interval:0.1f];
        [self setIsTouchEnabled:YES];
        

    }

    //[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    return self;
}

- (void)tick:(ccTime) dt {
    


    
}

-(void)dealloc
{
    CCLOG(@" %@ : %@",NSStringFromSelector(_cmd),self);

    [super dealloc];

}



@end