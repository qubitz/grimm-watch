//
//  InterfaceController.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 9/25/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import WatchKit
import Foundation

struct Expression: Codable {
    enum SpeechSource: String, Codable {
        case narrator, you, them
    }
    
    let source: SpeechSource
    let speech: String
}

protocol GrimmActionDelegate {
    func onAction(_ selection: Action, sender: GrimmInterfaceController)
    func onViewItems(sender: GrimmInterfaceController)
    func onGameStart(sender: GrimmInterfaceController)
    func onItemView(controllerName: String, sender: GrimmInterfaceController)
}

protocol Identifiable {
    static var identity: String { get set }
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
    @IBAction func onItemPress() {
        delegate?.onItemView(controllerName: "ItemInterfaceController", sender: self)
    }
    
    // UI Data
    private(set) var eventHistory: [Expression]!  // only get allowed publicly
    
    var actions: [Action]! {  // observer does the work
        didSet(oldActions) {
            if actions.count > actionLimit {
                actions = oldActions  // revert
            }
            else {
                loadActionTable()
            }
        }
    }
    
    // Variables
    var delegate: GrimmActionDelegate?
    
    // Functions //////////////
    
    override init() {
        super.init()
        
        // Start blank
        eventHistory = []
        actions = []
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        delegate = PlayerController()
        loadEventTable()
        loadActionTable()
        delegate?.onGameStart(sender: self)
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        super.table(table, didSelectRowAt: rowIndex)
        
        if table === actionTable {
            delegate?.onAction(actions[rowIndex], sender: self)
            eventTable.scrollToRow(at: eventTable.numberOfRows - 1)
        }
    }
    
    override func interfaceOffsetDidScrollToTop() {
        // Do event loading here
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
            row.actionLabel.setText(action.name)
        }
    }
    
    func deliverEvent(_ speech: String, from source: Expression.SpeechSource) {
        let newEvent = Expression(source: source, speech: speech)
        eventHistory.append(newEvent)
        
        eventTable.insertRows(at: [eventTable.numberOfRows], withRowType: "Event")
        let row = eventTable.rowController(at: eventTable.numberOfRows - 1) as! EventRow
        row.tailorRow(forExpressionOf: newEvent)
    }
    
    func offerAvail(actions: [Action]) {
        self.actions = actions  // observer takes care of the rest
    }
}
