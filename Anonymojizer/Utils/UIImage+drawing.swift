import UIKit
import Vision

public struct Face {
    public let rect: CGRect
    /// Face roll angle in radians
    public let roll: CGFloat
}

public extension UIImage {

    /// Writes emoji in faces
    func write(_ emoji: Character, in faces: [Face]) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: self.size, format: format)

        let img = renderer.image { ctx in
            self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))

            for face in faces {
                let emojiImage = createEmojiImage(
                    emoji: emoji,
                    rect: face.rect,
                    roll: 0//face.roll
                )
                emojiImage.draw(in: face.rect)
            }

        }

        return img
    }

    private func createEmojiImage(emoji: Character, rect: CGRect, roll: CGFloat) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: rect.size)

        return renderer.image { ctx in

            ctx.cgContext.translateBy(x: -rect.width / 2, y: -rect.height / 2)
            ctx.cgContext.rotate(by: -roll)
            ctx.cgContext.translateBy(x: rect.width / 2, y: rect.height / 2)

            let textFont = UIFont.systemFont(ofSize: rect.size.height * 0.9)
            let textFontAttributes = [NSAttributedString.Key.font: textFont] as [NSAttributedString.Key: Any]

            "\(emoji)".draw(
                in: CGRect(
                    origin: .zero,
                    size: CGSize(
                        width: rect.width,
                        height: rect.height
                    )
                ),
                withAttributes: textFontAttributes
            )

            ctx.cgContext.translateBy(x: -rect.width / 2, y: -rect.height / 2)
            ctx.cgContext.rotate(by: roll)
            ctx.cgContext.translateBy(x: rect.width / 2, y: rect.height / 2)
        }
    }

    private func debugRectFrame(of rect: CGRect, in ctx: UIGraphicsImageRendererContext, color: CGColor = UIColor.red.cgColor) {
        ctx.cgContext.setFillColor(CGColor(gray: 1, alpha: 0))
        ctx.cgContext.setStrokeColor(color)
        ctx.cgContext.setLineWidth(1)

        ctx.cgContext.addRect(rect)
        ctx.cgContext.drawPath(using: CGPathDrawingMode.fillStroke)
    }
}

// MARK: OLD

public extension UIImage {
    // Optimized method.
    // Memory impact: for a 7289x4865 pixels image, it uses around 360MB of RAM.
    // Calculations: 7289 x 4865 x 4 ~= 150M
    // Source: https://stackoverflow.com/questions/61263161/why-use-a-lot-of-memory-when-drawing-image-with-uigraphicsimagerenderer
    /// Writes emoji in rects - OLD METHOD
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
