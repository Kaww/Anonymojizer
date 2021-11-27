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

    /// Optimized method.
    /// No better memory impact, but I find it cleaner.
    /// For a 7289x4865 pixels images, it takes around 360MB of RAM.
    /// 7289 x 4865 x 4 ~= 150M
    func write(_ emoji: Character, in rects: [CGRect]) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: self.size, format: format)

        let img = renderer.image { ctx in
            self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))

            for rect in rects {
                let textFont = UIFont.systemFont(ofSize: rect.height)
                let textFontAttributes = [NSAttributedString.Key.font: textFont] as [NSAttributedString.Key: Any]

                "\(emoji)".draw(
                    in: CGRect(origin: rect.origin, size: rect.size),
                    withAttributes: textFontAttributes
                )
            }
        }

        return img
    }
}
