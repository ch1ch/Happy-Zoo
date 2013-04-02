//
//  OpeningLayer.m
//  test1
//
//  Created by f on 12/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "OpeningLayer.h"
#import "FirstScene.h"
#import "LoadingScene.h"
#import "OpeningStart.h"


@implementation OpeningLayer


+(id) scene
{
	CCLOG(@"===========================================");
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	CCScene* scene = [CCScene node];
	OpeningLayer* layer = [OpeningLayer node];
	[scene addChild:layer];
	return scene;
}


-(id) init
{
	if ((self = [super init]))
	{
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        
        
        //背景，两张轮换
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"opensc1_default.plist"];
        
        CCSpriteBatchNode* Spsbackgroup = [CCSprite spriteWithSpriteFrameName:@"opsky1.png"];
        [Spsbackgroup setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
        [self addChild:Spsbackgroup z:1];
        CCAnimation *anibackgroup = [CCAnimation animation];
        for(unsigned int i = 1; i < 3; i++)
        {
            NSString *naback = [NSString stringWithFormat:@"opsky%d.png", i];
            [anibackgroup  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
        }
        [anibackgroup setDelayPerUnit:0.4f];
        id actback =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.3f], [CCAnimate  actionWithAnimation:anibackgroup], NULL]];
        [Spsbackgroup  runAction:actback];
        
        
        //公交车
        CCSpriteBatchNode* Spsbus = [CCSprite spriteWithSpriteFrameName:@"opbus1.png"];
        [Spsbus setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.57)];
        [self addChild:Spsbus z:10];
        CCAnimation *anibus = [CCAnimation animation];
        for(unsigned int i = 1; i < 9; i++)
        {
            NSString *nabus = [NSString stringWithFormat:@"opbus%d.png", i];
            [anibus  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:nabus]];
        }
        [anibus setDelayPerUnit:0.2f];
        id actbus =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.2f], [CCAnimate  actionWithAnimation:anibus], NULL]];
        [Spsbus  runAction:actbus];
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"opensc2_default.plist"];
        
        
        //动物园门
        CCSpriteBatchNode* Spsdoor = [CCSprite spriteWithSpriteFrameName:@"opdoor1.png"];
        [Spsdoor setPosition:ccp(screenSize.width*0.8 ,screenSize.height*0.3)];
        [self addChild:Spsdoor z:3];
        CCAnimation *anidoor = [CCAnimation animation];
        for(unsigned int i = 9; i < 34; i++)
        {
            NSString *nadoor = [NSString stringWithFormat:@"opdoor%d.png", i];
            [anidoor  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:nadoor]];
        }
        [anidoor setDelayPerUnit:0.15f];
   
         id acstart = [CCCallFunc actionWithTarget:self selector:@selector(gostart)];
       // id acpause = [CCCallFunc actionWithTarget:self selector:@selector(gampause)];
     
        [Spsdoor runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:anidoor],acstart,NULL]];

        
        
        
        //背景球
        backball = [CCSprite spriteWithFile:@"opball.png"];
        backball.position = CGPointMake(screenSize.width*0.5,screenSize.height*(-0.32));
        [self addChild:backball z:5];
        

    
    }
    [self schedule:@selector(update:) interval:0.2f];

    return self;
}


- (void)update:(ccTime)dt
{
    CCRotateBy* rotate = [CCRotateBy actionWithDuration:1 angle:-20];
     [backball runAction:rotate];
    
 
}

  


-(void) gostart
{
    
    [[CCDirector sharedDirector] replaceScene:[OpeningStart scene]];
    
}

-(void) gampause
{
    [[CCDirector sharedDirector] pause];
}


-(void) dealloc
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    
    // don't forget to call "super dealloc"
    
   //  [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"opensc1_default.plist"];
    
   // [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"opensc2_default.plist"];

    [super dealloc];
}


@end
