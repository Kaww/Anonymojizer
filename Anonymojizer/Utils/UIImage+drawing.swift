import UIKit

public extension UIImage {

    // Optimized method.
    // Memory impact: for a 7289x4865 pixels image, it uses around 360MB of RAM.
    // Calculatios: 7289 x 4865 x 4 ~= 150M
    // Source: https://stackoverflow.com/questions/61263161/why-use-a-lot-of-memory-when-drawing-image-with-uigraphicsimagerenderer
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
