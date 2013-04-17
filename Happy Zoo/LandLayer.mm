//
//  LandLayer.m
//  Happy Zoo
//
//  Created by f on 4/11/13.
//
//

#import "LandLayer.h"
#import "LoadingScene.h"
#import "GB2ShapeCache.h"

#define PTM_RATIO 32.0

@implementation LandLayer


-(id)init
{
    if ((self =[super init]))
    {
        
        
        // ListLayerPosition= self.position;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        self.anchorPoint = ccp(screenSize.width*0.5 ,screenSize.height*0.5);
        
        
        
        allland = [[NSMutableArray alloc] init];
        
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"pig-run.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pig_land_car.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pig_land_car2.plist"];
        
        
        [self setupPhysicsWorld];
        
        
        
        
        // Create edges around the entire screen
        b2BodyDef groundBodyDef;
        groundBodyDef.position.Set(0,0);
        b2Body *groundBody = _world->CreateBody(&groundBodyDef);
        b2EdgeShape groundBox;
        
        
        //bottom
        groundBox.Set(b2Vec2(0,screenSize.height*(-1)/PTM_RATIO), b2Vec2(screenSize.width*15/PTM_RATIO,screenSize.height*(-1)/PTM_RATIO));
        groundBody->CreateFixture(&groundBox,0);
        
        // top
        groundBox.Set(b2Vec2(0,screenSize.height*2/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,screenSize.height*2/PTM_RATIO));
        groundBody->CreateFixture(&groundBox,0);
        
        // left
        groundBox.Set(b2Vec2(0,screenSize.height*2/PTM_RATIO), b2Vec2(0,screenSize.height*(-1)/PTM_RATIO));
        groundBody->CreateFixture(&groundBox,0);
        
   
        [self drawpig];
        [self drawland1];
        [self drawland2];
        [self drawland6];
        [self drawland7];
        [self drawland10];
        [self drawland4];
        [self drawland3];
        [self drawland8_1];
        [self drawland8_2];
        [self drawland6_2];
        [self drawland5];
        [self drawland9];
        [self drawland3_2];
        [self drawland11];[self drawland12];[self drawland13];
        [self drawland6_3];
        [self drawland14];
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
 
        

    }

    
    
    
    // Create contact listener
    _contactListener =new MyContactListener();
    _world->SetContactListener(_contactListener);
    
    
        //[self schedule:@selector(update:) interval:0.1f];
    
    [self schedule:@selector(tick:)interval:0.1f];
    [self schedule:@selector(GameOver:) interval:0.1f];
      
    
    return self;

    }






-(void) setupPhysicsWorld {
    
    
    b2Vec2 gravity = b2Vec2(0.0f, -9.0f);
    _world = new b2World(gravity);
    
    /*
    _debugDraw = new GLESDebugDraw(PTM_RATIO);
    _world->SetDebugDraw(_debugDraw);
    uint32 flags = 0;
    flags += b2Draw::   e_shapeBit;
    _debugDraw->SetFlags(flags);
    */
    
    _contactListener =new MyContactListener();
    _world->SetContactListener(_contactListener);
}


- (void)tick:(ccTime) dt {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    _world->Step(dt, 8, 3);
    for(b2Body *b = _world->GetBodyList(); b; b=b->GetNext()) {
        if (b->GetUserData() != NULL) {
            CCSprite *ballData = (CCSprite *)b->GetUserData();
            
            if (ballData.tag!=109) {
                
            
            
                if (ballData.tag ==101) {

                
                    ballData.position =CGPointMake(b->GetPosition().x*PTM_RATIO, b->GetPosition().y*PTM_RATIO);
                    
                }else{
                    ballData.position = ccp(b->GetPosition().x * PTM_RATIO,
                                        b->GetPosition().y * PTM_RATIO);
                }
                ballData.rotation =-1* CC_RADIANS_TO_DEGREES(b->GetAngle());
            }else{
                b->SetTransform(b2Vec2(land9.position.x/PTM_RATIO,land9.position.y/PTM_RATIO), 0);
            }

        }
        
    }
    
    
    if (oldpigpostion.x==0) {
        oldpigpostion.x=pig.position.x;
        oldpigpostion.y=pig.position.y;
        firsttime=1;
    }
    
    newpigpostion.x=pig.position.x;
    newpigpostion.y=pig.position.y;
    
   // NSLog(@"self pos x=%f,y=%f.",self.position.x,self.position.y);
    
    b2Vec2 lineve;
    //lineve=[];
    
    CGPoint newpos1;
    
    if (self.position.x<screenSize.width*(-0.5)) {
        newpos1 = ccp(self.position.x-newpigpostion.x+oldpigpostion.x,755);
    }else{
        newpos1 = ccp(self.position.x-newpigpostion.x+oldpigpostion.x+5, self.position.y-newpigpostion.y+oldpigpostion.y-5);

    }
          
    oldpigpostion=newpigpostion;
    
    
    if (pigjump==0) {
       [self setPosition:newpos1]; 
    }
    
    if (pos9.y==0) {
        pos9=land9.position;
    }
    
    if (self.position.x<screenSize.width*(-9.2)) {
        [self runobsMoveSequencey:land9];
    }
  
}


-(void)GameOver:(ccTime) dt {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
   // NSLog(@"self pos x=%f,y=%f.",self.position.x,self.position.y);
    if (self.position.x<screenSize.width*(-14.7)) {
              NSLog(@" you win!");
        [self drawgameover];
        

    }
  
}

-(void)drawgameover{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];

    label1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You Win! "] fontName:@"Marker Felt" fontSize:64];
    label1.position =  ccp(screenSize.width*15.3 ,screenSize.height*(-0.5) );
    [label1 setString:[NSString stringWithFormat:@"Game Win!"]];
    [self addChild: label1];
    [[CCDirector sharedDirector] pause];
}





-(void) draw
{
    glDisable(GL_TEXTURE_2D);
    
    
    _world->DrawDebugData();
    
    glEnable(GL_TEXTURE_2D);
    
}




- (void)drawpig {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    //pig = [CCSprite spriteWithSpriteFrameName:@"pigrun-car01.png"];
    pig =[Player1 spriteWithSpriteFrameName:@"pigrun-car01.png"];
    [pig setPosition:ccp(screenSize.width*0.02,screenSize.height*0.67)];
    [self addChild:pig z:15 tag:100];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(pig.position.x/PTM_RATIO, pig.position.y/PTM_RATIO);
    bodyDef.userData = pig;
    b2Body *body = _world->CreateBody(&bodyDef);
    pig.body = body;
    
    NSString *name = @"pigrun-car01";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [pig setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
    CCAnimation *ananmail1 = [CCAnimation animation];
    for(unsigned int i = 1; i < 8; i++)
    {
        NSString *naanmal1 = [NSString stringWithFormat:@"pigrun-car0%d.png", i];
        [ananmail1  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naanmal1]];
    }
    
    [ananmail1 setDelayPerUnit:0.3f];
    id actanmal1 =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:ananmail1], NULL]];
    [pig  runAction:actanmal1];
    
    
    
}




- (void)drawland1 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land1 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land01.png"];
    [land1 setPosition:ccp(screenSize.width*(-0.1) ,screenSize.height*(-1.0))];
    [self addChild:land1 z:10 tag:101];
   
 
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land1.position.x/PTM_RATIO, land1.position.y/PTM_RATIO);
    bodyDef.userData = land1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land01";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
 
}



- (void)drawland2 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land2 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land02.png"];
    [land2 setPosition:ccp(screenSize.width*1.78,screenSize.height*(-1.0))];
    [self addChild:land2 z:10 tag:102];

    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land2.position.x/PTM_RATIO, land2.position.y/PTM_RATIO);
    bodyDef.userData = land2;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land02";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land2 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}

- (void)drawland6 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land6 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land06.png"];
    [land6 setPosition:ccp(screenSize.width*2.95,screenSize.height*(-1.09))];
    [self addChild:land6 z:10 tag:106];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land6.position.x/PTM_RATIO, land6.position.y/PTM_RATIO);
    bodyDef.userData = land6;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land06";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land6 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}


- (void)drawland7 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land7 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land07.png"];
    [land7 setPosition:ccp(screenSize.width*4.1,screenSize.height*(-1.02))];
    [self addChild:land7 z:10 tag:107];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land7.position.x/PTM_RATIO, land7.position.y/PTM_RATIO);
    bodyDef.userData = land7;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land07";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land7 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}

- (void)drawland10 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land10 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land10.png"];
    [land10 setPosition:ccp(screenSize.width*4.96,screenSize.height*(-1.00))];
    [self addChild:land10 z:9 tag:110];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land10.position.x/PTM_RATIO, land10.position.y/PTM_RATIO);
    bodyDef.userData = land10;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land10";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land10 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}

- (void)drawland4 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land4 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land04.png"];
    [land4 setPosition:ccp(screenSize.width*5.5,screenSize.height*(-1.04))];
    [self addChild:land4 z:10 tag:104];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land4.position.x/PTM_RATIO, land4.position.y/PTM_RATIO);
    bodyDef.userData = land4;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land04";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land4 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}

- (void)drawland3 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land3 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land03.png"];
    [land3 setPosition:ccp(screenSize.width*6.65,screenSize.height*(-1.22))];
    [self addChild:land3 z:10 tag:103];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land3.position.x/PTM_RATIO, land3.position.y/PTM_RATIO);
    bodyDef.userData = land3;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land03";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land3 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}

- (void)drawland8_1 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land8_1 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land08.png"];
    [land8_1 setPosition:ccp(screenSize.width*7.75,screenSize.height*(-0.77))];
    [self addChild:land8_1 z:10 tag:108];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land8_1.position.x/PTM_RATIO, land8_1.position.y/PTM_RATIO);
    bodyDef.userData = land8_1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land08";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land8_1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawland8_2 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land8_2 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land08.png"];
    [land8_2 setPosition:ccp(screenSize.width*7.96,screenSize.height*(-0.67))];
    [self addChild:land8_2 z:10 tag:108];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land8_2.position.x/PTM_RATIO, land8_2.position.y/PTM_RATIO);
    bodyDef.userData = land8_2;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land08";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land8_2 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawland6_2 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land6_2 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land06.png"];
    [land6_2 setPosition:ccp(screenSize.width*8.09,screenSize.height*(-1.1))];
    [self addChild:land6_2 z:10 tag:106];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land6_2.position.x/PTM_RATIO, land6_2.position.y/PTM_RATIO);
    bodyDef.userData = land6_2;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land06";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land6_2 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}


- (void)drawland5 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land5 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land05.png"];
    [land5 setPosition:ccp(screenSize.width*9.2,screenSize.height*(-1.1))];
    [self addChild:land5 z:10 tag:105];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land5.position.x/PTM_RATIO, land5.position.y/PTM_RATIO);
    bodyDef.userData = land5;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land05";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land5 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}


- (void)drawland9 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land9 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land15.png"];
    //[land9 setPosition:ccp(screenSize.width*1.78,screenSize.height*(-0.6))];
    land9.position = CGPointMake(screenSize.width*10.5,screenSize.height*(-1.05));
    [self addChild:land9 z:10 tag:109];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land9.position.x/PTM_RATIO, land9.position.y/PTM_RATIO);
    bodyDef.userData = land9;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land15";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land9 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}

- (void)drawland3_2 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land3_2 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land03.png"];
    [land3_2 setPosition:ccp(screenSize.width*11.2,screenSize.height*(-1.0))];
    [self addChild:land3_2 z:10 tag:103];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land3_2.position.x/PTM_RATIO, land3_2.position.y/PTM_RATIO);
    bodyDef.userData = land3_2;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land03";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land3_2 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}

- (void)drawland11 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land11 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land11.png"];
    
    land11.position = CGPointMake(screenSize.width*12.3,screenSize.height*(-1.1));
    [self addChild:land11 z:10 tag:111];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land11.position.x/PTM_RATIO, land11.position.y/PTM_RATIO);
    bodyDef.userData = land11;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land11";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land11 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}

- (void)drawland12 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land12 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land12.png"];
    
    land12.position = CGPointMake(screenSize.width*12.6,screenSize.height*(-1.1));
    [self addChild:land12 z:10 tag:112];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land12.position.x/PTM_RATIO, land12.position.y/PTM_RATIO);
    bodyDef.userData = land12;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land12";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land12 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}

- (void)drawland13 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land13 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land13.png"];
    
    land13.position = CGPointMake(screenSize.width*12.9,screenSize.height*(-1.1));
    [self addChild:land13 z:10 tag:113];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land13.position.x/PTM_RATIO, land13.position.y/PTM_RATIO);
    bodyDef.userData = land13;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land13";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land13 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}



- (void)drawland6_3 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land6_3 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land06.png"];
    [land6_3 setPosition:ccp(screenSize.width*13.3,screenSize.height*(-1.05))];
    [self addChild:land6_3 z:10 tag:106];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land6_3.position.x/PTM_RATIO, land6_3.position.y/PTM_RATIO);
    bodyDef.userData = land6_3;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land06";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land6_3 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}




- (void)drawland14 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    land14 = [CCSprite spriteWithSpriteFrameName:@"pigrun-land14.png"];
    
    land14.position = CGPointMake(screenSize.width*14.4,screenSize.height*(-1.0));
    [self addChild:land14 z:10 tag:113];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(land14.position.x/PTM_RATIO, land14.position.y/PTM_RATIO);
    bodyDef.userData = land14;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"pigrun-land14";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [land14 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    
}

- (void)selectSpriteForTouch:(CGPoint)touchLocation
{
    
    if (CGRectContainsPoint(pig.boundingBox, touchLocation))
    {
        pigjump=1;
        [pig jump];
        NSLog(@"jump~~~~~~~~~~");
        //pig.body->SetLinearVelocity(b2Vec2(0,0));
        pigjump=0;
        
    }
    
    
}



- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];
    //[pig jump];
    return TRUE;
}

-(void) runobsMoveSequencex:(CCSprite*)spider
{
    
	CGPoint belowScreenPosition = CGPointMake(spider.position.x-30,spider.position.y);
    //CCLOG(@" --- %d ---- %f -----", belowScreenPosition.x,belowScreenPosition.y);
	CCMoveTo* move = [CCMoveTo actionWithDuration:0.1f position:belowScreenPosition];
    
	CCSequence* sequence = [CCSequence actions:move,nil];
	[spider runAction:sequence];
    
    
    
}

-(void) runobsMoveSequencey:(CCSprite*)spider
{
    
	CGPoint belowScreenPosition = CGPointMake(spider.position.x,spider.position.y+10);
    
    
    //CCLOG(@" --- %f ---- %f -----", belowScreenPosition.x,belowScreenPosition.y);
	CCMoveTo* move = [CCMoveTo actionWithDuration:0.1f position:belowScreenPosition];
    
	CCSequence* sequence = [CCSequence actions:move,nil];
	[spider runAction:sequence];
    
    
    
}
-(void) gampause{
    [[CCDirector sharedDirector] pause];
}


-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
