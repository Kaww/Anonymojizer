import SwiftUI

/// V1 - Pick an image, add a default emojis on all faces and export the image
/// V2 - Allow to choose the faces to Anonymojize
/// V3 - Choose from gallery or camera
/// V4 - Choose any emoji or colors

/// TODO:
/// [X] - Pick an image from the gallery
/// [X] - Proceed to V1 face recognition
/// [ ] - Write emojis into te UIImage at the faces position
/// [X] - Ask user permission to access the gallery
/// [X] - Save image to the gallery
/// [ ] - Assemble all

@main
struct AnonymojizerApp: App {
    var body: some Scene {
        WindowGroup {
            let faceDetector = SimpleFaceDetector()
            let anonymizer = Anonymojizer(faceDetector: faceDetector)

            ContentView(
                anonymizer: anonymizer,
                imageProcessor: ImageProcessor(),
                imageSaver: ImageSaver()
            )
        }
    }
}
