//
//  GameScenerun.m
//  Happy Zoo
//
//  Created by f on 1/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameScenepad.h"

#import "LoadingScene.h"
#import "FirstScene.h"
#import "GamingMain.h"
#import "GamepadCenter.h"
#import "GamepadMenu.h"


#define PTM_RATIO 32.0



@implementation GameScenepad



static FirstScene* multiLayerSceneInstance;

+(FirstScene*) sharedLayer
{
	NSAssert(multiLayerSceneInstance != nil, @"MultiLayerScene not available!");
	return multiLayerSceneInstance;
}


-(ListLayer*) listLayer
{
	CCNode* layer = [self getChildByTag:LayerTagGameLayer1];
	return (ListLayer*)layer;
}




+(id) scene
{
    CCScene *scene=[CCScene node];
    CCLayer* layer =[GameScenepad node];
    [scene addChild:layer];
    return scene;
}


-(id) init
{
    if ((self=[super init]))
    {
        padbacknumber=1;
        CCLOG(@" %@ : %@",NSStringFromSelector(_cmd),self);
       // CGSize screenSize=[[CCDirector sharedDirector] winSize];
        [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
        
        padcenter=[GamepadCenter node];
        
        padmenu=[GamepadMenu node];
        [self addChild:padcenter z:25 tag:LayerTagGameLayer1];
        [self addChild:padmenu z:40 tag:200];

        //背景，
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"padpic-1.plist"];


        [self schedule:@selector(tick:)interval:0.1f];
        [self setIsTouchEnabled:YES];
        
    }

  
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