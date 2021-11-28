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
            print("FaceDetector: looking for faces...")
            try imageRequestHandler.perform([faceDetectionRequest])

            guard let observations = faceDetectionRequest.results else {
                print("FaceDetector: failed to process request.")
                completion(nil)
                return
            }

            print("FaceDetector: returning observations.")
            completion(observations)

        } catch let error as NSError {
            print("FaceDetector: error.")
            print(error)
            completion(nil)
        }
    }
}

extension FaceDetector {
    static var preview: FaceDetector {
        FaceDetector()
    }
}
