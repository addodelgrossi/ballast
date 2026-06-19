import SwiftUI

struct StartView: View {
    let accent: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: "circle.bottomhalf.filled")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(accent)
                    .accessibilityHidden(true)

                Text("start.title")
                    .font(.system(.title3, design: .rounded, weight: .medium))
            }
            .frame(maxWidth: .infinity, minHeight: 96)
        }
        .buttonStyle(BallastPrimaryButtonStyle(accent: accent, cornerRadius: 30))
        .padding(.horizontal, 18)
        .accessibilityHint(Text("start.accessibility.hint"))
    }
}

struct BallastPrimaryButtonStyle: ButtonStyle {
    let accent: Color
    var cornerRadius = 24.0

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.ballastForeground.opacity(configuration.isPressed ? 0.72 : 1))
            .background {
                let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)

                shape
                    .fill(.ultraThinMaterial)

                shape
                    .fill(Color.ballastSurface.opacity(configuration.isPressed ? 0.76 : 0.58))

                shape
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                accent.opacity(configuration.isPressed ? 0.4 : 0.76),
                                Color.white.opacity(0.08)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            }
            .shadow(color: accent.opacity(0.16), radius: 14, y: 6)
    }
}
