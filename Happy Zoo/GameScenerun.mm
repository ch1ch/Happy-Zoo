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
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gameoverthings.plist"];
       
        CCLOG(@" %@ : %@",NSStringFromSelector(_cmd),self);
        CGSize screenSize=[[CCDirector sharedDirector] winSize];
        [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
        
        menulayer=[MenuLayer node];
        
        landlayer=[LandLayer node];
        [self addChild:menulayer z:30 tag:LayerTagGameLayer];
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
        
        //sun，两张轮换 pigrun-sky5.png
         [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pig_sky7.plist"];
        
        CCSpriteBatchNode* pig_sun = [CCSprite spriteWithSpriteFrameName:@"pigrun-sky3.png"];
        [pig_sun setPosition:ccp(screenSize.width*0.07 ,screenSize.height*0.88)];
        [self addChild:pig_sun z:2];
        CCAnimation *anpig_sun = [CCAnimation animation];
        for(unsigned int i = 3; i <5; i++)
        {
            NSString *naback = [NSString stringWithFormat:@"pigrun-sky%d.png", i];
            [anpig_sun  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
        }
        [anpig_sun setDelayPerUnit:0.5f];
        id actsun =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.5f], [CCAnimate  actionWithAnimation:anpig_sun], NULL]];
        [pig_sun runAction:actsun];
        
       
        CCSpriteBatchNode* pig_windy = [CCSprite spriteWithSpriteFrameName:@"pigrun-sky5.png"];
        [pig_windy setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
        [self addChild:pig_windy z:5];
        CCAnimation *anpig_windy = [CCAnimation animation];
        for(unsigned int i = 5; i <7; i++)
        {
            NSString *naback = [NSString stringWithFormat:@"pigrun-sky%d.png", i];
            [anpig_windy  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
        }
        [anpig_windy setDelayPerUnit:0.5f];
        id actwindy =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.5f], [CCAnimate  actionWithAnimation:anpig_windy], NULL]];
        [pig_windy runAction:actwindy];
        
        


        //CCSprite *pig_sun=[CCSprite spriteWithFile:@"pigrun-sun02.png"];
        //pig_sun.position=CGPointMake(screenSize.width*0.2 ,screenSize.height*0.78);
        //[self addChild:pig_sun z:3 tag:72];
        
        
        /*
        //云
        CCSpriteBatchNode  *pig_cloud=[CCSprite spriteWithFile:@"pigrun-cloud01.png"];
        pig_cloud.position=CGPointMake(screenSize.width*0.6 ,screenSize.height*0.615);
        [self addChild:pig_cloud z:3 tag:72];
        */
        [self schedule:@selector(tick:)interval:0.1f];
        [self setIsTouchEnabled:YES];
        

    }

    return self;
}

- (void)tick:(ccTime) dt {
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
    if (game3thing==1) {

        game3thing=2;
        [[SimpleAudioEngine sharedEngine]playEffect:@"foundthing.mp3"];
        game3treasures=[CCSprite spriteWithSpriteFrameName:@"Game-treasure3.png"];
        [game3treasures setPosition:ccp(screenSize.width*0.12,screenSize.height*0.14)];
        [self addChild:game3treasures z:35];
        
    }
    if (game3thing==2) {
        CGPoint temp=game3treasures.position;
        temp.x=temp.x-3;
        temp.y=temp.y-3;
        game3treasures.position=temp;
    }


    
}

-(void)dealloc
{
    CCLOG(@" %@ : %@",NSStringFromSelector(_cmd),self);

    [super dealloc];

}



@end