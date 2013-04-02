//
//  FirstScene.m
//  ScenesAndLayers
//

#import "FirstScene.h"
#import "GameScenepie.h"
#import "LoadingScene.h"
#import "GameOverScene.h"
#import "GameSceneball.h"
#import "FirstsceList.h"
#import "GameScenerun.h"






@implementation FirstScene

static FirstScene* multiLayerSceneInstance;
+(FirstScene*) sharedLayer
{
	NSAssert(multiLayerSceneInstance != nil, @"MultiLayerScene not available!");
	return multiLayerSceneInstance;
}


-(ListLayer*) listLayer
{
	CCNode* layer = [self getChildByTag:LayerTagGameLayer1];
	//NSAssert([layer isKindOfClass:[FirstsceList class]], @"%@: not a GameLayer!", NSStringFromSelector(_cmd));
	return (ListLayer*)layer;
}

+(id) scene
{
	CCLOG(@"===========================================");
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	CCScene* scene = [CCScene node];
	FirstScene* layer = [FirstScene node];
	[scene addChild:layer];
	return scene;
}

-(id) init
{
	if ((self = [super init]))
	{
        
        //NSAssert(multiLayerSceneInstance == nil, @"another MultiLayerScene is already in use!");
		multiLayerSceneInstance = self;
        

        CGSize size = [[CCDirector sharedDirector] winSize];
        //[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
          [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
        
        backgroundsky = [CCSprite spriteWithFile:@"mainBackground-sky.png"];
        backgroundsky.position = CGPointMake(size.width*0.5, size.height*0.5 );
       	[self addChild:backgroundsky z:6];
        
        background = [CCSprite spriteWithFile:@"mainBackground3.png"];
        background.position = CGPointMake(size.width*0.5, size.height*0.5 );
       	[self addChild:background z:11];
        

        
        
             
        mainFlower = [CCSprite spriteWithFile:@"mainflower1.png"];
        mainFlower.position = CGPointMake(size.width*0.5, size.height*0.5 );
       	[self addChild:mainFlower z:15];
        
        mainSound = [CCSprite spriteWithFile:@"mainmusic-on.png"];
        mainSound.position = CGPointMake(size.width*0.5, size.height*0.5 );
       	[self addChild:mainSound z:15];
        
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"maincloud.plist"];
        CCSpriteBatchNode* Spsbackgroup = [CCSprite spriteWithSpriteFrameName:@"cloud1.png"];
        [Spsbackgroup setPosition:ccp(size.width*0.5 ,size.height*0.5)];
        [self addChild:Spsbackgroup z:7];
        CCAnimation *anibackgroup = [CCAnimation animation];
        for(unsigned int i = 1; i <3; i++)
        {
            NSString *naback = [NSString stringWithFormat:@"cloud%d.png", i];
            [anibackgroup  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
        }
        [anibackgroup setDelayPerUnit:1.0f];
        id actback =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:anibackgroup], NULL]];
        [Spsbackgroup  runAction:actback];
        
        
        
        
        
        
        mainCenter = [CCSprite spriteWithFile:@"maingamecenter.png"];
        mainCenter.position = CGPointMake(size.width*0.5, size.height*0.5 );
       	[self addChild:mainCenter z:11];
        
        mainHome = [CCSprite spriteWithFile:@"mainhome.png"];
        mainHome.position = CGPointMake(size.width*0.5, size.height*0.5 );
       	[self addChild:mainHome z:11];
        
        mainQuestion = [CCSprite spriteWithFile:@"mainquestion.png"];
        mainQuestion.position = CGPointMake(size.width*0.5, size.height*0.5 );
       	[self addChild:mainQuestion z:15];
        
        
        mainarrleft = [CCSprite spriteWithFile:@"mainarrowleft.png"];
        mainarrleft.position = CGPointMake(size.width*0.07, size.height*0.45 );
       	[self addChild:mainarrleft z:15];
        
        mainarrright = [CCSprite spriteWithFile:@"mainarrowright.png"];
        mainarrright.position = CGPointMake(size.width*0.93, size.height*0.45 );
       	[self addChild:mainarrright z:15];
        
        // [label1 setString:[NSString stringWithFormat:@"%d  and  %d",spriteA.tag,spriteB.tag]];

        CCLabelTTF *label1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d /15      0 / 5",gamestarscore] fontName:@"DayDream" fontSize:67];
        label1.position =  ccp(size.width*0.8, size.height*0.92);
        [self addChild: label1 z:20];
        

        CCLayer *layerlist=[FirstsceList node];
        [self addChild:layerlist z:8 tag:LayerTagGameLayer1];

   
        
		CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
  
		
		[GameScenepie simulateLongLoadingTime];
                		
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];

	}
	return self;
}




- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    CCRotateBy* rotate = [CCRotateBy actionWithDuration:1 angle:-45];
    CCRotateBy* rotate1 = [CCRotateBy actionWithDuration:1 angle:45];

    ListLayer* listlayer = [FirstScene sharedLayer].listLayer;
    
    if (CGRectContainsPoint(mainarrleft.boundingBox, touchLocation))
    {
       
       [listlayer runAction:rotate];

    }else if (CGRectContainsPoint(mainarrright.boundingBox, touchLocation))
    {
        [listlayer runAction:rotate1];

    }
    
  
}



- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];
    return TRUE;
}



- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -background.contentSize.width+winSize.width);
    retval.y = self.position.y;
    return retval;
}

- (void)panForTranslation:(CGPoint)translation {

        CGPoint newPos = ccpAdd(self.position, translation);
        self.position = [self boundLayerPos:newPos];

}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
     CGSize size = [[CCDirector sharedDirector] winSize];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    [self panForTranslation:translation];
    CCLOG(@"%@: %@  --%f  --->%f", NSStringFromSelector(_cmd), self,touchLocation.x,oldTouchLocation.x);
    
        CCRotateBy* rotateright1 = [CCRotateBy actionWithDuration:0.8f angle:-45];
        CCRotateBy* rotateleft1 = [CCRotateBy actionWithDuration:0.8f angle:45];
    CCRotateBy* rotateright2 = [CCRotateBy actionWithDuration:0.8f angle:-90];
    CCRotateBy* rotateleft2 = [CCRotateBy actionWithDuration:0.8f angle:90];
        
    
        ListLayer* listlayer = [FirstScene sharedLayer].listLayer;
    
    //屏幕的一半一下，触屏滑动
    if (oldTouchLocation.y<size.height*0.6) {
 
        
        if (touchLocation.x<oldTouchLocation.x)
        {
            if ((oldTouchLocation.x-touchLocation.x)<70)
            {
            [listlayer runAction:rotateright1];
            }else
            {
                [listlayer runAction:rotateright2];

            }
        }
        
        else if (touchLocation.x>oldTouchLocation.x)
        {
            
            if ((touchLocation.x-oldTouchLocation.x)<70)
            {
                [listlayer runAction:rotateleft1];
            }else
            {
                [listlayer runAction:rotateleft2];
                
            }

        }
    }
    
       


}





-(void) onEnter
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);

	// must call super here:
	[super onEnter];
}

-(void) onEnterTransitionDidFinish
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);

	// must call super here:
	[super onEnterTransitionDidFinish];
}

-(void) onExit
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// must call super here:
	[super onExit];
}

//去游戏一
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
