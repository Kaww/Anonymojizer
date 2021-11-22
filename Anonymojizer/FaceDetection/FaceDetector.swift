import UIKit
import Vision

struct FaceDetector {
    func detectFaces(in image: UIImage, completion: @escaping ([VNFaceObservation]?) -> Void) {
        guard
            let cgImage = image.cgImage,
            let orientation = CGImagePropertyOrientation(rawValue: .init(image.imageOrientation.rawValue))
        else {
            completion(nil)
            return
        }

        let faceDetectionRequest = VNDetectFaceRectanglesRequest()
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: orientation, options: [:])

        do {
            try imageRequestHandler.perform([faceDetectionRequest])

            guard let observations = faceDetectionRequest.results else {
                completion(nil)
                return
            }

            completion(observations)

        } catch let error as NSError {
            print(error)
            completion(nil)
        }
    }
}
