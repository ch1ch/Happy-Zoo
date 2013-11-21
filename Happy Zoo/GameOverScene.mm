//
//  GameOverScene.m
//  test1
//
//  Created by f on 10/28/12.
//
//

#import "GameOverScene.h"
#import "GameScenepie.h"
#import "FirstScene.h"
#import "LoadingScene.h"


@implementation GameOverScene

+(id) scene
{
    CCScene *scene=[CCScene node];
    CCLayer* layer =[GameOverScene node];
    [scene addChild:layer];
    return scene;
}

- (id)init {
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gameoverthings.plist"];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    if ((self = [super init])) {
        NSLog(@"~huanle~~gamelevel~~%d",game1level);
       
        
        if (gamescene==1) {
            if (game1level==0) gamesprite=[CCSprite spriteWithSpriteFrameName:@"game-end1.png"];
            if (game1level==1) gamesprite=[CCSprite spriteWithSpriteFrameName:@"game-end2.png"];
            if (game1level==2) gamesprite=[CCSprite spriteWithSpriteFrameName:@"game-end3.png"];
            if (game1level==3) gamesprite=[CCSprite spriteWithSpriteFrameName:@"game-end4.png"];
        }

        [gamesprite setPosition:ccp(screenSize.width*0.5,screenSize.height*0.5)];
        [self addChild:gamesprite z:4 tag:501];


        
        NSString *temppst=[NSString stringWithFormat:@"game~   ~%d~  win  ~%d~",gamescene,game1level];
        label1 = [CCLabelTTF labelWithString:temppst fontName:@"Arial" fontSize:32];
        label1.color = ccc3(255,0,0);
        label1.position = ccp(screenSize.width/2, screenSize.height/2);
        //[self addChild:label1];
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];

     
    }
    return self;
   
}

- (void)dealloc {
    

    [super dealloc];
    
    
}
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
   // CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
       [self gohome];
    
    return TRUE;
}

-(void) gohome{
   // [[CCDirector sharedDirector] resume];
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetSceneHome];
    [[CCDirector sharedDirector] replaceScene:newScene];
    
}

@end
