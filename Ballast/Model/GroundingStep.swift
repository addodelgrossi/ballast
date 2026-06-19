import Foundation

struct GroundingStep: Equatable, Identifiable, Sendable {
    let id: String
    let localizationKey: String
    let itemCount: Int

    static let grounding: [GroundingStep] = [
        GroundingStep(id: "see", localizationKey: "sense.see", itemCount: 5),
        GroundingStep(id: "hear", localizationKey: "sense.hear", itemCount: 4),
        GroundingStep(id: "feel", localizationKey: "sense.feel", itemCount: 3),
        GroundingStep(id: "smell", localizationKey: "sense.smell", itemCount: 2),
        GroundingStep(id: "taste", localizationKey: "sense.taste", itemCount: 1)
    ]
}
