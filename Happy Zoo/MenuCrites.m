//
//  MenuCrites.m
//  Happy Zoo
//
//  Created by f on 4/28/13.
//
//

#import "MenuCrites.h"
#import "FirstScene.h"
#import "LoadingScene.h"

@implementation MenuCrites

+(id) scene
{
    CCScene *scene=[CCScene node];
    CCLayer* layer =[MenuCrites node];
    [scene addChild:layer];
    return scene;
}

- (id)init {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    if ((self = [super init])) {
        CCSprite *maincrites = [CCSprite spriteWithFile:@"crites-main.png"];
        maincrites.position = CGPointMake(screenSize.width*0.5, screenSize.height*0.5 );
       	[self addChild:maincrites z:11];
        
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        CCMenuItemImage *menum11 = [CCMenuItemImage itemFromNormalImage:@"gaming-list5.png" selectedImage:@"gaming-list5-1.png" disabledImage:@"gaming-list5.png" target:self selector:@selector(gomenu)];
        CCMenu *menu11 = [CCMenu menuWithItems: menum11, nil];
        menu11.position = CGPointMake(screenSize.width*0.9, screenSize.height*0.9);
        [self addChild: menu11 z:30];
    
    }
    return self;
    
}
-(void) gomenu{
    [[CCDirector sharedDirector] resume];
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetSceneHome];
    [[CCDirector sharedDirector] replaceScene:newScene];
    
}

- (void)dealloc {
    
    
    [super dealloc];
    
    
}
@end
