//
//  InterfaceController.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 9/25/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import WatchKit
import Foundation

struct Expression {
    let source: SpeechSource
    let speech: String
}

func ==(lhs: Expression?, rhs: Expression?) -> Bool {
    return lhs?.source == rhs?.source && lhs?.speech == rhs?.speech
}

func !=(lhs: Expression?, rhs: Expression?) -> Bool {
    return !(lhs == rhs)
}

enum SpeechSource {
    case narrator, you, them
}

/**
 * Grimm interface controller
 *
 * Is the main controller of Grimm. Handles table manipulation,
 * and interface management
 */
class GrimmInterfaceController: WKInterfaceController {
    
    // Constants
    let actionLimit = 10
    
    // Outlets
    @IBOutlet var eventTable: WKInterfaceTable!
    @IBOutlet var actionTable: WKInterfaceTable!
    
    // External members
    var grimmStory: GrimmStoryController!
    
    // UI Data
    private(set) var eventHistory: [Expression]!
    var actions: [String]! {
        didSet(oldActions) {
            if actions.count > actionLimit {
                actions = oldActions  // revert
            }
            else {
                loadActionTable()
            }
        }
    }
    
    // Functions //
    
    override init() {
        let sampleEvents = [Expression(source: .narrator, speech: "The character walked up to this guy"),
                            Expression(source: .them, speech: "Hi there!"),
                            Expression(source: .you, speech: "Hey! How you doing!"),
                            Expression(source: .them, speech: "Doing great, how bout you?"),
                            Expression(source: .narrator, speech: "The character walked away"),
                            Expression(source: .narrator, speech: "An awkward silence followed...")]
        
        eventHistory = sampleEvents
        actions = ["Throw rock", "Keep Walking", "Stop", "Run"]
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        loadEventTable()
        loadActionTable()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        super.table(table, didSelectRowAt: rowIndex)
        
        if table == actionTable {
//            deliverEvent(withExpression: Expression(source: .narrator,
//                                                    speech: actions[rowIndex]))
            eventTable.scrollToRow(at: eventTable.numberOfRows - 1)
            GrimmStoryController.sharedInstance.notifyActionSelect(of: actions[rowIndex],
                                                                   sender: self)
        }
        
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        if segueIdentifier == "ToItems" {
            return ["Small dagger", "Leather belt", "Pocket lint"]
        }
        
        return nil
    }
    
    func loadEventTable() {
        eventTable.setNumberOfRows(eventHistory.count, withRowType: "Event")
        
        // Populate eventTable
        for (index, event) in eventHistory.enumerated() {
            let row = eventTable.rowController(at: index) as! EventRow
            row.tailorRow(forExpressionOf: event)
        }
    }
    
    func loadActionTable() {
        actionTable.setNumberOfRows(actions.count, withRowType: "Action")
        
        // Populate actionTable
        for (index, action) in actions.enumerated() {
            let row = actionTable.rowController(at: index) as! ActionRow
            row.actionLabel.setText(action)
        }
    }
    
    func deliverEvent(withExpression expr: Expression) {
        eventHistory.append(expr)
        
        eventTable.insertRows(at: [eventTable.numberOfRows], withRowType: "Event")
        let row = eventTable.rowController(at: eventTable.numberOfRows - 1) as! EventRow
        row.tailorRow(forExpressionOf: expr)
    }
    
    func offerAvailActions(_ actions: [String]) {
        self.actions = actions  // observer takes care of the rest
    }
}
