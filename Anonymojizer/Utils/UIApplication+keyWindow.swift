import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive } // Keep only active scenes, onscreen and visible to the user
            .first(where: { $0 is UIWindowScene }) // Keep only the first `UIWindowScene`
            .flatMap({ $0 as? UIWindowScene })?.windows // Get its associated windows
            .first(where: \.isKeyWindow) // Finally, keep only the key window
    }
}
