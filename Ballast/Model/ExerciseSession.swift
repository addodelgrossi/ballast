import Observation

@MainActor
@Observable
final class ExerciseSession {
    enum Phase: Equatable {
        case idle
        case active(stepIndex: Int, remaining: Int)
        case complete
    }

    enum InputSource {
        case crown
        case tap
    }

    private(set) var phase: Phase = .idle
    let steps: [GroundingStep]

    @ObservationIgnored
    private let haptics: any HapticPlaying

    init(
        steps: [GroundingStep] = GroundingStep.grounding,
        haptics: any HapticPlaying = WatchHapticPlayer()
    ) {
        precondition(!steps.isEmpty, "An exercise needs at least one step.")
        precondition(steps.allSatisfy { $0.itemCount > 0 }, "Every step needs a positive item count.")
        self.steps = steps
        self.haptics = haptics
    }

    var currentStep: GroundingStep? {
        guard case let .active(stepIndex, _) = phase else { return nil }
        return steps[stepIndex]
    }

    var remaining: Int? {
        guard case let .active(_, remaining) = phase else { return nil }
        return remaining
    }

    func start() {
        let firstStep = steps[0]
        phase = .active(stepIndex: 0, remaining: firstStep.itemCount)
        haptics.playIntroduction(itemCount: firstStep.itemCount)
    }

    func registerItems(_ count: Int = 1, source: InputSource) {
        guard count > 0 else { return }

        for _ in 0..<count {
            guard case .active = phase else { break }
            registerOneItem(source: source)
        }
    }

    func done() {
        haptics.cancel()
        phase = .idle
    }

    private func registerOneItem(source: InputSource) {
        guard case let .active(stepIndex, remaining) = phase else { return }

        if source == .tap {
            haptics.playTick()
        }

        let nextRemaining = remaining - 1
        if nextRemaining > 0 {
            phase = .active(stepIndex: stepIndex, remaining: nextRemaining)
            return
        }

        let nextStepIndex = stepIndex + 1
        guard steps.indices.contains(nextStepIndex) else {
            phase = .complete
            haptics.playCompletion()
            return
        }

        let nextStep = steps[nextStepIndex]
        phase = .active(stepIndex: nextStepIndex, remaining: nextStep.itemCount)
        haptics.playIntroduction(itemCount: nextStep.itemCount)
    }
}
