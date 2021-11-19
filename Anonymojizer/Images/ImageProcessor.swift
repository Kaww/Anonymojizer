import UIKit

struct ImageProcessor {
    func textToImage(drawText text: String, inImage image: UIImage, rect: CGRect) -> UIImage? {
        let textColor = UIColor.white
        let textFont = UIFont.systemFont(ofSize: rect.height)

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ] as [NSAttributedString.Key: Any]

        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        text.draw(
            in: CGRect(origin: rect.origin, size: rect.size),
            withAttributes: textFontAttributes
        )

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
