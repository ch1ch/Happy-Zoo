//
//  OpeningStart.m
//  test1
//
//  Created by f on 12/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "OpeningStart.h"
#import "OpeningLayer.h"
#import "FirstScene.h"
#import "LoadingScene.h"


@implementation OpeningStart



+(id) scene
{
	CCLOG(@"===========================================");
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	CCScene* scene = [CCScene node];
	OpeningStart* layer = [OpeningStart node];
	[scene addChild:layer];
	return scene;
}



-(id) init
{
	if ((self = [super init]))
	{
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
  
    
        CCSpriteBatchNode* backgroup = [CCSprite spriteWithFile:@"opentran.png"];
        [backgroup setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
        [self addChild:backgroup z:1];
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"openAnimation2.plist"];

 
        opstart = [CCSprite spriteWithSpriteFrameName:@"opstart1.png"];
        [opstart setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
        [self addChild:opstart z:10];
        CCAnimation *anistart = [CCAnimation animation];
        for(unsigned int i =1; i < 3; i++)
        {
            NSString *nastart = [NSString stringWithFormat:@"opstart%d.png", i];
            [anistart  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:nastart]];
        }
        [anistart setDelayPerUnit:0.3f];
        id actstart =[CCRepeatForever actionWithAction: [CCSequence actions: [CCAnimate  actionWithAnimation:anistart], NULL]];
        [opstart  runAction:actstart];
      
        
    }
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [self schedule:@selector(update:) interval:0.2f];
    
    return self;
}


- (void)update:(ccTime)dt {

  
    
}


- (void)selectSpriteForTouch:(CGPoint)touchLocation
{
   
     CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCSpriteBatchNode *sprite=opstart;
    int run1time=0;
    
    
      if ((CGRectContainsPoint(sprite.boundingBox, touchLocation)) &&(run1time==0))
      {
           [[SimpleAudioEngine sharedEngine]playEffect:@"start.mp3" ];
          run1time=1;
          
          CCSpriteBatchNode* backgroup = [CCSprite spriteWithFile:@"opentran.png"];
          [backgroup setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
          [self addChild:backgroup z:15];
          
          CCSpriteBatchNode* opstart1 = [CCSprite spriteWithFile:@"opstart3.png"];
          [opstart1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
          [self addChild:opstart1 z:16];
          
          
          
          [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"openmovie1.plist"];
          [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"openmovie2.plist"];
          [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"openmovie3.plist"];
          [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"openmovie4.plist"];
          CCSpriteBatchNode* Spmovie = [CCSprite node];
          [Spmovie setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
          [self addChild:Spmovie z:20];
          CCAnimation *Animovie = [CCAnimation animation];
          for(unsigned int i = 1; i < 17; i++)
          {
              NSString *namovie = [NSString stringWithFormat:@"opemovie%d.png", i];
              [Animovie addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:namovie]];
          }
          [Animovie setDelayPerUnit:0.07f];


          //id actions =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.2f], [CCAnimate  actionWithAnimation:pAnims], NULL]];
   
          id achome = [CCCallFunc actionWithTarget:self selector:@selector(gohome)];
          [Spmovie runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:Animovie],achome,NULL]];

   
      }

    
}



- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];
    return TRUE;
}


-(void) gohome{
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetSceneHome];
    [[CCDirector sharedDirector] replaceScene:newScene];
    
}


-(void) dealloc
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    
    // don't forget to call "super dealloc"
    [super dealloc];
    
   // CCLOG(@"About Scene dealloc");

    
    
#ifdef DEBUG
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [[CCTextureCache sharedTextureCache] dumpCachedTextureInfo];
#endif
    

}

@end
