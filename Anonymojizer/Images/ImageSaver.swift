import UIKit
import Photos

class ImageSaver: NSObject {
    func save(_ image: UIImage) {
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else { return }

            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.saveError), nil)
        }
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print(error)
        } else {
            print("Image successfully saved!")
        }
    }
}
