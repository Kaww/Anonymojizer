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
/// [X] - Export sharesheet
/// [X] - Add Camera picker
/// [X] - Haptics
/// [ ] - Emojis picker
/// [ ] - Blur (cicle blurred on faces)
/// [ ] - Prevent sheets to dismiss on rotation
/// [ ] - Localization FR/EN
/// [ ] - Better flow when cancelling an image during a processing (combine ?)
/// [ ] - Hint messages
/// [ ] - Do a first face detection to show a hint if faces are found before processing
/// [ ] - Select faces to anonymize
/// [ ] - Share extension (open app from share button of any picture)
/// [ ] - Anonymize videos

/// V2 - Use face's roll, yaw and pitch to make the emoji match the face orientation
/// V3 - Allow to choose the faces to Anonymojize

@main
struct AnonymojizerApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = AnonymojizerViewModel(
                faceDetector: FaceDetector(),
                anonymizer: Anonymizer(),
                imageSaver: ImageSaver()
            )

            let hapticsEngine = HapticsEngine()

            AnonymojizerScreen(viewModel: viewModel)
                .environmentObject(hapticsEngine)
        }
    }
}
