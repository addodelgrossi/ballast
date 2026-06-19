import XCTest
@testable import Ballast

final class HapticPatternTests: XCTestCase {
    func testIntroductionsEncodeItemCountAsClicks() {
        for itemCount in 1...5 {
            let events = HapticPattern.introduction(itemCount: itemCount)

            XCTAssertEqual(events.first?.kind, .start)
            XCTAssertEqual(events.filter { $0.kind == .click }.count, itemCount)
            XCTAssertEqual(events.count, itemCount + 1)
        }
    }

    func testIntroductionTimingUsesMarkerAndPulseGaps() {
        let events = HapticPattern.introduction(itemCount: 3)

        XCTAssertEqual(events.map(\.delayBeforeNanoseconds), [0, 220_000_000, 160_000_000, 160_000_000])
    }

    func testCompletionIsOneSuccessHaptic() {
        XCTAssertEqual(HapticPattern.completion, [HapticEvent(kind: .success, delayBeforeNanoseconds: 0)])
    }
}
