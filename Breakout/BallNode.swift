//
//  BallNode.swift
//  Breakout
//
//  Created by Sean McMains on 9/20/15.
//  Copyright © 2015 McMains. All rights reserved.
//

import SpriteKit

typealias BallNode = SKShapeNode

let ballRadius = CGFloat( 10 )
let newBallOffset = CGFloat( 100 )

let BallCategory: UInt32 = 0x1 << 1

class BallNodeFactory {
    class func startingBall( playfieldSize playfieldSize: CGSize ) -> BallNode {
        let ballNode = BallNode()
        
        let myPath = CGPathCreateMutable();
        CGPathAddArc(myPath, nil, 0,0, ballRadius, 0, CGFloat( M_PI*2 ), true);
        ballNode.path = myPath;
        ballNode.lineWidth = 0.0;
        ballNode.fillColor = SKColor.whiteColor();
        
        ballNode.position = CGPointMake( newBallOffset, playfieldSize.height / 2)

        let body = SKPhysicsBody(circleOfRadius: ballRadius)
        ballNode.physicsBody = body
        body.velocity = CGVectorMake(500, 500)
        body.friction = 0.0
        body.restitution = 1.0
        body.linearDamping = 0.0
        body.categoryBitMask = BallCategory
        body.contactTestBitMask = PaddleCategory

        
        return ballNode
    }
}

