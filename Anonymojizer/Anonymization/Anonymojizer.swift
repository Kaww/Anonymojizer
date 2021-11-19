import UIKit
import Vision

class Anonymojizer: Anonymizer {
    var faceDetector: FaceDetector
    let imageProcessor: ImageProcessor

    init(
        faceDetector: FaceDetector,
        imageProcessor: ImageProcessor
    ) {
        self.faceDetector = faceDetector
        self.imageProcessor = imageProcessor
    }

    func anonymize(_ image: UIImage, using emoji: String, completion: @escaping (UIImage?) -> Void) {
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
        using emoji: String,
        completion: @escaping (UIImage?) -> Void
    ) {
        guard let cgImage = image.cgImage else {
            completion(nil)
            return
        }

        let imageRect = determineScale(cgImage: cgImage, imageViewFrame: CGRect(origin: .zero, size: image.size))

        var processingImage = image

        for observation in observations {
            let faceRect = convertUnitToPoint(originalImageRect: imageRect, targetRect: observation.boundingBox)

            print("Drawing \"\(emoji)\" in face found in: \(faceRect)")
            let newProcessedImage = imageProcessor.textToImage(
                drawText: emoji,
                inImage: processingImage,
                rect: faceRect
            )
            if let newProcessedImage = newProcessedImage {
                processingImage = newProcessedImage
            }
        }

        completion(processingImage)
    }
}

extension Anonymojizer {
    static var preview: Anonymojizer {
        Anonymojizer(
            faceDetector: SimpleFaceDetector(),
            imageProcessor: ImageProcessor()
        )
    }
}
