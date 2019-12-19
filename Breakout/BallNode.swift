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
    class func startingBall( playfieldSize: CGSize ) -> BallNode {
        let ballNode = BallNode()
        
        let myPath = CGMutablePath();
        myPath.addArc(tangent1End: CGPoint(x: 0, y: 0), tangent2End: CGPoint(x: 0, y: CGFloat( .pi * 2.0 )), radius: ballRadius)
        ballNode.path = myPath;
        ballNode.lineWidth = 0.0;
        ballNode.fillColor = SKColor.white;
        
        ballNode.position = CGPoint( x: newBallOffset, y: playfieldSize.height / 2)

        let body = SKPhysicsBody(circleOfRadius: ballRadius)
        ballNode.physicsBody = body
        body.velocity = CGVector(dx: 500, dy: 500)
        body.friction = 0.0
        body.restitution = 1.0
        body.linearDamping = 0.0
        body.categoryBitMask = BallCategory
        body.contactTestBitMask = PaddleCategory

        
        return ballNode
    }
}

