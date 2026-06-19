import WatchKit

@MainActor
protocol HapticPlaying: AnyObject {
    func playIntroduction(itemCount: Int)
    func playTick()
    func playCompletion()
    func cancel()
}

@MainActor
final class WatchHapticPlayer: HapticPlaying {
    private var sequenceTask: Task<Void, Never>?

    func playIntroduction(itemCount: Int) {
        play(events: HapticPattern.introduction(itemCount: itemCount))
    }

    func playTick() {
        WKInterfaceDevice.current().play(.click)
    }

    func playCompletion() {
        play(events: HapticPattern.completion)
    }

    func cancel() {
        sequenceTask?.cancel()
        sequenceTask = nil
    }

    private func play(events: [HapticEvent]) {
        cancel()
        sequenceTask = Task { @MainActor in
            for event in events {
                if event.delayBeforeNanoseconds > 0 {
                    try? await Task.sleep(nanoseconds: event.delayBeforeNanoseconds)
                }

                guard !Task.isCancelled else { return }
                WKInterfaceDevice.current().play(event.kind.watchKitType)
            }
        }
    }
}

private extension HapticKind {
    var watchKitType: WKHapticType {
        switch self {
        case .start: .start
        case .click: .click
        case .success: .success
        }
    }
}
