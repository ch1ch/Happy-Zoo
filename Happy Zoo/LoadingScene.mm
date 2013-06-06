//
//  LoadingScene.m
//  ScenesAndLayers
//
//

#import "LoadingScene.h"
#import "GameScenepie.h"
#import "FirstScene.h"
#import "GameSceneball.h"
#import "GameScenerun.h"
#import "GameScenepad.h"


@interface LoadingScene (PrivateMethods)
-(void) update:(ccTime)delta;
@end

@implementation LoadingScene

+(id) sceneWithTargetScene:(TargetScenes)targetScene;
{
	CCLOG(@"===========================================");
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);

	// This creates an autorelease object of self (the current class: LoadingScene)
	return [[[self alloc] initWithTargetScene:targetScene] autorelease];
	
	// Note: this does the exact same, it only replaced self with LoadingScene. The above is much more common.
	//return [[[LoadingScene alloc] initWithTargetScene:targetScene] autorelease];
}

-(id) initWithTargetScene:(TargetScenes)targetScene
{
	if ((self = [super init]))
	{
        [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
		targetScene_ = targetScene;
    
         [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];

		[self scheduleUpdate];

	}
	
	return self;
}

-(void) update:(ccTime)delta
{
	// It's not strictly necessary, as we're changing the scene anyway. But just to be safe.
	[self unscheduleAllSelectors];

	
	// Decide which scene to load based on the TargetScenes enum.
	// You could also use TargetScene to load the same with using a variety of transitions.
	switch (targetScene_)
	{
		case TargetSceneFirstScene:
        {

            [self goscene1];
			break;
        }
		case TargetScene2Scene:
			//[[CCDirector sharedDirector] replaceScene:[GameSceneball scene]];
            [self goscene2];
			break;
        case TargetScene3Scene:
			//[[CCDirector sharedDirector] replaceScene:[GameScenerun scene]];
            [self goscene3];
			break;
        case TargetScene4Scene:
			//[[CCDirector sharedDirector] replaceScene:[GameScenepad scene]];
            [self goscene4];
			break;
        case TargetScene4Scene_1:
			[[CCDirector sharedDirector] replaceScene:[GameScenepad scene]];

			break;
        case TargetSceneHome:
			[[CCDirector sharedDirector] replaceScene:[FirstScene scene]];
			break;
			
		default:
			// Always warn if an unspecified enum value was used. It's a reminder for yourself to update the switch
			// whenever you add more enum values.
			NSAssert2(nil, @"%@: unsupported TargetScene %i", NSStringFromSelector(_cmd), targetScene_);
			break;
	}
	
	// Tip: example usage of the INVALID and MAX enum values to iterate over all enum values
	//for (TargetScenes i = TargetSceneINVALID + 1; i < TargetSceneMAX; i++)
	{
	}
}

-(void)goscene1{
         CGSize screenSize = [[CCDirector sharedDirector] winSize];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"teach_1.plist"];
    CCSprite *backgr = [CCSprite spriteWithSpriteFrameName:@"teachbackground.png"];
    [backgr setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:backgr z:2];
    
    CCSprite *font1 = [CCSprite spriteWithSpriteFrameName:@"fish.png"];
    [font1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.8)];
    [self addChild:font1 z:5];
    

    CCSpriteBatchNode* touchstart = [CCSprite spriteWithSpriteFrameName:@"start1.png"];
    [touchstart setPosition:ccp(screenSize.width*0.7,screenSize.height*0.68)];
    [self addChild:touchstart z:5];
    CCAnimation *anibackgroup = [CCAnimation animation];
    for(unsigned int i = 1; i <3; i++)
    {
        NSString *naback = [NSString stringWithFormat:@"start%d.png", i];
        [anibackgroup  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
    }
    [anibackgroup setDelayPerUnit:0.3f];
    id actback =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.3f], [CCAnimate  actionWithAnimation:anibackgroup], NULL]];
    [touchstart  runAction:actback];
    
    
    CCSpriteBatchNode* teachsc = [CCSprite spriteWithSpriteFrameName:@"fish-1.png"];
    [teachsc setPosition:ccp(screenSize.width*0.5,screenSize.height*0.33)];
    [self addChild:teachsc z:5];
    CCAnimation *anteach = [CCAnimation animation];
    for(unsigned int i = 1; i <7; i++)
    {
        NSString *naback = [NSString stringWithFormat:@"fish-%d.png", i];
        [anteach  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
    }
    [anteach setDelayPerUnit:0.3f];
    id actteach =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.3f], [CCAnimate  actionWithAnimation:anteach], NULL]];
    [teachsc  runAction:actteach];
    
    //[[CCDirector sharedDirector] replaceScene:[GameScenepie scene]];
}


-(void)goscene2{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"teach_2.plist"];
    CCSprite *backgr = [CCSprite spriteWithSpriteFrameName:@"teachbackground.png"];
    [backgr setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:backgr z:2];
    
    CCSprite *font1 = [CCSprite spriteWithSpriteFrameName:@"balloon.png"];
    [font1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.8)];
    [self addChild:font1 z:5];
    
    
    CCSpriteBatchNode* touchstart = [CCSprite spriteWithSpriteFrameName:@"start1.png"];
    [touchstart setPosition:ccp(screenSize.width*0.7,screenSize.height*0.68)];
    [self addChild:touchstart z:5];
    CCAnimation *anibackgroup = [CCAnimation animation];
    for(unsigned int i = 1; i <3; i++)
    {
        NSString *naback = [NSString stringWithFormat:@"start%d.png", i];
        [anibackgroup  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
    }
    [anibackgroup setDelayPerUnit:0.3f];
    id actback =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.3f], [CCAnimate  actionWithAnimation:anibackgroup], NULL]];
    [touchstart  runAction:actback];
    
    
    CCSpriteBatchNode* teachsc = [CCSprite spriteWithSpriteFrameName:@"balloon-1.png"];
    [teachsc setPosition:ccp(screenSize.width*0.5,screenSize.height*0.33)];
    [self addChild:teachsc z:5];
    CCAnimation *anteach = [CCAnimation animation];
    for(unsigned int i = 1; i <8; i++)
    {
        NSString *naback = [NSString stringWithFormat:@"balloon-%d.png", i];
        [anteach  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
    }
    [anteach setDelayPerUnit:0.3f];
    id actteach =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.3f], [CCAnimate  actionWithAnimation:anteach], NULL]];
    [teachsc  runAction:actteach];
    
    //[[CCDirector sharedDirector] replaceScene:[GameScenepie scene]];
}

-(void)goscene3{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"teach_3.plist"];
    CCSprite *backgr = [CCSprite spriteWithSpriteFrameName:@"teachbackground.png"];
    [backgr setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:backgr z:2];
    
    CCSprite *font1 = [CCSprite spriteWithSpriteFrameName:@"pig.png"];
    [font1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.8)];
    [self addChild:font1 z:5];
    
    
    CCSpriteBatchNode* touchstart = [CCSprite spriteWithSpriteFrameName:@"start1.png"];
    [touchstart setPosition:ccp(screenSize.width*0.7,screenSize.height*0.68)];
    [self addChild:touchstart z:5];
    CCAnimation *anibackgroup = [CCAnimation animation];
    for(unsigned int i = 1; i <3; i++)
    {
        NSString *naback = [NSString stringWithFormat:@"start%d.png", i];
        [anibackgroup  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
    }
    [anibackgroup setDelayPerUnit:0.3f];
    id actback =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.3f], [CCAnimate  actionWithAnimation:anibackgroup], NULL]];
    [touchstart  runAction:actback];
    
    
    CCSpriteBatchNode* teachsc = [CCSprite spriteWithSpriteFrameName:@"pig-1.png"];
    [teachsc setPosition:ccp(screenSize.width*0.5,screenSize.height*0.33)];
    [self addChild:teachsc z:5];
    CCAnimation *anteach = [CCAnimation animation];
    for(unsigned int i = 1; i <8; i++)
    {
        NSString *naback = [NSString stringWithFormat:@"pig-%d.png", i];
        [anteach  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
    }
    [anteach setDelayPerUnit:0.3f];
    id actteach =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.3f], [CCAnimate  actionWithAnimation:anteach], NULL]];
    [teachsc  runAction:actteach];
    
    //[[CCDirector sharedDirector] replaceScene:[GameScenepie scene]];
}

-(void)goscene4{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"teach_4.plist"];
    CCSprite *backgr = [CCSprite spriteWithSpriteFrameName:@"teachbackground.png"];
    [backgr setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:backgr z:2];
    
    CCSprite *font1 = [CCSprite spriteWithSpriteFrameName:@"myzoo.png"];
    [font1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.8)];
    [self addChild:font1 z:5];
    
    
    CCSpriteBatchNode* touchstart = [CCSprite spriteWithSpriteFrameName:@"start1.png"];
    [touchstart setPosition:ccp(screenSize.width*0.7,screenSize.height*0.68)];
    [self addChild:touchstart z:5];
    CCAnimation *anibackgroup = [CCAnimation animation];
    for(unsigned int i = 1; i <3; i++)
    {
        NSString *naback = [NSString stringWithFormat:@"start%d.png", i];
        [anibackgroup  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
    }
    [anibackgroup setDelayPerUnit:0.3f];
    id actback =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.3f], [CCAnimate  actionWithAnimation:anibackgroup], NULL]];
    [touchstart  runAction:actback];
    
    
    CCSpriteBatchNode* teachsc = [CCSprite spriteWithSpriteFrameName:@"myzoo-1.png"];
    [teachsc setPosition:ccp(screenSize.width*0.5,screenSize.height*0.33)];
    [self addChild:teachsc z:5];
    CCAnimation *anteach = [CCAnimation animation];
    for(unsigned int i = 1; i <9; i++)
    {
        NSString *naback = [NSString stringWithFormat:@"myzoo-%d.png", i];
        [anteach  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
    }
    [anteach setDelayPerUnit:0.3f];
    id actteach =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.3f], [CCAnimate  actionWithAnimation:anteach], NULL]];
    [teachsc  runAction:actteach];
    
    //[[CCDirector sharedDirector] replaceScene:[GameScenepie scene]];
}



- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    switch (targetScene_)
	{
		case TargetSceneFirstScene:
        {
            [[CCDirector sharedDirector] replaceScene:[GameScenepie scene]];
			break;
        }
		case TargetScene2Scene:
			[[CCDirector sharedDirector] replaceScene:[GameSceneball scene]];
			break;
        case TargetScene3Scene:
			[[CCDirector sharedDirector] replaceScene:[GameScenerun scene]];
			break;
        case TargetScene4Scene:
			[[CCDirector sharedDirector] replaceScene:[GameScenepad scene]];
			break;
        case TargetSceneHome:
			[[CCDirector sharedDirector] replaceScene:[FirstScene scene]];
			break;
			
		default:
			// Always warn if an unspecified enum value was used. It's a reminder for yourself to update the switch
			// whenever you add more enum values.
			NSAssert2(nil, @"%@: unsupported TargetScene %i", NSStringFromSelector(_cmd), targetScene_);
			break;
	}


    return TRUE;
}


-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
