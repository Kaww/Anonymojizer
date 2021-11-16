import UIKit
import Vision

protocol FaceDetector {
    func detectFaces(in image: UIImage, completion: @escaping ([VNFaceObservation]?) -> Void)
}
