import SwiftUI

struct ExerciseStepView: View {
    let session: ExerciseSession
    let step: GroundingStep
    let remaining: Int
    let accent: Color

    @State private var crownPosition = 0.0
    @FocusState private var crownFocused: Bool
    @ScaledMetric(relativeTo: .title2) private var senseSize = 24.0
    @ScaledMetric(relativeTo: .largeTitle) private var countSize = 94.0

    var body: some View {
        Button {
            session.registerItems(source: .tap)
        } label: {
            VStack(spacing: 0) {
                Text(LocalizedStringKey(step.localizationKey))
                    .font(.system(size: senseSize, weight: .medium, design: .rounded))
                    .tracking(2.2)
                    .foregroundStyle(accent)
                    .minimumScaleFactor(0.55)
                    .lineLimit(1)
                    .allowsTightening(true)

                Text(remaining, format: .number)
                    .font(.system(size: countSize, weight: .light, design: .rounded))
                    .monospacedDigit()
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, 6)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .focusable()
        .focused($crownFocused)
        .digitalCrownRotation(
            $crownPosition,
            from: -1_000,
            through: 1_000,
            by: 1,
            sensitivity: .low,
            isContinuous: false,
            isHapticFeedbackEnabled: true
        )
        .onAppear {
            crownFocused = true
        }
        .onChange(of: crownPosition) { oldValue, newValue in
            let ticks = CrownTickCounter.ticks(from: oldValue, to: newValue)
            guard ticks > 0 else { return }
            session.registerItems(ticks, source: .crown)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint(Text("step.accessibility.hint"))
        .accessibilityAddTraits(.isButton)
    }

    private var accessibilityLabel: Text {
        let sense = NSLocalizedString(step.localizationKey, comment: "Current grounding sense")
        let key = remaining == 1
            ? "step.accessibility.label.one"
            : "step.accessibility.label"
        let format = NSLocalizedString(
            key,
            comment: "Sense and number of items remaining"
        )
        return Text(String(format: format, sense, Int64(remaining)))
    }
}

#Preview("Active — 45mm") {
    let session = ExerciseSession()
    session.start()
    return BallastRootView(session: session)
}
