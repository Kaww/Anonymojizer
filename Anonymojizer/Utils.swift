import UIKit

public func determineScale(cgImage: CGImage, imageViewFrame: CGRect) -> CGRect{
    let originalWidth = CGFloat(cgImage.width)
    let originalHeight = CGFloat(cgImage.height)

    let imageFrame = imageViewFrame
    let widthRatio = originalWidth / imageFrame.width
    let heightRatio = originalHeight / imageFrame.height

    let scaleRatio = max(widthRatio, heightRatio)

    let scaledImageWidth = originalWidth / scaleRatio
    let scaledImageHeight = originalHeight / scaleRatio

    let scaledImageX = (imageFrame.width - scaledImageWidth) / 2
    let scaledImageY = (imageFrame.height - scaledImageHeight) / 2

    return CGRect(
        x: scaledImageX,
        y: scaledImageY,
        width: scaledImageWidth,
        height: scaledImageHeight
    )
}

public func convertUnitToPoint(originalImageRect: CGRect, targetRect: CGRect) -> CGRect {
    var pointRect = targetRect

    pointRect.origin.x = originalImageRect.origin.x + (targetRect.origin.x * originalImageRect.size.width)
    pointRect.origin.y = originalImageRect.origin.y + (1 - targetRect.origin.y - targetRect.height) * originalImageRect.size.height

    pointRect.size.width *= originalImageRect.size.width
    pointRect.size.height *= originalImageRect.size.height

    return pointRect
}
