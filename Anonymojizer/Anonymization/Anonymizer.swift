import UIKit

protocol Anonymizer {
    func anonymize(_ image: UIImage, using emoji: String, completion: @escaping (UIImage?) -> Void)
}
