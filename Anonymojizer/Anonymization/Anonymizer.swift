import UIKit
import Vision

struct Anonymizer {

    enum Method {
        case emoji(_ value: Character)
    }

    var faceDetector: FaceDetector

    init(faceDetector: FaceDetector) {
        self.faceDetector = faceDetector
    }

    func anonymize(
        _ image: UIImage,
        with method: Method,
        completion: @escaping (UIImage?) -> Void
    ) {
        switch method {
        case let .emoji(emoji):
            anonymize(image, emoji: emoji, completion: completion)
        }
    }

    private func anonymize(
        _ image: UIImage,
        emoji: Character,
        completion: @escaping (UIImage?) -> Void
    ) {
        faceDetector.detectFaces(in: image) { observations in
            if let observations = observations, observations.count > 0 {
                self.processAnonymization(
                    in: image,
                    observations: observations,
                    using: emoji,
                    completion: completion
                )
            } else {
                print("No faces found.")
                completion(nil)
            }
        }
    }

    private func processAnonymization(
        in image: UIImage,
        observations: [VNFaceObservation],
        using emoji: Character,
        completion: @escaping (UIImage?) -> Void
    ) {
        let imageRect = CGRect(origin: .zero, size: image.size)
        let facesRects = observations.map {
            convertUnitToPoint(
                originalImageRect: imageRect,
                targetRect: $0.boundingBox
            )
        }
        let newImage = image.write(emoji, in: facesRects)

        completion(newImage)
    }
}

extension Anonymizer {
    static var preview: Anonymizer {
        Anonymizer(
            faceDetector: FaceDetector()
        )
    }
}
