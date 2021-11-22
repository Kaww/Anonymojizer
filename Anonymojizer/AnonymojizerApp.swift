import SwiftUI

/// V1 - Pick an image, add a default emojis on all faces and export the image
/// V2 - Allow to choose the faces to Anonymojize
/// V3 - Choose from gallery or camera
/// V4 - Choose any emoji or colors
/// V5 - Use face's roll, yaw and pitch to make the emoji match the face orientation

/// TODO V1:
/// [X] - Pick an image from the gallery
/// [X] - Proceed to V1 face recognition
/// [X] - Write emojis into te UIImage at the faces position
/// [X] - Save image to the gallery
/// [X] - Assemble all
/// [X] -  Ask user permission to write in the gallery
/// [ ] - Ask user permission to read in the gallery
/// [ ] - Process in a background thread

@main
struct AnonymojizerApp: App {
    var body: some Scene {
        WindowGroup {
            let faceDetector = FaceDetector()
            let anonymizer = Anonymizer(faceDetector: faceDetector)
            let imageSaver = ImageSaver()

            ContentView(
                anonymizer: anonymizer,
                imageSaver: imageSaver
            )
        }
    }
}
