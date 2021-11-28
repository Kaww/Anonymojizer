import Combine
import UIKit

class AnonymojizerViewModel: ObservableObject {

    @Published var image: UIImage?
    @Published var processedImage: UIImage?
    @Published var method: Anonymizer.Method = .emoji("😀")
    @Published var isLoading = false

    private let faceDetector: FaceDetector
    private let anonymizer: Anonymizer
    private let imageSaver: ImageSaver

    private var cancellables = Set<AnyCancellable>()

    init(
        faceDetector: FaceDetector,
        anonymizer: Anonymizer,
        imageSaver: ImageSaver
    ) {
        self.faceDetector = faceDetector
        self.anonymizer = anonymizer
        self.imageSaver = imageSaver
    }

    // MARK: Actions

    func accept(_ image: UIImage) {
        print("VM: new picked image.")
        self.image = image
        processedImage = nil
    }

    func processImage() {
        print("VM: process image. Loading...")
        isLoading = true
        DispatchQueue.global(qos: .userInitiated).async {
            self.process { anonymizedImage in
                DispatchQueue.main.async {
                    self.isLoading = false
                    print("VM: processing done.")
                    if let anonymizedImage = anonymizedImage {
                        self.processedImage = anonymizedImage
                        print("VM: anonymization succeed!")
                    } else {
                        print("VM: anonymization failed.")
                    }
                }
            }
        }
    }

    /// Restart canvas without any images
    func clear() {
        image = nil
        processedImage = nil
        print("VM: all images cleared.")
    }

    /// Restart from source image
    func resetImage() {
        processedImage = nil
        print("VM: restored source image.")
    }

    func saveProcessedImage() {
        guard let processedImage = processedImage else {
            print("VM: no image to be saved.")
            return
        }
        print("VM: saving processed image...")
        imageSaver.save(processedImage)
    }

    // MARK: Private methods

    private func process(_ completion: @escaping (UIImage?) -> Void) {
        guard let image = image else {
            print("VM: no image to be processed.")
            completion(nil)
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            self.faceDetector.detectFaces(in: image) { observations in
                guard let observations = observations, observations.count > 0 else {
                    print("VM: no faces found.")
                    completion(nil)
                    return
                }

                print("VM: faces found, start anonymization process...")
                self.anonymizer.anonymize(
                    image,
                    with: self.method,
                    basedOn: observations,
                    onFinish: completion
                )
            }
        }
    }
}

extension AnonymojizerViewModel {
    static var preview: AnonymojizerViewModel {
        AnonymojizerViewModel(
            faceDetector: FaceDetector.preview,
            anonymizer: Anonymizer.preview,
            imageSaver: ImageSaver.preview
        )
    }
}
