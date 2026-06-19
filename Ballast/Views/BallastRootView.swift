import SwiftUI

struct BallastRootView: View {
    let session: ExerciseSession

    var body: some View {
        ZStack {
            BallastBackdrop(accent: accent, motif: motif)

            switch session.phase {
            case .idle:
                StartView(accent: accent, action: session.start)
            case let .active(stepIndex, remaining):
                ExerciseStepView(
                    session: session,
                    step: session.steps[stepIndex],
                    remaining: remaining,
                    accent: accent
                )
            case .complete:
                CompletionView(accent: accent, action: session.done)
            }
        }
        .foregroundStyle(Color.ballastForeground)
        .tint(accent)
    }

    private var accent: Color {
        switch session.phase {
        case .idle:
            BallastTheme.startAccent
        case let .active(stepIndex, _):
            BallastTheme.accent(forStep: stepIndex)
        case .complete:
            BallastTheme.completionAccent
        }
    }

    private var motif: BallastMotif {
        switch session.phase {
        case .idle:
            .ballast
        case let .active(stepIndex, _):
            BallastMotif(stepIndex: stepIndex)
        case .complete:
            .complete
        }
    }
}

private struct BallastBackdrop: View {
    let accent: Color
    let motif: BallastMotif

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.ballastBackground

                RadialGradient(
                    colors: [
                        accent.opacity(0.22),
                        accent.opacity(0.07),
                        .clear
                    ],
                    center: UnitPoint(x: 0.5, y: 0.3),
                    startRadius: 0,
                    endRadius: max(proxy.size.width, proxy.size.height) * 0.86
                )

                SensoryMotifView(motif: motif, accent: accent)

                LinearGradient(
                    colors: [.clear, Color.black.opacity(0.32)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
        }
        .ignoresSafeArea()
    }
}

#Preview("Start — 45mm") {
    BallastRootView(session: ExerciseSession())
}
