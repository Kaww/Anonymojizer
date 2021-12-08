import UIKit
import Vision

struct Anonymizer {

    enum Method {
        case emoji(_ value: Character)
    }

    func anonymize(
        _ image: UIImage,
        with method: Method,
        basedOn observations: [VNFaceObservation],
        onFinish: @escaping (UIImage?) -> Void
    ) {
        switch method {
        case let .emoji(emoji):
            emojiAnonymization(image, emoji: emoji, observations: observations, completion: onFinish)
        }
    }

    private func emojiAnonymization(
        _ image: UIImage,
        emoji: Character,
        observations: [VNFaceObservation],
        completion: @escaping (UIImage?) -> Void
    ) {
        print("Anonymizer: anonymizing with emoji \(emoji)...")
        let imageRect = CGRect(origin: .zero, size: image.size)
        let faces = observations.map {
            Face(
                rect: convertUnitToPoint(
                    originalImageRect: imageRect,
                    targetRect: $0.boundingBox
                ),
                roll: CGFloat(truncating: $0.roll ?? 0)
            )

        }
        let newImage = image.write(emoji, in: faces)

        completion(newImage)
    }
}

extension Anonymizer {
    static var preview: Anonymizer {
        Anonymizer()
    }
}
