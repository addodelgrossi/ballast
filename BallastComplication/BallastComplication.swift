import SwiftUI
import WidgetKit

private struct BallastEntry: TimelineEntry {
    let date: Date
}

private struct BallastProvider: TimelineProvider {
    func placeholder(in context: Context) -> BallastEntry {
        BallastEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (BallastEntry) -> Void) {
        completion(BallastEntry(date: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<BallastEntry>) -> Void) {
        completion(Timeline(entries: [BallastEntry(date: Date())], policy: .never))
    }
}

private struct BallastComplicationView: View {
    @Environment(\.widgetFamily) private var family

    var body: some View {
        switch family {
        case .accessoryCircular:
            ZStack {
                AccessoryWidgetBackground()
                ballastMark
                    .font(.title2)
            }
        case .accessoryCorner:
            ballastMark
                .font(.title3)
                .widgetLabel {
                    Text("complication.start")
                }
        case .accessoryInline:
            Label {
                Text("Ballast")
            } icon: {
                Image(systemName: "circle.bottomhalf.filled")
            }
        case .accessoryRectangular:
            HStack(spacing: 8) {
                ballastMark
                    .font(.title2)

                VStack(alignment: .leading, spacing: 1) {
                    Text("Ballast")
                        .font(.headline)
                    Text("complication.start")
                        .font(.caption)
                }
                .lineLimit(1)

                Spacer(minLength: 0)
            }
        default:
            ballastMark
        }
    }

    private var ballastMark: some View {
        Image(systemName: "circle.bottomhalf.filled")
            .widgetAccentable()
            .accessibilityLabel(Text("complication.accessibility.label"))
    }
}

private struct BallastComplication: Widget {
    private let startURL = URL(string: "ballast://start")!

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "BallastComplication", provider: BallastProvider()) { _ in
            BallastComplicationView()
                .containerBackground(for: .widget) {
                    Color.clear
                }
                .widgetURL(startURL)
        }
        .configurationDisplayName(LocalizedStringKey("complication.name"))
        .description(LocalizedStringKey("complication.description"))
        .supportedFamilies([
            .accessoryCircular,
            .accessoryCorner,
            .accessoryInline,
            .accessoryRectangular
        ])
    }
}

@main
struct BallastComplicationBundle: WidgetBundle {
    var body: some Widget {
        BallastComplication()
    }
}

#Preview(as: .accessoryCircular) {
    BallastComplication()
} timeline: {
    BallastEntry(date: .now)
}

#Preview(as: .accessoryRectangular) {
    BallastComplication()
} timeline: {
    BallastEntry(date: .now)
}
