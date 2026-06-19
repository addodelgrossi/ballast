import XCTest
@testable import Ballast

@MainActor
final class ExerciseSessionTests: XCTestCase {
    func testStartBeginsFirstStepAndPlaysFivePulseIntroduction() {
        let haptics = HapticSpy()
        let session = ExerciseSession(haptics: haptics)

        session.start()

        XCTAssertEqual(session.phase, .active(stepIndex: 0, remaining: 5))
        XCTAssertEqual(haptics.actions, [.introduction(5)])
    }

    func testTapCountsOneItemAndPlaysFallbackTick() {
        let haptics = HapticSpy()
        let session = ExerciseSession(haptics: haptics)
        session.start()

        session.registerItems(source: .tap)

        XCTAssertEqual(session.phase, .active(stepIndex: 0, remaining: 4))
        XCTAssertEqual(haptics.actions, [.introduction(5), .tick])
    }

    func testCrownTicksCountInEitherDirectionWithoutDuplicateHaptic() {
        let haptics = HapticSpy()
        let session = ExerciseSession(haptics: haptics)
        session.start()

        session.registerItems(2, source: .crown)

        XCTAssertEqual(session.phase, .active(stepIndex: 0, remaining: 3))
        XCTAssertEqual(haptics.actions, [.introduction(5)])
    }

    func testCrownDeltaCountsBothDirectionsAndRapidMovement() {
        XCTAssertEqual(CrownTickCounter.ticks(from: 0, to: 1), 1)
        XCTAssertEqual(CrownTickCounter.ticks(from: 0, to: -1), 1)
        XCTAssertEqual(CrownTickCounter.ticks(from: 4, to: 1), 3)
        XCTAssertEqual(CrownTickCounter.ticks(from: -2, to: 2), 4)
    }

    func testReachingZeroAdvancesAutomatically() {
        let haptics = HapticSpy()
        let session = ExerciseSession(haptics: haptics)
        session.start()

        session.registerItems(5, source: .crown)

        XCTAssertEqual(session.phase, .active(stepIndex: 1, remaining: 4))
        XCTAssertEqual(haptics.actions, [.introduction(5), .introduction(4)])
    }

    func testCompleteExerciseNeverUnderflows() {
        let haptics = HapticSpy()
        let session = ExerciseSession(haptics: haptics)
        session.start()

        session.registerItems(100, source: .crown)

        XCTAssertEqual(session.phase, .complete)
        XCTAssertEqual(
            haptics.actions,
            [.introduction(5), .introduction(4), .introduction(3), .introduction(2), .introduction(1), .completion]
        )
    }

    func testComplicationStyleRestartResetsAnActiveSession() {
        let haptics = HapticSpy()
        let session = ExerciseSession(haptics: haptics)
        session.start()
        session.registerItems(3, source: .crown)

        session.start()

        XCTAssertEqual(session.phase, .active(stepIndex: 0, remaining: 5))
        XCTAssertEqual(haptics.actions.last, .introduction(5))
    }

    func testStateRemainsUntilExplicitlyFinished() {
        let session = ExerciseSession(haptics: HapticSpy())
        session.start()
        session.registerItems(1, source: .crown)

        XCTAssertEqual(session.phase, .active(stepIndex: 0, remaining: 4))

        session.done()
        XCTAssertEqual(session.phase, .idle)
    }
}

@MainActor
private final class HapticSpy: HapticPlaying {
    enum Action: Equatable {
        case introduction(Int)
        case tick
        case completion
        case cancel
    }

    private(set) var actions: [Action] = []

    func playIntroduction(itemCount: Int) {
        actions.append(.introduction(itemCount))
    }

    func playTick() {
        actions.append(.tick)
    }

    func playCompletion() {
        actions.append(.completion)
    }

    func cancel() {
        actions.append(.cancel)
    }
}
