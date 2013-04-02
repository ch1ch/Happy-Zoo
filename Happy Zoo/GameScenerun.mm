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
	//NSAssert([layer isKindOfClass:[FirstsceList class]], @"%@: not a GameLayer!", NSStringFromSelector(_cmd));
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
        
        
        CCMenuItemImage *menum11 = [CCMenuItemImage itemFromNormalImage:@"gaming-pause.png" selectedImage:@"gaming-pause.png" disabledImage:@"gaming-pause.png" target:self selector:@selector(gamingmenu)];
        CCMenu *menu11 = [CCMenu menuWithItems: menum11, nil];
        menu11.position = CGPointMake(screenSize.width*0.9, screenSize.height*0.9);
        [self addChild: menu11 z:30];
        
        allland = [[NSMutableArray alloc] init];

        
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
        
        
        //太阳
        pig_sun=[CCSprite spriteWithFile:@"pigrun-sun02.png"];
        pig_sun.position=CGPointMake(screenSize.width*0.7 ,screenSize.height*0.715);
        [self addChild:pig_sun z:3 tag:72];
        
        //云
        CCSpriteBatchNode  *pig_cloud=[CCSprite spriteWithFile:@"pigrun-cloud01.png"];
        pig_cloud.position=CGPointMake(screenSize.width*0.6 ,screenSize.height*0.615);
        [self addChild:pig_cloud z:3 tag:72];
        
        b2Vec2 gravity = b2Vec2(0.0f, 0.0f);
        _world =new b2World(gravity);
        

        
        
        
        
        
        land1=[CCSprite spriteWithFile:@"pigrun-land01.png"];
        land1.position=CGPointMake(screenSize.width*0.78 ,screenSize.height*(-0.05));
        [self addChild:land1 z:5 tag:72];
        [allland addObject:land1];
        
        
        pig=[CCSprite spriteWithFile:@"pigrun-pig.png"];
        pig.position=CGPointMake(screenSize.width*0.35 ,screenSize.height*0.55);
        [self addChild:pig z:20 tag:51];
    
        
        startsign=[CCSprite spriteWithFile:@"pigrun-sign.png"];
        startsign.position=CGPointMake(screenSize.width*0.3 ,screenSize.height*0.58);
        [self addChild:startsign z:8 tag:72];
        [allland addObject:startsign];
        
        
        
        
        land2=[CCSprite spriteWithFile:@"pigrun-land02.png"];
        land2.position=CGPointMake([land1 texture].contentSize.width+screenSize.width*0.6,[land1 texture].contentSize.height*(-0.5)+screenSize.height*(0.22));
        [self addChild:land2 z:6 tag:72];
        [allland addObject:land2];
        
        land3=[CCSprite spriteWithFile:@"pigrun-land03.png"];
        land3.position=CGPointMake([land1 texture].contentSize.width+screenSize.width*1.7,[land1 texture].contentSize.height*(-0.5)+screenSize.height*(0.25));
        [self addChild:land3 z:6 tag:72];
        [allland addObject:land3];
        
        land4=[CCSprite spriteWithFile:@"pigrun-land04.png"];
        land4.position=CGPointMake([land1 texture].contentSize.width+screenSize.width*2.7,[land1 texture].contentSize.height*(-0.5)+screenSize.height*(0.18));
        [self addChild:land4 z:6 tag:72];
        [allland addObject:land4];
        
        land5=[CCSprite spriteWithFile:@"pigrun-land051.png"];
        land5.position=CGPointMake([land1 texture].contentSize.width+screenSize.width*3.4,[land1 texture].contentSize.height*(-0.5)+screenSize.height*(0.21));
        [self addChild:land5 z:6 tag:72];
        [allland addObject:land5];
        
        land6=[CCSprite spriteWithFile:@"pigrun-land061.png"];
        land6.position=CGPointMake([land1 texture].contentSize.width+screenSize.width*4.1,[land1 texture].contentSize.height*(-0.5)+screenSize.height*(0.23));
        [self addChild:land6 z:6 tag:72];
        [allland addObject:land6];
     
    }
     [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [self schedule:@selector(update:) interval:0.1f];
    
    
    return self;
}


- (void)update:(ccTime)dt
{
    CGSize screenSize=[[CCDirector sharedDirector] winSize];
    // //CCLOG(@" %f : %f",land1.position.x,land3.position.y);
    if(land1.position.y<(screenSize.height*(-0.3)+[land1 texture].contentSize.height)/2)
    {
    //CGPoint pos1=land1.position;
    //pos1.x-=10;
    //pos1.y+=10;
    //land1.position=pos1;
        
        //这三部分，调整开始下坡时猪的角度
        if (startsign.position.x<screenSize.width*0.3&&startsign.position.x>screenSize.width*0.01){
            id pigac1=[CCRotateTo actionWithDuration:0.5 angle:50];
            id pigac1move=[CCMoveTo actionWithDuration:0.3 position:ccp(pig.position.x-15,pig.position.y)];
            [pig runAction:[CCSequence actions:pigac1,pigac1move,nil]];
            }
        
        if (startsign.position.x<screenSize.width*0.01&&startsign.position.x>screenSize.width*(-0.2)){
            id pigac1=[CCRotateTo actionWithDuration:0.5 angle:60];
            id pigac1move=[CCMoveTo actionWithDuration:0.2 position:ccp(pig.position.x-50,pig.position.y)];
            [pig runAction:[CCSequence actions:pigac1,pigac1move,nil]];
        }
        
        if (startsign.position.x<screenSize.width*(-0.2)){
            id pigac1=[CCRotateTo actionWithDuration:0.5 angle:0];
            [pig runAction:pigac1];
            
            }
        
        if (startsign.position.x<screenSize.width*(-0.2)&&!(pigstarthigh==1)){
            pigstarthigh=1;
            CGPoint belowScreenPosition = CGPointMake(pig.position.x,screenSize.height*0.32);
            CCMoveTo* move = [CCMoveTo actionWithDuration:2.0f position:belowScreenPosition];
            CCSequence* sequence = [CCSequence actions:move,nil];
            [pig runAction:sequence];
            
        }


        if (((land1.position.y<(screenSize.height*(-0.3)+[land1 texture].contentSize.height)/2+20)&&(land1.position.y>(screenSize.height*(-0.3)+[land1 texture].contentSize.height)/2-10))){
          
            CGPoint belowScreenPosition = CGPointMake(pig.position.x,screenSize.height*0.33);
            CCMoveTo* move = [CCMoveTo actionWithDuration:0.1f position:belowScreenPosition];
            CCSequence* sequence = [CCSequence actions:move,nil];
            //[pig runAction:sequence];
            
        }
        

        //更新所有元素位置
        for (int num=0; num<7; num++) {
            CCSprite *sprite=[allland objectAtIndex:num];
            //if (sprite.position.y+[sprite texture].contentSize.height>-50) {
          //  [self runobsMoveSequencex:sprite];
            [self runobsMoveSequencey:sprite];

            // }
            
        }
    }
    else{
        //所有横向位置更新
        if (land6.position.x>screenSize.width/3)
        {
            for (int num=0; num<7; num++)
            {
                CCSprite *sprite=[allland objectAtIndex:num];
                //if (sprite.position.y+[sprite texture].contentSize.height>-50) {
                [self runobsMoveSequencex:sprite];
            }

 
            
        }else{
            /*CCSpriteBatchNode  *pig_val=[CCSprite spriteWithFile:@"pig-valentine1.png"];
            pig_val.position=CGPointMake(screenSize.width*0.5 ,screenSize.height*0.5);
            [self addChild:pig_val z:50 tag:72];
            */
            label1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Game win "] fontName:@"Marker Felt" fontSize:81];
            label1.position =  ccp(screenSize.width /2 ,screenSize.height/2 );
            [self addChild: label1];
            [[CCDirector sharedDirector] pause];

        }
        
        
        if(pigjumped==0){
        
        if ((land5.position.x-[land5 texture].contentSize.width/2-pig.position.x<0)&&(land5.position.x-[land5 texture].contentSize.width/2-pig.position.x>[land5 texture].contentSize.width/2*(-1))){
            id pigac1=[CCRotateTo actionWithDuration:0.5 angle:20];
            id pigac1move=[CCMoveTo actionWithDuration:0.5 position:ccp(pig.position.x,pig.position.y-20)];
            [pig runAction:[CCSequence actions:pigac1,pigac1move,nil]];
        }
        
        if ((land5.position.x-[land5 texture].contentSize.width/2-pig.position.x<[land5 texture].contentSize.width/2*(-1))&&(land5.position.x-[land5 texture].contentSize.width/2-pig.position.x>[land5 texture].contentSize.width*(-1))){
            id pigac1=[CCRotateTo actionWithDuration:0.5 angle:0];
            id pigac1move=[CCMoveTo actionWithDuration:0.5 position:ccp(pig.position.x,pig.position.y+20)];
            [pig runAction:[CCSequence actions:pigac1,pigac1move,nil]];
        }
        }
        
    [self Gameovertest];
        
    }
  
    

}

-(void)Gameovertest
{
    
    //判定第一个坑，第二板块前
    if((land2.position.x-[land2 texture].contentSize.width/2-pig.position.x)<400&&(land2.position.x-[land2 texture].contentSize.width/2-pig.position.x)>250)
    {
         //    CCLOG(@" test!!!%f : %d",land2.position.x-[land2 texture].contentSize.width/2-pig.position.x,land2ok);
        if (pigjumped==1)
        {
            land2ok=1;
            CCLOG(@" Game enter!!!%f : %d",land2.position.x-[land2 texture].contentSize.width/2-pig.position.x,land2ok);
        }
    }
    if ((land2.position.x-[land2 texture].contentSize.width/2-pig.position.x)<200&&!(land2ok==1)){
        CCLOG(@"keng 1 Game Over!!!%f : %d",land2.position.x-[land2 texture].contentSize.width/2-pig.position.x,land2ok);
        [self GameOverSc];
    }
    
    
    //判定第二个坑，第3板块前
    if((land3.position.x-[land3 texture].contentSize.width/2-pig.position.x)<400&&(land3.position.x-[land3 texture].contentSize.width/2-pig.position.x)>200)
    {
        CCLOG(@" test!!!%f : %d",land3.position.x-[land3 texture].contentSize.width/2-pig.position.x,land3ok);
        if (pigjumped==1)
        {
            land3ok=1;
           
        }
    }
    if ((land3.position.x-[land3 texture].contentSize.width/2-pig.position.x)<200&&!(land3ok==1)){
        CCLOG(@"keng2  Game Over!!!%f : %d",land3.position.x-[land3 texture].contentSize.width/2-pig.position.x,land3ok);
        [self GameOverSc];

    }
    
    
    //判定第3个坑，第4板块前
    if((land4.position.x-[land4 texture].contentSize.width/2-pig.position.x)<400&&(land4.position.x-[land4 texture].contentSize.width/2-pig.position.x)>200)
    {
        CCLOG(@"33 test!!!%f : %d",land4.position.x-[land4 texture].contentSize.width/2-pig.position.x,land4ok);
        if (pigjumped==1)
        {
            land4ok=1;
            
        }
    }
    if ((land4.position.x-[land4 texture].contentSize.width/2-pig.position.x)<200&&!(land4ok==1)){
        CCLOG(@"keng 3 Game Over!!!%f : %d",land4.position.x-[land4 texture].contentSize.width/2-pig.position.x,land4ok);
        [self GameOverSc];

    }
    
}


-(void)GameOverSc
{
     CGSize screenSize=[[CCDirector sharedDirector] winSize];
    label1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Game Over "] fontName:@"Marker Felt" fontSize:81];
    label1.position =  ccp(screenSize.width /2 ,screenSize.height/2 );
    [self addChild: label1];
    [[CCDirector sharedDirector] pause];
    
}
- (void)selectSpriteForTouch:(CGPoint)touchLocation
{
    CGSize screenSize=[[CCDirector sharedDirector] winSize];
    if (CGRectContainsPoint(pig.boundingBox, touchLocation))
    {
        if (pigjumped==0)
        {
            pigjumped=1;
            CGPoint posfinish=pig.position;
            if(pig.position.x>(land3.position.x-[land3 texture].contentSize.width/2-400)&&pig.position.x<(land3.position.x-[land3 texture].contentSize.width/2-200))
            {
                posfinish.y+=50;
                
            }
            
            if(pig.position.x>(land4.position.x-[land4 texture].contentSize.width/2-400)&&pig.position.x<(land4.position.x-[land4 texture].contentSize.width/2-200)){
                posfinish.y-=50;
                
            }
            
            
            
            id pigacjump=[CCJumpTo actionWithDuration:1.5 position:CGPointMake(posfinish.x,posfinish.y) height:180 jumps:1];
            id pigacjumpend=[CCCallFunc actionWithTarget:self selector:@selector(pigjumpend)];
            
            CCSequence* sequencepigjump = [CCSequence actions:pigacjump,pigacjumpend,nil];
            [pig runAction:sequencepigjump];

        }

    }
    /*
    if (CGRectContainsPoint(pig_sun.boundingBox, touchLocation)&&(land6.position.x<screenSize.width/2)){
        
        CCSpriteBatchNode  *pig_suprise=[CCSprite spriteWithFile:@"pig_suprise.png"];
        pig_suprise.position=CGPointMake(screenSize.width*0.7 ,screenSize.height*0.715);
        [self addChild:pig_suprise z:30 tag:72];
   
    }
     */
        
 
}

-(void) pigjumpend{
    pigjumped=0;
}



- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];
    return TRUE;
}


-(void)dealloc
{
    CCLOG(@" %@ : %@",NSStringFromSelector(_cmd),self);

    [super dealloc];
}

-(void) runobsMoveSequencex:(CCSprite*)spider
{
    
	CGPoint belowScreenPosition = CGPointMake(spider.position.x-30,spider.position.y);
    //CCLOG(@" --- %d ---- %f -----", belowScreenPosition.x,belowScreenPosition.y);
	CCMoveTo* move = [CCMoveTo actionWithDuration:0.1f position:belowScreenPosition];
    
	CCSequence* sequence = [CCSequence actions:move,nil];
	[spider runAction:sequence];
    
    
    
}

-(void) runobsMoveSequencey:(CCSprite*)spider
{
    
	CGPoint belowScreenPosition = CGPointMake(spider.position.x-16,spider.position.y+20);
    //CCLOG(@" --- %d ---- %f -----", belowScreenPosition.x,belowScreenPosition.y);
	CCMoveTo* move = [CCMoveTo actionWithDuration:0.1f position:belowScreenPosition];
    
	CCSequence* sequence = [CCSequence actions:move,nil];
	[spider runAction:sequence];
    
    
    
}


-(void) backmenu{
    
    
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetSceneHome];
    [[CCDirector sharedDirector] replaceScene:newScene];
    
    //[[CCDirector sharedDirector] replaceScene:[FirstScene scene]];
    // CCLOG(@"开始游戏");
}

-(void) gampause{
    [[CCDirector sharedDirector] pause];
}

-(void) gamingmenu{
    [[CCDirector sharedDirector] pause];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    backgroundmenu = [CCSprite spriteWithFile:@"gaming-listback.png"];
    backgroundmenu.position = CGPointMake(screenSize.width*0.78,screenSize.height*0.7);
    [self addChild:backgroundmenu z:35 tag:120];
    
    CCMenuItemImage *menum1 = [CCMenuItemImage itemFromNormalImage:@"gaming-list1.png" selectedImage:@"gaming-list1-1.png" disabledImage:@"gaming-list1.png" target:self selector:@selector(gomenu1)];
    menu1 = [CCMenu menuWithItems: menum1, nil];
    menu1.position = CGPointMake(screenSize.width*0.9, screenSize.height*0.86);
    [self addChild: menu1 z:40 tag:121];
    
    
    CCMenuItemImage *menum2 = [CCMenuItemImage itemFromNormalImage:@"gaming-list2.png" selectedImage:@"gaming-list2-1.png" disabledImage:@"gaming-list2.png" target:self selector:@selector(gomenu2)];
    menu2 = [CCMenu menuWithItems: menum2, nil];
    menu2.position =  CGPointMake(screenSize.width*0.68, screenSize.height*0.91);
    
    [self addChild: menu2 z:40 tag:122];
    
    CCMenuItemImage *menum3 = [CCMenuItemImage itemFromNormalImage:@"gaming-list3.png" selectedImage:@"gaming-list3-1.png" disabledImage:@"gaming-list3.png" target:self selector:@selector(gomenu3)];
    menu3 = [CCMenu menuWithItems: menum3, nil];
    menu3.position =  CGPointMake(screenSize.width*0.81, screenSize.height*0.62);
    
    [self addChild: menu3 z:40 tag:123];
    
    CCMenuItemImage *menum4 = [CCMenuItemImage itemFromNormalImage:@"gaming-list4.png" selectedImage:@"gaming-list4-1.png" disabledImage:@"gaming-list4.png" target:self selector:@selector(gomenu4)];
    menu4 = [CCMenu menuWithItems: menum4, nil];
    menu4.position =  CGPointMake(screenSize.width*0.93, screenSize.height*0.58);
    [self addChild: menu4 z:40 tag:124];
    
    CCMenuItemImage *menum5 = [CCMenuItemImage itemFromNormalImage:@"gaming-list5.png" selectedImage:@"gaming-list5-1.png" disabledImage:@"gaming-list5.png" target:self selector:@selector(gomenu5)];
    menu5 = [CCMenu menuWithItems: menum5, nil];
    menu5.position =  CGPointMake(screenSize.width*0.72, screenSize.height*0.74);
    [self addChild: menu5 z:40 tag:125];
    
    
    
}

-(void) gomenu1{
    //  [self removeAnimationByName: ];
    // [[CCAnimationCache sharedAnimationCache] removeAnimationByName:@"gamefish"];
    //   CCNode *node=[self getchildbytag:120];
    //  CCSprite *spriteName=(sprite*) node;
    [self removeChildByTag:120 cleanup:YES];
    [self removeChildByTag:121 cleanup:YES];
    [self removeChildByTag:122 cleanup:YES];
    [self removeChildByTag:123 cleanup:YES];
    [self removeChildByTag:124 cleanup:YES];
    [self removeChildByTag:125 cleanup:YES];
    [[CCDirector sharedDirector] resume];
    
    
    
}

-(void) gomenu2{
    [[CCDirector sharedDirector] resume];
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetScene3Scene];
    [[CCDirector sharedDirector] replaceScene:newScene];
    
}
-(void) gomenu3{
    // CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetSceneFirstScene];
    //[[CCDirector sharedDirector] replaceScene:newScene];
    
}

-(void) gomenu4{
    // CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetScene2Scene];
    // [[CCDirector sharedDirector] replaceScene:newScene];
    
}
-(void) gomenu5{
    [[CCDirector sharedDirector] resume];
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetSceneHome];
    [[CCDirector sharedDirector] replaceScene:newScene];
    
}

@end