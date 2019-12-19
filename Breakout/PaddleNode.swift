//
//  PaddleNode.swift
//  Breakout
//
//  Created by Sean McMains on 9/20/15.
//  Copyright © 2015 McMains. All rights reserved.
//

import SpriteKit

typealias PaddleNode = SKSpriteNode

let PaddleCategory: UInt32 = 0x1 << 0

extension PaddleNode {
    var orientation: Orientation {
        if ( self.size.height == horizontalPaddleSize.height ) {
            return .horizontal
        } else {
            return .vertical
        }
    }
}

let verticalPaddleSize = CGSize(width: 10, height: 150)
let horizontalPaddleSize = CGSize(width: verticalPaddleSize.height, height: verticalPaddleSize.width)

class PaddleNodeFactory {
    class func paddleNodes(playfieldSize: CGSize ) -> [PaddleNode] {
        let paddle1Position = CGPoint(x: verticalPaddleSize.width / 2 + horizontalOverscanMargin, y: playfieldSize.height / 2)
        let paddle1 = self.paddleNode(color: SKColor.red, position: paddle1Position, orientation: .vertical, playfieldSize: playfieldSize)
        
        let paddle2Position = CGPoint(x: playfieldSize.width - verticalPaddleSize.width / 2 - horizontalOverscanMargin, y: playfieldSize.height / 2)
        let paddle2 = self.paddleNode(color: SKColor.green, position: paddle2Position, orientation: .vertical, playfieldSize: playfieldSize)
        
        let paddle3Position = CGPoint(x: playfieldSize.width / 2, y: horizontalPaddleSize.height / 2 + verticalOverscanMargin)
        let paddle3 = self.paddleNode(color: SKColor.yellow, position: paddle3Position, orientation: .horizontal, playfieldSize: playfieldSize)
        
        let paddle4Position = CGPoint(x: playfieldSize.width / 2, y: playfieldSize.height - horizontalPaddleSize.height / 2 - verticalOverscanMargin)
        let paddle4 = self.paddleNode(color: SKColor.blue, position: paddle4Position, orientation: .horizontal, playfieldSize: playfieldSize)
        
        return [paddle1, paddle2, paddle3, paddle4]
    }
    
    class func paddleNode( color: SKColor, position: CGPoint, orientation: Orientation, playfieldSize: CGSize) -> PaddleNode {
        let size: CGSize
        var constraints: Array<SKConstraint> = []
        switch orientation {
        case .horizontal:
            size = horizontalPaddleSize
            let xRange = SKRange(lowerLimit: horizontalPaddleSize.width / 2 + horizontalOverscanMargin, upperLimit: playfieldSize.width - verticalPaddleSize.width / 2 - horizontalOverscanMargin)
            constraints = [SKConstraint.positionX( xRange )]
        case .vertical:
            size = verticalPaddleSize
            let yRange = SKRange(lowerLimit: verticalPaddleSize.height / 2 + verticalOverscanMargin, upperLimit: playfieldSize.height - verticalPaddleSize.height / 2 - verticalOverscanMargin)
            constraints = [SKConstraint.positionY( yRange )]
        }
        
        let paddleNode = PaddleNode(color: color, size: size)
        paddleNode.position = position
        
        let body = SKPhysicsBody(rectangleOf: paddleNode.size)
        body.isDynamic = false
        body.restitution = 1.0
        body.categoryBitMask = PaddleCategory
        body.contactTestBitMask = BallCategory
        paddleNode.physicsBody = body

        paddleNode.constraints = constraints
        
        return paddleNode
    }
}
