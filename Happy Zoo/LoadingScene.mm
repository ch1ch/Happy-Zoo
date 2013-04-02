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
		targetScene_ = targetScene;

		CCLabelTTF* label = [CCLabelTTF labelWithString:@"数据读取中 ..." fontName:@"Marker Felt" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position = CGPointMake(size.width / 2, size.height / 2);
		//[self addChild:label];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"opensc1_default.plist"];
        
  
        //公交车
        CCSpriteBatchNode* Spsbus = [CCSprite spriteWithSpriteFrameName:@"opbus1.png"];
        [Spsbus setPosition:ccp(size.width*0.5 ,size.height*0.57)];
        [self addChild:Spsbus z:10];
        CCAnimation *anibus = [CCAnimation animation];
        int num=1;
        for(; num < 9; num++)
        {
            NSString *nabus = [NSString stringWithFormat:@"opbus%d.png", num];
            [anibus  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:nabus]];
        }
        [anibus setDelayPerUnit:0.2f];
        id actbus =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.2f], [CCAnimate  actionWithAnimation:anibus], NULL]];
        [Spsbus  runAction:actbus];
        
        

		
		// Must wait one frame before loading the target scene!
		// Two reasons: first, it would crash if not. Second, the Loading label wouldn't be displayed.
        if (num>=9){
		[self scheduleUpdate];
        }
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
			[[CCDirector sharedDirector] replaceScene:[GameScenepie scene]];
			break;
		case TargetScene2Scene:
			[[CCDirector sharedDirector] replaceScene:[GameSceneball scene]];
			break;
        case TargetScene3Scene:
			[[CCDirector sharedDirector] replaceScene:[GameScenerun scene]];
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

-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
