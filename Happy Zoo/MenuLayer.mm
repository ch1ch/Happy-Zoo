//
//  MenuLayer.m
//  Happy Zoo
//
//  Created by f on 4/11/13.
//
//

#import "LoadingScene.h"
#import "MenuLayer.h"

@implementation MenuLayer


-(id)init
{
    if ((self =[super init]))
    {
        screenSize=[[CCDirector sharedDirector] winSize];
       
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        CCMenuItemImage *menum11 = [CCMenuItemImage itemFromNormalImage:@"gaming-pause.png" selectedImage:@"gaming-pause.png" disabledImage:@"gaming-pause.png" target:self selector:@selector(gamingmenu)];
        CCMenu *menu11 = [CCMenu menuWithItems: menum11, nil];
        menu11.position = CGPointMake(screenSize.width*0.9, screenSize.height*0.9);
        [self addChild: menu11 z:30];
        
    }
    return self;
}

-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// don't forget to call "super dealloc"
	[super dealloc];
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
