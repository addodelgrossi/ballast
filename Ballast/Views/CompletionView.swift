import SwiftUI

struct CompletionView: View {
    let accent: Color
    let action: () -> Void

    var body: some View {
        VStack(spacing: 18) {
            Text("completion.message")
                .font(.system(.title2, design: .rounded, weight: .medium))
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.75)
                .lineLimit(2)

            Button(action: action) {
                Text("done.title")
                    .font(.system(.headline, design: .rounded, weight: .medium))
                    .frame(maxWidth: .infinity, minHeight: 52)
            }
            .buttonStyle(BallastPrimaryButtonStyle(accent: accent, cornerRadius: 20))
            .accessibilityHint(Text("done.accessibility.hint"))
        }
        .padding(.horizontal, 18)
    }
}
