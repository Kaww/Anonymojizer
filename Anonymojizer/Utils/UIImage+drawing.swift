import UIKit

public extension UIImage {

    func write(_ emoji: Character, in rect: CGRect) -> UIImage {
        let textFont = UIFont.systemFont(ofSize: rect.height)
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont
        ] as [NSAttributedString.Key: Any]

        let renderer = UIGraphicsImageRenderer(size: self.size)

        let img = renderer.image { ctx in
            self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))

            "\(emoji)".draw(
                in: CGRect(origin: rect.origin, size: rect.size),
                withAttributes: textFontAttributes
            )
        }

        return img
    }
}
