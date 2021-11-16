import UIKit
import Vision

class Anonymojizer: Anonymizer {
    var faceDetector: FaceDetector

    init(faceDetector: FaceDetector) {
        self.faceDetector = faceDetector
    }

    func anonymize(_ image: UIImage, using emoji: String, imageViewFrame: CGRect, completion: @escaping (UIImageView?) -> Void) {
        faceDetector.detectFaces(in: image) { observations in
            if let observations = observations {
                self.processAnonymization(
                    in: image,
                    observations: observations,
                    imageFrame: imageViewFrame,
                    completion: completion
                )
            } else {
                completion(nil)
            }
        }
    }

    private func processAnonymization(
        in image: UIImage,
        observations: [VNFaceObservation],
        imageFrame: CGRect,
        completion: @escaping (UIImageView?) -> Void
    ) {
        guard let cgImage = image.cgImage else {
            completion(nil)
            return
        }

        let imageRect = determineScale(cgImage: cgImage, imageViewFrame: imageFrame)

        let imageView = UIImageView(image: image)

        for observation in observations {
            let faceRect = convertUnitToPoint(originalImageRect: imageRect, targetRect: observation.boundingBox)

            let adjustedRect = CGRect(
                x: faceRect.origin.x,
                y: faceRect.origin.y,
                width: faceRect.size.width,
                height: faceRect.size.height
            )

            let textLayer = CATextLayer()
            textLayer.string = "😄"
            textLayer.fontSize = faceRect.width
            textLayer.frame = adjustedRect
            textLayer.contentsScale = UIScreen.main.scale

            imageView.layer.addSublayer(textLayer)
        }

        completion(imageView)
    }
}
