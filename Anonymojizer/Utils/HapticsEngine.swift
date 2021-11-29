import SwiftUI
import CoreHaptics

class HapticsEngine: ObservableObject {

    private let notificationFeedbackGenerator: UINotificationFeedbackGenerator
    private let selectionFeedbackGenerator: UISelectionFeedbackGenerator

    init() {
        notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    }

    func notify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        notificationFeedbackGenerator.notificationOccurred(feedbackType)
    }

    func tap() {
        selectionFeedbackGenerator.selectionChanged()
    }
}
