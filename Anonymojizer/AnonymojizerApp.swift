import SwiftUI

/// TODO V1:
/// [X] - Pick an image from the gallery
/// [X] - Proceed to V1 face recognition
/// [X] - Write emojis into te UIImage at the faces position
/// [X] - Save image to the gallery
/// [X] - Assemble all
/// [X] - Ask user permission to write in the gallery
/// [X] - Ask user permission to read in the gallery
/// [X] - Process in a background thread
/// [X] - UI
/// [X] - Adapt UI to rotation + rotation animation
/// [ ] - Export sharesheet
/// [ ] - Emoji picker
///
/// TODO V2:
/// [ ] - Better flow when cancelling an image during a processing
/// [ ] - Hint message
/// [ ] - Do a first face detection to show a hint if faces are found before processing
/// [ ] - Haptics
///
/// TODO V3:
/// [ ] - Add Camera picker

/// V4 - Use face's roll, yaw and pitch to make the emoji match the face orientation
/// V5 - Other anonymization methods (blur, fill, ...)
/// V6 - Allow to choose the faces to Anonymojize

@main
struct AnonymojizerApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = AnonymojizerViewModel(
                faceDetector: FaceDetector(),
                anonymizer: Anonymizer(),
                imageSaver: ImageSaver()
            )

            AnonymojizerScreen(viewModel: viewModel)
        }
    }
}
