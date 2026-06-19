import SwiftUI

enum BallastMotif {
    case ballast
    case sight
    case sound
    case touch
    case smell
    case taste
    case complete

    init(stepIndex: Int) {
        switch stepIndex {
        case 0: self = .sight
        case 1: self = .sound
        case 2: self = .touch
        case 3: self = .smell
        default: self = .taste
        }
    }
}

struct SensoryMotifView: View {
    let motif: BallastMotif
    let accent: Color

    var body: some View {
        Canvas { context, size in
            switch motif {
            case .ballast:
                drawBallast(in: &context, size: size)
            case .sight:
                drawSight(in: &context, size: size)
            case .sound:
                drawSound(in: &context, size: size)
            case .touch:
                drawTouch(in: &context, size: size)
            case .smell:
                drawSmell(in: &context, size: size)
            case .taste:
                drawTaste(in: &context, size: size)
            case .complete:
                drawComplete(in: &context, size: size)
            }
        }
        .blendMode(.screen)
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }

    private var fineStroke: GraphicsContext.Shading {
        .color(accent.opacity(0.11))
    }

    private var softFill: GraphicsContext.Shading {
        .color(accent.opacity(0.045))
    }

    private func drawBallast(in context: inout GraphicsContext, size: CGSize) {
        let diameter = min(size.width, size.height) * 0.96
        let rect = CGRect(
            x: (size.width - diameter) / 2,
            y: size.height * 0.3,
            width: diameter,
            height: diameter
        )

        context.stroke(Path(ellipseIn: rect), with: fineStroke, lineWidth: 1.2)

        var horizon = Path()
        horizon.move(to: CGPoint(x: rect.minX, y: rect.midY))
        horizon.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        context.stroke(horizon, with: .color(accent.opacity(0.09)), lineWidth: 1)

        let lowerHalf = CGRect(x: rect.minX, y: rect.midY, width: rect.width, height: rect.height / 2)
        context.fill(Path(ellipseIn: lowerHalf), with: softFill)
    }

    private func drawSight(in context: inout GraphicsContext, size: CGSize) {
        let center = CGPoint(x: size.width * 0.5, y: size.height * 0.48)

        for radius in [40.0, 72.0, 108.0, 146.0] {
            let rect = CGRect(
                x: center.x - radius,
                y: center.y - radius * 0.62,
                width: radius * 2,
                height: radius * 1.24
            )
            context.stroke(Path(ellipseIn: rect), with: fineStroke, lineWidth: 1.1)
        }

        let iris = CGRect(x: center.x - 23, y: center.y - 23, width: 46, height: 46)
        context.fill(Path(ellipseIn: iris), with: softFill)
    }

    private func drawSound(in context: inout GraphicsContext, size: CGSize) {
        let center = CGPoint(x: size.width * 0.08, y: size.height * 0.53)

        for radius in [38.0, 70.0, 104.0, 140.0, 178.0] {
            let rect = CGRect(
                x: center.x - radius,
                y: center.y - radius,
                width: radius * 2,
                height: radius * 2
            )
            context.stroke(Path(ellipseIn: rect), with: fineStroke, lineWidth: 1.2)
        }
    }

    private func drawTouch(in context: inout GraphicsContext, size: CGSize) {
        let center = CGPoint(x: size.width * 0.58, y: size.height * 0.5)

        for ring in 0..<7 {
            let radiusX = 24.0 + Double(ring) * 15
            let radiusY = 34.0 + Double(ring) * 18
            var path = Path()

            for pointIndex in 0...80 {
                let angle = Double(pointIndex) / 80 * Double.pi * 2
                let ripple = sin(angle * 3 + Double(ring) * 0.65) * 2.2
                let point = CGPoint(
                    x: center.x + cos(angle) * (radiusX + ripple),
                    y: center.y + sin(angle) * (radiusY + ripple)
                )

                if pointIndex == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }

            path.closeSubpath()
            context.stroke(path, with: fineStroke, lineWidth: 1)
        }
    }

    private func drawSmell(in context: inout GraphicsContext, size: CGSize) {
        for index in 0..<4 {
            let offset = Double(index) * 43
            var path = Path()
            path.move(to: CGPoint(x: -24 + offset, y: size.height * 1.06))
            path.addCurve(
                to: CGPoint(x: 42 + offset, y: size.height * 0.58),
                control1: CGPoint(x: 54 + offset, y: size.height * 0.9),
                control2: CGPoint(x: -16 + offset, y: size.height * 0.72)
            )
            path.addCurve(
                to: CGPoint(x: 5 + offset, y: size.height * 0.1),
                control1: CGPoint(x: 98 + offset, y: size.height * 0.42),
                control2: CGPoint(x: -42 + offset, y: size.height * 0.26)
            )
            context.stroke(path, with: fineStroke, lineWidth: 1.3)
        }
    }

    private func drawTaste(in context: inout GraphicsContext, size: CGSize) {
        let centerX = size.width * 0.5
        let dropCenterY = size.height * 0.3
        var drop = Path()
        drop.move(to: CGPoint(x: centerX, y: dropCenterY - 58))
        drop.addCurve(
            to: CGPoint(x: centerX, y: dropCenterY + 38),
            control1: CGPoint(x: centerX - 54, y: dropCenterY - 2),
            control2: CGPoint(x: centerX - 34, y: dropCenterY + 38)
        )
        drop.addCurve(
            to: CGPoint(x: centerX, y: dropCenterY - 58),
            control1: CGPoint(x: centerX + 34, y: dropCenterY + 38),
            control2: CGPoint(x: centerX + 54, y: dropCenterY - 2)
        )
        context.fill(drop, with: softFill)
        context.stroke(drop, with: fineStroke, lineWidth: 1.2)

        for width in [74.0, 132.0, 194.0] {
            let rect = CGRect(
                x: centerX - width / 2,
                y: size.height * 0.68 - width * 0.13,
                width: width,
                height: width * 0.26
            )
            context.stroke(Path(ellipseIn: rect), with: fineStroke, lineWidth: 1.1)
        }
    }

    private func drawComplete(in context: inout GraphicsContext, size: CGSize) {
        let center = CGPoint(x: size.width * 0.5, y: size.height * 0.48)

        for radius in [62.0, 100.0, 142.0] {
            let rect = CGRect(
                x: center.x - radius,
                y: center.y - radius,
                width: radius * 2,
                height: radius * 2
            )
            context.stroke(Path(ellipseIn: rect), with: fineStroke, lineWidth: 1.1)
        }
    }
}
