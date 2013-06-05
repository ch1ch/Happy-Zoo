//
//  FirstScene.m
//  ScenesAndLayers
//

#import "FirstScene.h"
#import "GameScenepie.h"
#import "LoadingScene.h"
#import "GameSceneball.h"
#import "FirstsceList.h"
#import "GameScenerun.h"
#import "MenuCrites.h"
#import "OpeningStart.h"

@implementation FirstScene

int gamestarscore;
int game1thing;
int game2thing;
int game3thing;
int game4thing;
int game1level;
int game2level;
int game3level;
int game4level;
int gamescene;

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
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"list.mp3" loop:YES];
        
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

             
        //mainFlower = [CCSprite spriteWithFile:@"flower1.png"];
       // mainFlower.position = CGPointMake(size.width*0.5, size.height*0.5 );
       	//[self addChild:mainFlower z:15];
        
        mainFlower2 = [CCSprite spriteWithFile:@"flower2.png"];
        mainFlower2.position = CGPointMake(size.width*0.2, size.height*0.63 );
       	[self addChild:mainFlower2 z:15];
        
        mainFlower3 = [CCSprite spriteWithFile:@"flower3.png"];
        mainFlower3.position = CGPointMake(size.width*0.87, size.height*0.5 );
       	[self addChild:mainFlower3 z:15];
        
        mainSound = [CCSprite spriteWithFile:@"music-on.png"];
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
        
     
        mainCenter = [CCSprite spriteWithFile:@"gamecenter.png"];
        mainCenter.position = CGPointMake(size.width*0.5, size.height*0.5 );
       	[self addChild:mainCenter z:11];
        
        mainHome = [CCSprite spriteWithFile:@"home.png"];
        mainHome.position = CGPointMake(size.width*0.5, size.height*0.5 );
       	[self addChild:mainHome z:11];

        
        mainCrites = [CCSprite spriteWithFile:@"credits.png"];
        mainCrites.position = CGPointMake(size.width*0.96, size.height*0.49 );
       	[self addChild:mainCrites z:15];
        
        
        mainarrleft = [CCSprite spriteWithFile:@"mainarrowleft.png"];
        mainarrleft.position = CGPointMake(size.width*0.07, size.height*0.45 );
       	[self addChild:mainarrleft z:15];
        
        mainarrright = [CCSprite spriteWithFile:@"mainarrowright.png"];
        mainarrright.position = CGPointMake(size.width*0.96, size.height*0.35 );
       	[self addChild:mainarrright z:15];
        
        // [label1 setString:[NSString stringWithFormat:@"%d  and  %d",spriteA.tag,spriteB.tag]];
        int sc=game1level+game2level+game3level;
        int thing=(game1thing+game2thing+game3thing+game4thing);
        CCLabelTTF *label1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d /9       %d / 4",sc,thing/2] fontName:@"DayDream" fontSize:67];
        label1.position =  ccp(size.width*0.78, size.height*0.93);
        [self addChild: label1 z:20];
        

        CCLayer *layerlist=[FirstsceList node];
        [self addChild:layerlist z:8 tag:LayerTagGameLayer1];

   
        
		CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
  
		
		[GameScenepie simulateLongLoadingTime];
                		
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
         [self schedule:@selector(update:) interval:0.1f];

	}
    
	return self;
}

-(void) update:(ccTime)delta{
    if (isTouchflower2) {
        CGPoint tempos=mainFlower2.position;
        tempos.y=tempos.y-10;
        mainFlower2.position=tempos;
    }
    if (isTouchflower3) {
        CGPoint tempos=mainFlower3.position;
        tempos.y=tempos.y-10;
        mainFlower3.position=tempos;
    }
}

+(int)retulevel1{
    return game1level;
}


- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    
    if (CGRectContainsPoint(mainCrites.boundingBox, touchLocation))
    {
          [[SimpleAudioEngine sharedEngine]playEffect:@"map.wav" ];
        CCTransitionFade *tranScene=[CCTransitionFade transitionWithDuration:1 scene:[MenuCrites scene]];
        [[CCDirector sharedDirector] replaceScene:tranScene];
    }
    
    /*
    if (CGRectContainsPoint(mainHome.boundingBox, touchLocation))
    {

        CCTransitionFade *tranScene=[CCTransitionFade transitionWithDuration:1 scene:[MenuCrites scene]];
      //  [[CCDirector sharedDirector] replaceScene:[OpeningStart sence]];
        [[CCDirector sharedDirector] replaceScene:[OpeningStart scene]];
    }
     */
    
    
    if (CGRectContainsPoint(mainFlower2.boundingBox, touchLocation))
    {
        isTouchflower2=YES;
    }
    if (CGRectContainsPoint(mainFlower3.boundingBox, touchLocation))
    {
        isTouchflower3=YES;
    }

    
    
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



-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

    

@end
