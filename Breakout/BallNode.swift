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
let newBallOffset = CGFloat( 20 )

class BallNodeFactory {
    class func startingBall( playfieldSize playfieldSize: CGSize ) -> BallNode {
        let ballNode = BallNode()
        
        let myPath = CGPathCreateMutable();
        CGPathAddArc(myPath, nil, 0,0, ballRadius, 0, CGFloat( M_PI*2 ), true);
        ballNode.path = myPath;
        ballNode.lineWidth = 0.0;
        ballNode.fillColor = SKColor.whiteColor();
        
        ballNode.position = CGPointMake( newBallOffset, playfieldSize.height / 2)

        ballNode.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        ballNode.physicsBody?.velocity = CGVectorMake(500, 500)
        ballNode.physicsBody?.friction = 0.0
        ballNode.physicsBody?.restitution = 1.0
        ballNode.physicsBody?.linearDamping = 0.0
        
        return ballNode
    }
}

