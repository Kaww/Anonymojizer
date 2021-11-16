import SwiftUI

/// V1 - Pick an image, add a default emojis on all faces and export the image
/// V2 - Allow to choose the faces to Anonymojize
/// V3 - Choose from gallery or camera
/// V4 - Choose any emoji or colors

/// TODO:
/// [ ] - Ask user permission to access the gallery
/// [X] - Pick an image from the gallery
/// [ ] - Proceed to V1 face recognition
/// [ ] - Save image to the gallery

@main
struct AnonymojizerApp: App {
    var body: some Scene {
        WindowGroup {
            let faceDetector = SimpleFaceDetector()
            let anonymizer = Anonymojizer(faceDetector: faceDetector)

            ContentView(anonymizer: anonymizer)
        }
    }
}
