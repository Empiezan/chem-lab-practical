//
//  LiquidFun.h
//  chem-lab-practical
//
//  Created by labuser on 6/29/18.
//  Copyright © 2018 cse438. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifndef LiquidFun_Definitions
#define LiquidFun_Definitions

typedef struct Size2D {
    float width;
    float height;
} Size2D;

typedef struct Vector2D {
    float x;
    float y;
} Vector2D;

#endif
@interface LiquidFun : NSObject
+ (void)createWorldWithGravity:(Vector2D)gravity;
+ (void *)createParticleSystemWithRadius:(float)radius dampingStrength:(float)dampingStrength
                            gravityScale:(float)gravityScale density:(float)density;
+ (void)createParticleBoxForSystem:(void *)particleSystem
                          position:(Vector2D)position size:(Size2D)size;
+ (int)particleCountForSystem:(void *)particleSystem;
+ (void *)particlePositionsForSystem:(void *)particleSystem;
@end
