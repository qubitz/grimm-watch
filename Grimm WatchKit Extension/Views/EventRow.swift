//
//  Dialogue.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 9/26/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import WatchKit

/// Table row to display expressions or taken actions.
class EventRow: NSObject {
    
    // Row colors
    
    /// Color to designate dialogue of NPCs only.
    let dialogueColor  = #colorLiteral(red: 0.4745098039, green: 0.3921568627, blue: 0, alpha: 1)
    /// Color to designate dialogue of player only.
    let responseColor  = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
    /// Color to designate taken actions and narrator expression.
    let narrationColor = #colorLiteral(red: 0.092265625, green: 0.092265625, blue: 0.092265625, alpha: 1)
    
    /// Group which holds `speechLabel`.
    ///
    /// Used mainly for artistic purpose such as background color.
    @IBOutlet var group: WKInterfaceGroup!
    
    /// Label to display text of the event.
    @IBOutlet var speechLabel: WKInterfaceLabel!
    
    /// Tailors the row for the expression.
    ///
    /// Based on the expression's `source` the `EventRow` will be altered
    /// to match the approximate format as follows:
    ///
    /// * Narrator: Aligned left with light black background.
    /// * You: Aligned right with an orange background.
    /// * Them: Aligned left with a tan background.
    ///
    /// - Parameter expr: The expression for which to tailor.
    func tailorRow(forExpressionOf expr: Expression) {
        var richSpeech: NSAttributedString
        
        switch expr.source {
        case .narrator:
            richSpeech = getAligned(expr.speech, withAlignment: .left)
            group.setBackgroundColor(narrationColor)
        case .you:
            richSpeech = getAligned(expr.speech, withAlignment: .right)
            group.setBackgroundColor(responseColor)
        case .them:
            richSpeech = getAligned(expr.speech, withAlignment: .left)
            group.setBackgroundColor(dialogueColor)
        }
        
        speechLabel.setAttributedText(richSpeech)
    }
    
    /// Returns a formated text that has the alignment given.
    ///
    /// - Parameters:
    ///   - text: The text to align.
    ///   - alignment: The desired text alignment
    /// - Returns: An NSAttributedString with the content of `text` and
    ///            attribute of an aligned paragraph style.
    private func getAligned(_ text: String, withAlignment alignment: NSTextAlignment) -> NSAttributedString {
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = alignment
        
        let richText = NSAttributedString(string: text,
                                          attributes: [NSAttributedStringKey.paragraphStyle: paraStyle])
        return richText
    }
}
