import Foundation

/// Container for holding information about every "speech bubble" that
/// appears in the expression history. Each `Expression` is taliored for
/// the source/speaker of the expression.
///
/// - Important: Based on the `source` the expression will be
///              displayed differently. For example, if the source is
///              `narrator` the expression bubble will be black and on the
///              left side of the screen.
struct Expression: Codable {
    
    /// Enumeration of all possbile sources of an expression.
    ///
    /// - narrator: The narrator of Grimm.
    /// - you: The player's replies and comments.
    /// - them: NPC's replies and comments.
    enum SpeechSource: String, Codable {
        case narrator, you, them
    }
    
    /// The source of the expression. Who or what is talking.
    let source: SpeechSource
    
    /// The content of the expression. What is being stated in the expression.
    let speech: String
}
