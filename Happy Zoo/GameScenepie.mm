//
//  GameScene.m
//  test1
//
//  Created by f on 10/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScenepie.h"
#import "GameOverScene.h"
#import "LoadingScene.h"
#import "FirstScene.h"
#import "GamingMain.h"


@implementation GameScenepie

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
    CCLayer* layer =[GameScenepie node];
    [scene addChild:layer];
    return scene;
}

+(void) simulateLongLoadingTime
{
	// Simulating a long loading time by doing some useless calculation a large number of times.
	double a = 122, b = 243;
	for (unsigned int i = 0; i < 20000000; i++)
	{
		a = a / b;
	}
}
-(void) simLongLoadingTime
{
	// Simulating a long loading time by doing some useless calculation a large number of times.
	double a = 122, b = 243;
	for (unsigned int i = 0; i < 60000000; i++)
	{
		a = a / b;
	}
}

-(id) init
{
    if ((self=[super init]))
    {
        CCLOG(@" %@ : %@",NSStringFromSelector(_cmd),self);
        CGSize screenSize=[[CCDirector sharedDirector] winSize];
        
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"guanka1.mp3" loop:YES];
        gametime=0;
        gamescene=1;
        
               
         [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
        
       //圆形阀门
        Pipeline=[CCSprite spriteWithFile:@"pipeline_switch-first.png"];
       float imageHeight=[Pipeline texture].contentSize.height;
       Pipeline.position=CGPointMake([Pipeline texture].contentSize.width*1.3, screenSize.height-imageHeight);
       [self addChild:Pipeline z:22 tag:71];
        
        //红色横着的阀门
        Pipeweitch=[CCSprite spriteWithFile:@"switchdefault.png"];
        Pipeweitch.position=CGPointMake(screenSize.width*0.73 ,screenSize.height*0.715);
        [self addChild:Pipeweitch z:3 tag:72];
        
        //鱼缸
        Pipeline=[CCSprite spriteWithFile:@"pipeline_fishbowl.png"];
        Pipeline.position=CGPointMake(screenSize.width*0.8,screenSize.height*0.24);
        [self addChild:Pipeline z:30 tag:11];
        
        //最后的那个阀门
        Pipetap=[CCSprite spriteWithFile:@"pipeline_tap.png"];
        Pipetap.position=CGPointMake([Pipetap texture].contentSize.width*5.7, screenSize.height-imageHeight*2);
        [self addChild:Pipetap z:2];
        
        //不动的几个管道
        Pipeline=[CCSprite spriteWithFile:@"pipeline1-2.png"];
        Pipeline.position=CGPointMake([Pipeline texture].contentSize.width*1.7, screenSize.height);
         [self addChild:Pipeline z:2 tag:111];
        Pipeline=[CCSprite spriteWithFile:@"pipeline2-2.png"];
        Pipeline.position=CGPointMake([Pipeline texture].contentSize.width*1.7, screenSize.height-imageHeight);
        [self addChild:Pipeline z:2 tag:112];
        Pipeline=[CCSprite spriteWithFile:@"pipeline2-4.png"];
        Pipeline.position=CGPointMake([Pipeline texture].contentSize.width*0.7, screenSize.height-imageHeight);
        [self addChild:Pipeline z:2 tag:113];
        
        //背景
        background = [CCSprite spriteWithFile:@"waterbackground1.png"];
        background.anchorPoint = ccp(0,0);
        [self addChild:background];

        
        movableSprites = [[NSMutableArray alloc] init];
        //管道默认位置方向，设置。
        NSArray *images = [NSArray arrayWithObjects:@"pipeline1-1.png", @"pipeline2-1.png", @"pipeline2-2.png", nil];
        for(int i =0; i < images.count; ++i)
        {
            NSString *image = [images objectAtIndex:i];
            CCSprite *sprite = [CCSprite spriteWithFile:image];
  
            sprite.position = ccp([sprite texture].contentSize.width*(i+2.7), screenSize.height-imageHeight);
            [self addChild:sprite];
            [movableSprites addObject:sprite];
        }
        gamesc=0;
        gameover=0;
        array1[1]=1; array1[2]=1; array1[3]=1; array1[4]=1;array1[5]=1;array1[6]=1; array1[7]=1;array1[8]=1; array1[9]=2;array1[10]=3;
        array1[11]=1;array1[12]=4; array1[13]=2;array1[15]=1; array1[17]=2;array1[18]=2;array1[19]=1;

        
        NSArray *images1 = [NSArray arrayWithObjects:@"pipeline2-4.png", @"pipeline1-2.png", @"pipeline2-2.png",  @"pipeline1-1.png", @"pipeline2-4.png",nil];
   
        for(int i =0; i < images1.count; ++i)
        {
            NSString *image = [images1 objectAtIndex:i];
            CCSprite *sprite = [CCSprite spriteWithFile:image];
               sprite.position = ccp([sprite texture].contentSize.width*(i+0.7), screenSize.height-imageHeight*2);
            [self addChild:sprite];
            [movableSprites addObject:sprite];
        }
        
        NSArray *images2 = [NSArray arrayWithObjects:@"pipeline2-1.png", @"pipeline1-1.png", @"pipeline2-1.png",  @"pipeline1-1.png", nil];
        for(int i =0; i < images2.count; ++i)
        {
            NSString *image = [images2 objectAtIndex:i];
            CCSprite *sprite = [CCSprite spriteWithFile:image];
      
            sprite.position = ccp([sprite texture].contentSize.width*(i+0.7), screenSize.height-imageHeight*3);
            [self addChild:sprite];
            [movableSprites addObject:sprite];
        }
        
        images2 = [NSArray arrayWithObjects:@"pipeline2-3.png", @"pipeline2-3.png", @"pipeline1-2.png",  @"pipeline1-1.png", nil];
        for(int i =0; i < images2.count; ++i)
        {
            NSString *image = [images2 objectAtIndex:i];
            CCSprite *sprite = [CCSprite spriteWithFile:image];
                  sprite.position = ccp([sprite texture].contentSize.width*(i+0.7), screenSize.height-imageHeight*4);
            [self addChild:sprite];
            [movableSprites addObject:sprite];
        }
        images2 = [NSArray arrayWithObjects:@"pipeline2-2.png", @"pipeline2-1.png", @"pipeline1-1.png",  @"pipeline2-3.png", nil];
        
        
        for(int i =0; i < images2.count; ++i)
        {
            NSString *image = [images2 objectAtIndex:i];
            CCSprite *sprite = [CCSprite spriteWithFile:image];
                 sprite.position = ccp([sprite texture].contentSize.width*(i+0.7), screenSize.height-imageHeight*5);
            [self addChild:sprite z:5];
            [movableSprites addObject:sprite];
            
        }
            label1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@" "] fontName:@"Marker Felt" fontSize:64];
            label1.position =  ccp(screenSize.width /2 ,screenSize.height/3 );
            [self addChild: label1];
            

            //活动的鱼默认
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"fishdef_default.plist"];
            tank_fish = [CCSprite spriteWithSpriteFrameName:@"fishdefault1.png"];
            [tank_fish setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
            [self addChild:tank_fish z:7 tag:36];
            pAnimfishde = [CCAnimation animation];
            for(unsigned int i = 1; i < 8; i++)
            {
                NSString *namefishde = [NSString stringWithFormat:@"fishdefault%d.png", i];
                [pAnimfishde addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:namefishde ]];
            }
            [pAnimfishde setDelayPerUnit:0.25f];
            id actionfishde =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:pAnimfishde], NULL]];
            [tank_fish runAction:actionfishde];
            
        
        //隐藏物品
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gameoverthings.plist"];
        game1treasure=[CCSprite spriteWithSpriteFrameName:@"treasure01.png"];
        [game1treasure setPosition:ccp(screenSize.width*0.06,screenSize.height*0.14)];
        [self addChild:game1treasure z:4 tag:501];

            //最开始的水默认流动
 
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"waterfront.plist"];
        CCSprite* pSpritefront = [CCSprite spriteWithSpriteFrameName:@"Fish_water1.png"];
        [pSpritefront setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
        [self addChild:pSpritefront z:3];
        CCAnimation *pAnimfront = [CCAnimation animation];
        for(unsigned int i = 1; i < 3; i++)
        {
             NSString *namefront = [NSString stringWithFormat:@"Fish_water%d.png", i];
             [pAnimfront addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:namefront]];
         }
        [pAnimfront setDelayPerUnit:0.5f];
        id actionfront =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.5f], [CCAnimate  actionWithAnimation:pAnimfront], NULL]];
        [pSpritefront runAction:actionfront];
  
            //水图提前缓存
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"watertp1.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"watertp2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"watertp3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"watertp4.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"watertp5.plist"];
            
            //游戏菜单
       CCMenuItemImage *menum11 = [CCMenuItemImage itemFromNormalImage:@"gaming-pause.png" selectedImage:@"gaming-pause.png" disabledImage:@"gaming-pause.png" target:self selector:@selector(gamingmenu)];
       CCMenu *menu11 = [CCMenu menuWithItems: menum11, nil];
        menu11.position = CGPointMake(screenSize.width*0.9, screenSize.height*0.9);
       [self addChild: menu11 z:30];
            
        waitstar=0;

        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];

        }
        [self schedule:@selector(update:) interval:0.1f];

        return self; 
}


- (void)update:(ccTime)dt {
    gametime++;
    NSLog(@"Time is =%d=",gametime);
    CGSize screenSize=[[CCDirector sharedDirector] winSize];
    if (game1thing==1) {
       
        game1treasure.visible=NO;
        
        game1thing=2;
        [[SimpleAudioEngine sharedEngine]playEffect:@"foundthing.mp3" ];
        game1treasures=[CCSprite spriteWithSpriteFrameName:@"Game-treasure1.png"];
        [game1treasures setPosition:ccp(screenSize.width*0.12,screenSize.height*0.14)];
        [self addChild:game1treasures z:35];

    }
    if (game1thing==2) {
        waitstar++;
        if (waitstar>20)
        {
            CGPoint temp=game1treasures.position;
            temp.x=temp.x-4;
            temp.y=temp.y-4;
            game1treasures.position=temp;
            }
    }
 
  
}

-(void)dealloc
{
     CCLOG(@" %@ : %@",NSStringFromSelector(_cmd),self);
    [movableSprites release];
    movableSprites=nil;
    [super dealloc];
}


- (void)selectSpriteForTouch:(CGPoint)touchLocation
{
    
    
    if (CGRectContainsPoint(game1treasure.boundingBox, touchLocation))
    {
        NSLog(@"faxianla1");
        game1thing=1;
        //[game1treasure removeFromParentAndCleanup:YES];
       // [self removeChild:game1treasure cleanup:YES];
       
    }
    
    if (gameover==0){
    CCSprite * newSprite = nil;
    int num=0;
    
       for (;num<20;num++)
       {
           CCSprite *sprite=[movableSprites objectAtIndex:num];
    
          //for (CCSprite *sprite in movableSprites) {
           if (CGRectContainsPoint(sprite.boundingBox, touchLocation))
           {
                 [[SimpleAudioEngine sharedEngine]playEffect:@"dangdang.wav" ];
                newSprite = sprite;
                numberp=num;
               break;
           }
       }
      
    
       [selSprite stopAllActions];
        selSprite = newSprite;

         array1[numberp]++;
         array2[numberp]++;
        if (numberp!=0 && numberp!=14 && numberp!=16 &&num<=19)
        {
            if (numberp==4 || numberp==6 || numberp==9 || numberp==11 ||numberp==18 || numberp==15)
            {
                if (array1[numberp]%2==0)
                {
                    gamesc++;
                }
                 else
                 {
                     if (gamesc!=0 && array2[numberp]!=1)  gamesc--;
                             
                 }
            }else
            {
                if (array1[numberp]%4==0)
                     {
                         gamesc++;
                         array1[numberp]=array1[numberp]%4;
                     }
                     else{
                         if (gamesc!=0 && (array1[numberp]-1)%4==0)
                         {
                             gamesc--;
                         }
                         array1[numberp]=array1[numberp]%4;
                     }
           
            }
        }
    
        selSprite.rotation=90*array2[numberp];
    CGSize screenSize=[[CCDirector sharedDirector] winSize];
        
    }
    
    
    pAnim = [CCAnimation animation];
    for(unsigned int i = 1; i < 38; i++)
    {
        NSString *name = [NSString stringWithFormat:@"Fish_water%d.png", i];
        [pAnim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name]];
    }
    [pAnim setDelayPerUnit:0.15f];
    

     if(array1[1]%4==0&&array1[2]%4==0&&array1[3]%4==0&&array1[4]%2==0&&array1[5]%4==0&&array1[6]%2==0&&array1[7]%4==0&&array1[8]%4==0&&array1[9]%2==0&&array1[10]%4==0&&array1[11]%2==0&&array1[12]%4==0&&array1[13]%4==0&&array1[15]%2==0&&array1[17]%4==0&&array1[18]%2==0&&array1[19]%4==0)
    {
  
        CGSize screenSize=[[CCDirector sharedDirector] winSize];
        gameover=1;

       
        CCSprite* Spwater = [CCSprite spriteWithSpriteFrameName:@"Fish_water1.png"];
        [Spwater setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
        [self addChild:Spwater  z:6];
        

  
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"switch1.plist"];
        CCSpriteBatchNode* Spswitch = [CCSprite spriteWithSpriteFrameName:@"switch2-1.png"];
        [Spswitch setPosition:ccp(screenSize.width*0.73 ,screenSize.height*0.715)];
        [self addChild:Spswitch z:5];
        CCAnimation *pAnims = [CCAnimation animation];
        for(unsigned int i = 1; i < 14; i++)
        {
            NSString *names = [NSString stringWithFormat:@"switch2-%d.png", i];
            [pAnims addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:names]];
        }
        [pAnims setDelayPerUnit:0.1f];
        id actions =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:pAnims], NULL]];
        [Spswitch runAction:actions];
        
        
        //开头那里的圆形开关
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"switch3_default.plist"];
        CCSpriteBatchNode* Spswitch3 = [CCSprite spriteWithSpriteFrameName:@"switch3-1.png"];
        [Spswitch3 setPosition:ccp(screenSize.width*0.16 ,screenSize.height*0.83)];
        [self addChild:Spswitch3 z:22];
        CCAnimation *pswitch3 = [CCAnimation animation];
        for(unsigned int i = 1; i < 8; i++)
        {
            NSString *naswitch = [NSString stringWithFormat:@"switch3-%d.png", i];
            [pswitch3 addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naswitch]];
        }
        [pswitch3 setDelayPerUnit:0.5f];
        id actswitch3 =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.2f], [CCAnimate  actionWithAnimation:pswitch3], NULL]];
        [Spswitch3 runAction:actswitch3];
        
    
        
        [self removeChildByTag:71 cleanup:YES];
        [self removeChildByTag:72 cleanup:YES];

       
        id acfishblack = [CCCallFunc actionWithTarget:self selector:@selector(Callfish)];
        id acfrontpie = [CCCallFunc actionWithTarget:self selector:@selector(Callfrontpie)];
        id acfwafish = [CCCallFunc actionWithTarget:self selector:@selector(Callfishwater)];
        
         //结局水动画
        [Spwater runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCAnimate  actionWithAnimation:pAnim],acfrontpie,acfwafish,acfishblack,[CCDelayTime actionWithDuration:5.1f],NULL]];
        

    }
    
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation]; 
    return TRUE; 
}


- (void) Callfish {

    CGSize screenSize=[[CCDirector sharedDirector] winSize];
    Pipeline=[CCSprite spriteWithFile:@"fish-tankb.png"];
    Pipeline.position=CGPointMake(screenSize.width*0.8,screenSize.height*0.24);
    //[self addChild:Pipeline z:10 tag:11];
    tank_fish.visible=NO;

}

- (void) Callfrontpie {
    CGSize screenSize=[[CCDirector sharedDirector] winSize];
    CCSprite* pSpritefront = [CCSprite spriteWithFile:@"waterfront4.png"];
    [pSpritefront setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    //[self addChild:pSpritefront z:4];
}

-(void)Gameovers{
     CGSize screenSize=[[CCDirector sharedDirector] winSize];
    if (gametime<280) {
        game1level=3;
        [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine]playEffect:@"start3.mp3" ];
        NSLog(@"gamelevel~~%d",game1level);
        CCSprite *gamesprite=[CCSprite spriteWithSpriteFrameName:@"game-end4.png"];

        [gamesprite setPosition:ccp(screenSize.width*0.5,screenSize.height*0.5)];
        [self addChild:gamesprite z:50 tag:501];
        

        
    }else if (gametime<400){
        game1level=2;
        NSLog(@"gamelevel~~%d",game1level);
          [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine]playEffect:@"start2.mp3" ];

        CCSprite *gamesprite=[CCSprite spriteWithSpriteFrameName:@"game-end3.png"];
        
        [gamesprite setPosition:ccp(screenSize.width*0.5,screenSize.height*0.5)];
        [self addChild:gamesprite z:50 tag:501];

    }else {
        game1level=1;
        NSLog(@"gamelevel~~%d",game1level);
          [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine]playEffect:@"start1.mp3" ];
        CCSprite *gamesprite=[CCSprite spriteWithSpriteFrameName:@"game-end2.png"];
        
        [gamesprite setPosition:ccp(screenSize.width*0.5,screenSize.height*0.5)];
        [self addChild:gamesprite z:50 tag:501];

        
    }
    [[CCDirector sharedDirector] pause];

    CCMenuItemImage *menum2 = [CCMenuItemImage itemFromNormalImage:@"gaming-list2.png" selectedImage:@"gaming-list2-1.png" disabledImage:@"gaming-list2.png" target:self selector:@selector(gomenu2)];
    menu2 = [CCMenu menuWithItems: menum2, nil];
    menu2.position =  CGPointMake(screenSize.width*0.31, screenSize.height*0.48);
    [self addChild: menu2 z:55 tag:122];
    
    CCMenuItemImage *menum5 = [CCMenuItemImage itemFromNormalImage:@"gaming-list5.png" selectedImage:@"gaming-list5-1.png" disabledImage:@"gaming-list5.png" target:self selector:@selector(gomenu5)];
    menu5 = [CCMenu menuWithItems: menum5, nil];
    menu5.position =  CGPointMake(screenSize.width*0.39, screenSize.height*0.33);
    [self addChild: menu5 z:55 tag:125];
    
    CCMenuItemImage *menum7 = [CCMenuItemImage itemFromNormalImage:@"gaming-list7.png" selectedImage:@"gaming-list7-1.png" disabledImage:@"gaming-list7.png" target:self selector:@selector(gomenu7)];
    menu7 = [CCMenu menuWithItems: menum7, nil];
    menu7.position =  CGPointMake(screenSize.width*0.51, screenSize.height*0.26);
    [self addChild: menu7 z:55 tag:125];
    
    
    //CCTransitionFade *tranScene=[CCTransitionFade transitionWithDuration:1 scene:[GameOverScene scene]];
    //[[CCDirector sharedDirector] replaceScene:tranScene];

}




- (void) Callfishwater {
    CGSize screenSize=[[CCDirector sharedDirector] winSize];
    CCSprite* Spwaterfish = [CCSprite node];
    [Spwaterfish setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:Spwaterfish z:20];
    
    //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"waterfish1.plist"];
    //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"waterfish2.plist"];
    //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"waterfish3.plist"];
     
    CCAnimation *pAnimwfish = [CCAnimation animation];
    for(unsigned int i = 39; i < 53; i++)
    {
        NSString *namewfish = [NSString stringWithFormat:@"Fish_water%d.png", i];
        [pAnimwfish addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:namewfish]];
    }
    [pAnimwfish setDelayPerUnit:0.2f];
     id acfover = [CCCallFunc actionWithTarget:self selector:@selector(Gameovers)];
    
    
    [Spwaterfish runAction:[CCSequence actions:[CCAnimate  actionWithAnimation:pAnimwfish],acfover,NULL]];
    NSLog(@"~haimeihuan~gamelevel~~%d",game1level);

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
     [[SimpleAudioEngine sharedEngine]playEffect:@"replay.mp3"];
    [[CCDirector sharedDirector] resume];
    waitstar=0;
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetSceneFirstScene];
    [[CCDirector sharedDirector] replaceScene:newScene];
    
}
-(void) gomenu3{
   // CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetSceneFirstScene];
    //[[CCDirector sharedDirector] replaceScene:newScene];
    
}

-(void) gomenu4{
    isPlaying=[[SimpleAudioEngine sharedEngine]isBackgroundMusicPlaying];
    if (isPlaying) {
        [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
    }else{
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"guanka1.mp3" loop:YES];
    }
    
}
-(void) gomenu5{
    [[CCDirector sharedDirector] resume];
    waitstar=0;
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetSceneHome];
    [[CCDirector sharedDirector] replaceScene:newScene];
    
}

-(void) gomenu7{
    [[CCDirector sharedDirector] resume];
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetScene2Scene];
    [[CCDirector sharedDirector] replaceScene:newScene];
    
}
//


@end
