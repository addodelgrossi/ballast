import Foundation

enum HapticKind: Equatable, Sendable {
    case start
    case click
    case success
}

struct HapticEvent: Equatable, Sendable {
    let kind: HapticKind
    let delayBeforeNanoseconds: UInt64
}

enum HapticPattern {
    static let markerGap: UInt64 = 220_000_000
    static let pulseGap: UInt64 = 160_000_000

    static func introduction(itemCount: Int) -> [HapticEvent] {
        guard itemCount > 0 else { return [] }

        return [HapticEvent(kind: .start, delayBeforeNanoseconds: 0)]
            + (0..<itemCount).map { index in
                HapticEvent(
                    kind: .click,
                    delayBeforeNanoseconds: index == 0 ? markerGap : pulseGap
                )
            }
    }

    static let completion = [
        HapticEvent(kind: .success, delayBeforeNanoseconds: 0)
    ]
}
