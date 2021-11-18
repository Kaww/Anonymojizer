import UIKit

struct ImageProcessor {
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage? {
        let textColor = UIColor.white
        let textFont = UIFont.systemFont(ofSize: 50)

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
        ] as [NSAttributedString.Key: Any]

        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        text.draw(
            in: CGRect(origin: point, size: image.size),
            withAttributes: textFontAttributes
        )

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
