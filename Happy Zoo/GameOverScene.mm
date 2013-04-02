//
//  GameOverScene.m
//  test1
//
//  Created by f on 10/28/12.
//
//

#import "GameOverScene.h"
#import "GameScenepie.h"

@implementation GameOverScene
@synthesize layer = _layer;

- (id)init {
    
    
    if ((self = [super init])) {
        
        self.layer = [GameOverLayer node];
        [self addChild:_layer];
     
    }
    return self;
   
}

- (void)dealloc {
    
    [_layer release];
    _layer = nil;
    [super dealloc];
    
    
}

@end

@implementation GameOverLayer
@synthesize label = _label;

-(id) init {
    
    if( (self=[super init] )) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self.label = [CCLabelTTF labelWithString:@"win" fontName:@"Arial" fontSize:32];
        _label.color = ccc3(255,0,0);
        _label.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:_label];
        
        [self runAction:[CCSequence actions:
                         [CCDelayTime actionWithDuration:3],
                         [CCCallFunc actionWithTarget:self selector:@selector(gameOverDone)],
                         nil]];
        
        
        
    }
    return self;
    
    
}



- (void)dealloc {
    
    [_label release];
    _label = nil;
    [super dealloc]; 
    
    
}

@end