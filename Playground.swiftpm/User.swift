import SwiftData
import Foundation

@Model
final class User {
    init() {
        createdAt = .now
    }
    
    var createdAt: Date
    var enabled: Bool = true
}
