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
        
        
        //管道
        CCMenuItemImage *menum1 = [CCMenuItemImage itemFromNormalImage:@"mainlist1.png" selectedImage:@"mainlist1.png" disabledImage:@"mainlist1.png" target:self selector:@selector(gomenu1)];
        CCMenu *menu1 = [CCMenu menuWithItems: menum1, nil];
        menu1.position = CGPointMake(size.width*0.5, size.height*0.45);
        [self addChild: menu1 z:5];
        
        
        //气球
        CCMenuItemImage *menum2 = [CCMenuItemImage itemFromNormalImage:@"mainlist2.png" selectedImage:@"mainlist2.png" disabledImage:@"mainlist2.png" target:self selector:@selector(gomenu2)];
        CCMenu *menu2 = [CCMenu menuWithItems: menum2, nil];
        menu2.position =  CGPointMake(size.width*0.82, size.height*(-0.20));
        menu2.rotation=40;
        [self addChild: menu2 z:4];
        
        //跑酷
        CCMenuItemImage *menum3 = [CCMenuItemImage itemFromNormalImage:@"mainlist3.png" selectedImage:@"mainlist3.png" disabledImage:@"mainlist3.png" target:self selector:@selector(gomenu3)];
        CCMenu *menu3 = [CCMenu menuWithItems: menum3, nil];
        menu3.position =  CGPointMake(size.width*(-0.01), size.height*0.65);
        menu3.rotation=-35;
        [self addChild: menu3 z:4];
        
        CCMenuItemImage *menum4 = [CCMenuItemImage itemFromNormalImage:@"mainlist4.png" selectedImage:@"mainlist4.png" disabledImage:@"mainlist4.png" target:self selector:@selector(gomenu2)];
        CCMenu *menu4 = [CCMenu menuWithItems: menum4, nil];
        menu4.position =  CGPointMake(size.width*0.84, size.height*(-0.82));
        menu4.rotation=70;
        [self addChild: menu4 z:10];
        
        
        //更多
        CCMenuItemImage *menum5 = [CCMenuItemImage itemFromNormalImage:@"mainlist5.png" selectedImage:@"mainlist5.png" disabledImage:@"mainlist5.png" target:self selector:@selector(gomenu2)];
        CCMenu *menu5 = [CCMenu menuWithItems: menum5, nil];
        menu5.position =  CGPointMake(size.width*(-0.51), size.height*0.42);
        menu5.rotation=-70;
        [self addChild: menu5 z:10];
        
        
        
        
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
