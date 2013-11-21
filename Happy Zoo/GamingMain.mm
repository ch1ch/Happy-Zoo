//
//  GamingMain.m
//  test1
//
//  Created by f on 11/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GamingMain.h"
#import "FirstsceList.h"
#import "FirstScene.h"
#import "LoadingScene.h"
#import "GameSceneball.h"
#import "GameScenepie.h"

@interface GamingMainn
@end

@implementation GamingMain


-(id) init
{
    if ((self = [super init]))
	{
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"gaming-listback.png"];
        background.position = CGPointMake(screenSize.width*0.8,screenSize.height*0.8 );
        [self addChild:background z:25];
        
        
        

        
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

-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
