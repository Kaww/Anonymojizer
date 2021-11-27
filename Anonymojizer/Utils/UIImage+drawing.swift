import UIKit

public extension UIImage {

    /// When initializing the renderer, I use a form.scale of 1 to fix a crash causing by high memory usage
    /// Read more here: https://stackoverflow.com/questions/61263161/why-use-a-lot-of-memory-when-drawing-image-with-uigraphicsimagerenderer
    func write(_ emoji: Character, in rect: CGRect) -> UIImage {
        let textFont = UIFont.systemFont(ofSize: rect.height)
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont
        ] as [NSAttributedString.Key: Any]

        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: self.size, format: format)

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
