import SwiftUI

extension Color {
    static let ballastBackground = Color(
        red: 5 / 255,
        green: 8 / 255,
        blue: 12 / 255
    )

    static let ballastForeground = Color(
        red: 244 / 255,
        green: 247 / 255,
        blue: 245 / 255
    )

    static let ballastAccent = Color(
        red: 131 / 255,
        green: 220 / 255,
        blue: 197 / 255
    )

    static let ballastSurface = Color(
        red: 16 / 255,
        green: 23 / 255,
        blue: 29 / 255
    )
}

enum BallastTheme {
    static let startAccent = Color.ballastAccent
    static let completionAccent = Color(
        red: 150 / 255,
        green: 217 / 255,
        blue: 184 / 255
    )

    static func accent(forStep index: Int) -> Color {
        switch index {
        case 0:
            Color(red: 141 / 255, green: 197 / 255, blue: 255 / 255)
        case 1:
            Color(red: 125 / 255, green: 216 / 255, blue: 196 / 255)
        case 2:
            Color(red: 199 / 255, green: 173 / 255, blue: 255 / 255)
        case 3:
            Color(red: 239 / 255, green: 195 / 255, blue: 141 / 255)
        default:
            Color(red: 240 / 255, green: 161 / 255, blue: 175 / 255)
        }
    }
}
