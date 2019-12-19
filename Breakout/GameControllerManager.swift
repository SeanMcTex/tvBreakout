//
//  GameControllerManager.swift
//  Breakout
//
//  Created by Sean Mc Mains on 10/11/15.
//  Copyright © 2015 McMains. All rights reserved.
//

import Foundation
import GameController

let trackingMultiplier = Float( 15.0 )

class GameControllerManager {
    func activeControllers() -> Int {
        return GCController.controllers().count
    }
    
    func controllerXY( player: Int ) -> ( x: Float, y: Float ) {
        var x: Float = 0.0
        var y: Float = 0.0
        
        if let controller = self.controllerFor( player: player ) {
            if let extendedGamePad = controller.extendedGamepad {
                x = extendedGamePad.leftThumbstick.xAxis.value
                y = extendedGamePad.leftThumbstick.yAxis.value
            } else if let microGamepad = controller.microGamepad {
                x = microGamepad.dpad.xAxis.value
                y = microGamepad.dpad.yAxis.value
            } else if let gamePad = controller.gamepad {
                x = gamePad.dpad.xAxis.value
                y = gamePad.dpad.yAxis.value
            }
            
        }
        return (  x: x * trackingMultiplier, y: y * trackingMultiplier )
    }
    
    func buttonPressed( player: Int ) -> Bool {
        if let controller = self.controllerFor( player: player ) {
            return (controller.microGamepad?.buttonA.isPressed)!
        }
        return false
    }
    
    func controllerFor( player: Int ) -> GCController? {
        let controllers = GCController.controllers()
        if ( controllers.count > player ) {
            let controller = controllers[player]
            setPlayerIndex(controller: controller, player: player)
            return controller
        }
        return nil
    }
    
    func setPlayerIndex( controller: GCController, player: Int ) {
        switch player {
        case 0:
            controller.playerIndex = .index1
        case 1:
            controller.playerIndex = .index2
        case 2:
            controller.playerIndex = .index3
        case 3:
            controller.playerIndex = .index4
        default:
            controller.playerIndex = .indexUnset
        }
    }
}
