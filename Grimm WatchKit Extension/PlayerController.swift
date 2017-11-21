//
//  PlayerController.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/29/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation
import WatchKit

class PlayerController: GrimmActionDelegate {
    let player = MapHandler.shared.player
    let map = MapHandler.shared.map
    
    func onAction(_ selection: Action, sender: GrimmInterfaceController) {
        switch selection {
        case is Movement:
            handle(movement: selection as! Movement)
            
            sender.deliverEvent(selection.completedName, from: .narrator)
            sender.deliverEvent(player.area.description, from: .narrator)
            sender.actions = getAvailActions()
        default:
            break
        }
    }
    
    func onViewItems(sender: GrimmInterfaceController) {
        
    }
    
    func onGameStart(sender: GrimmInterfaceController) {
        sender.deliverEvent("Let me tell you the story of the child named Aedan...",
                            from: .narrator)
        sender.deliverEvent(player.area.description, from: .narrator)
        sender.actions = getAvailActions()
    }
    
    func onItemView(controllerName: String, sender: GrimmInterfaceController) {
        sender.pushController(withName: controllerName, context: (playerItems: player.inventory,
                                                                  groundItems: player.area.inventory))
    }
    
    func handle(movement: Movement) {
        if let dir = movement.direction {
            player.move(in: dir)
        }
        if let place = movement.destination {
            player.move(to: place)
        }
    }
    
    func getAvailActions() -> [Action] {
        var availActions = [Action]()
        
        // Movement actions
        for route in player.area.routes {
            availActions.append(Movement(in: route))
        }
        
        return availActions
    }
}
