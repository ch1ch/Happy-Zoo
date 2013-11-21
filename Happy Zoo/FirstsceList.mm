//
//  firstsclist.m
//  test1
//
//  Created by f on 11/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstsceList.h"
#import "FirstScene.h"
#import "LoadingScene.h"

@interface FirstscList
@end


@implementation FirstsceList

-(id) init
{
    if ((self = [super init]))
	{
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];

        CGSize size = [[CCDirector sharedDirector] winSize];
        self.isTouchEnabled = YES;
       // ListLayerPosition= self.position;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"mainopen-ball2.png"];
        background.position = CGPointMake(screenSize.width*0.5,0 );
        [self addChild:background z:2];
        
        [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"manlist.plist"];
        
        
        
        //管道
        CCMenuItemImage *menum1 = [CCMenuItemImage itemFromNormalImage:@"mainlist1_1.png" selectedImage:@"mainlist1_2.png" disabledImage:@"mainlist1_1.png" target:self selector:@selector(gomenu1)];
        CCMenu *menu1 = [CCMenu menuWithItems: menum1, nil];
        menu1.position = CGPointMake(size.width*0.5, size.height*0.45);
        [self addChild: menu1 z:5];
        
        NSString *game1s=[ NSString  stringWithFormat:@"star%d.png",game1level+1];
        CCSprite *list1star=[CCSprite spriteWithFile:game1s];
        list1star.position=CGPointMake(screenSize.width*0.5 ,screenSize.height*0.53);
        [self addChild:list1star z:6];
        
        game1s=[ NSString  stringWithFormat:@"cheese%d.png",game1thing+1];
        CCSprite *list1thing=[CCSprite spriteWithFile:game1s];
        list1thing.position=CGPointMake(screenSize.width*0.5 ,screenSize.height*0.46);
        [self addChild:list1thing z:6];

        
        //气球
        CCMenuItemImage *menum2 = [CCMenuItemImage itemFromNormalImage:@"mainlist2_1.png" selectedImage:@"mainlist2_2.png" disabledImage:@"mainlist2_1.png" target:self selector:@selector(gomenu2)];
        CCMenu *menu2 = [CCMenu menuWithItems: menum2, nil];
        menu2.position =  CGPointMake(size.width*(-0.01), size.height*0.65);
        menu2.rotation=-35;
        //menu2.position =  CGPointMake(size.width*0.82, size.height*(-0.20));
        //menu2.rotation=40;
        [self addChild: menu2 z:4];
        
        game1s=[ NSString  stringWithFormat:@"star%d.png",game2level+1];
        CCSprite *list2star=[CCSprite spriteWithFile:game1s];
        list2star.position =  CGPointMake(size.width*0.26, size.height*0.42);
        list2star.rotation=-35;
        [self addChild:list2star z:6];
        
        game1s=[ NSString  stringWithFormat:@"bow%d.png",game2thing+1];
        CCSprite *list2thing=[CCSprite spriteWithFile:game1s];
        list2thing.position =  CGPointMake(size.width*0.295, size.height*0.36);
        list2thing.rotation=-35;
        [self addChild:list2thing z:6];
        
        
        //跑酷
        CCMenuItemImage *menum3 = [CCMenuItemImage itemFromNormalImage:@"mainlist3_1.png" selectedImage:@"mainlist3_2.png" disabledImage:@"mainlist3_1.png" target:self selector:@selector(gomenu3)];
        CCMenu *menu3 = [CCMenu menuWithItems: menum3, nil];
        menu3.position =  CGPointMake(size.width*(-0.51), size.height*0.42);
        menu3.rotation=-70;
        [self addChild: menu3 z:4];
        
        game1s=[ NSString  stringWithFormat:@"star%d.png",game3level+1];
        CCSprite *list3star=[CCSprite spriteWithFile:game1s];
        list3star.position =  CGPointMake(size.width*0.12, size.height*0.15);
        list3star.rotation=-70;
        [self addChild:list3star z:6];
        
        game1s=[ NSString  stringWithFormat:@"hat%d.png",game3thing+1];
        CCSprite *list3thing=[CCSprite spriteWithFile:game1s];
        list3thing.position =  CGPointMake(size.width*0.17, size.height*0.13);
        list3thing.rotation=-70;
        [self addChild:list3thing z:6];
        
        
        //拖板子
        CCMenuItemImage *menum4 = [CCMenuItemImage itemFromNormalImage:@"mainlist4_1.png" selectedImage:@"mainlist4_2.png" disabledImage:@"mainlist4_1.png" target:self selector:@selector(gomenu4)];
        CCMenu *menu4 = [CCMenu menuWithItems: menum4, nil];
        menu4.position =  CGPointMake(size.width*0.82, size.height*(-0.20));
        menu4.rotation=40;

        [self addChild: menu4 z:5];
        
        game1s=[ NSString  stringWithFormat:@"star%d.png",game4level+1];
        CCSprite *list4star=[CCSprite spriteWithFile:game1s];
        list4star.position =  CGPointMake(size.width*0.735, size.height*0.405);
        list4star.rotation=40;
        [self addChild:list4star z:6];
        
        game1s=[ NSString  stringWithFormat:@"apple%d.png",game4thing+1];
        CCSprite *list4thing=[CCSprite spriteWithFile:game1s];
        list4thing.position =  CGPointMake(size.width*0.695, size.height*0.365);
        list4thing.rotation=40;
        [self addChild:list4thing z:6];
        
        
        //更多
        CCMenuItemImage *menum5 = [CCMenuItemImage itemFromNormalImage:@"mainlist5_1.png" selectedImage:@"mainlist5_2.png" disabledImage:@"mainlist5_1.png" target:self selector:@selector(gomenu5)];
        CCMenu *menu5 = [CCMenu menuWithItems: menum5, nil];
        menu5.position =  CGPointMake(size.width*0.84, size.height*(-0.82));
        menu5.rotation=70;
        //menu5.position =  CGPointMake(size.width*(-0.51), size.height*0.42);
       // menu5.rotation=-70;
        [self addChild: menu5 z:10];
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"list_pig.plist"];
        CCSpriteBatchNode* list_pig = [CCSprite spriteWithSpriteFrameName:@"pig1.png"];
        [list_pig setPosition:ccp(size.width*0.5 ,size.height*(-0.44))];
        list_pig.rotation=180;
        [self addChild:list_pig z:7];
        CCAnimation *anpig = [CCAnimation animation];
        for(unsigned int i = 1; i <21; i++)
        {
            NSString *naback = [NSString stringWithFormat:@"pig%d.png", i];
            [anpig  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
        }
        [anpig setDelayPerUnit:0.2f];
        id actback =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.2f], [CCAnimate  actionWithAnimation:anpig], NULL]];
        [list_pig  runAction:actback];
        
        
        self.anchorPoint = ccp(0.5f, 0.0f);

    
    }
    return self;
}




-(void) gomenu1{
    //[[CCDirector sharedDirector] replaceScene:[GameScenepie scene]];
    // CCLOG(@"开始游戏");
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetSceneFirstScene];
    [[CCDirector sharedDirector] replaceScene:newScene];
    
}

-(void) gomenu2{
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetScene2Scene];
    [[CCDirector sharedDirector] replaceScene:newScene];
    
}

-(void) gomenu3{
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetScene3Scene];
    [[CCDirector sharedDirector] replaceScene:newScene];
        
}

-(void) gomenu4{
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetScene4Scene];
    [[CCDirector sharedDirector] replaceScene:newScene];
        
}

-(void) gomenu5{
    
    
}
-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// don't forget to call "super dealloc"
	[super dealloc];
}


@end
