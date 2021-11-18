import UIKit

protocol Anonymizer {
    func anonymize(_ image: UIImage, using emoji: String, imageViewFrame: CGRect, completion: @escaping (UIImageView?) -> Void)
}
