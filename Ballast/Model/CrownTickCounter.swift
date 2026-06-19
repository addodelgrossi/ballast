import Foundation

enum CrownTickCounter {
    static func ticks(from oldValue: Double, to newValue: Double) -> Int {
        Int(abs(newValue - oldValue).rounded(.down))
    }
}
