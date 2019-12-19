//
//  WallNode.swift
//  Breakout
//
//  Created by Sean McMains on 9/20/15.
//  Copyright © 2015 McMains. All rights reserved.
//

import SpriteKit

typealias WallNode = SKSpriteNode

class WallNodeFactory {
    class func wallNodes(playfieldSize: CGSize ) -> [WallNode] {
        let horizontalWallSize = CGSize(width: playfieldSize.width - horizontalOverscanMargin * 2.0, height: 10)
        let verticalWallSize = CGSize(width: 10, height: playfieldSize.height - verticalOverscanMargin * 2.0)
        
        let wall1Position = CGPoint(x: verticalWallSize.width / 2 + horizontalOverscanMargin, y: playfieldSize.height / 2)
        let wall1 = self.wallNode(position: wall1Position, size: verticalWallSize)
        
        let wall2Position = CGPoint(x: playfieldSize.width - verticalWallSize.width / 2 - horizontalOverscanMargin, y: playfieldSize.height / 2)
        let wall2 = self.wallNode(position: wall2Position, size: verticalWallSize)
        
        let wall3Position = CGPoint(x: playfieldSize.width / 2, y: horizontalWallSize.height / 2 + verticalOverscanMargin)
        let wall3 = self.wallNode(position: wall3Position, size: horizontalWallSize)
        
        let wall4Position = CGPoint(x: playfieldSize.width / 2, y: playfieldSize.height - horizontalWallSize.height / 2 - verticalOverscanMargin)
        let wall4 = self.wallNode(position: wall4Position, size: horizontalWallSize)
        
        return [wall1, wall2, wall3, wall4]
    }
    
    class func wallNode( position: CGPoint, size: CGSize ) -> WallNode {
        let wallNode = WallNode(color: SKColor.white, size: size)
        wallNode.position = position
        
        wallNode.physicsBody = SKPhysicsBody(rectangleOf: wallNode.size)
        wallNode.physicsBody?.isDynamic = false
        wallNode.physicsBody?.restitution = 1.0
        
        return wallNode
    }

}

