import SwiftUI

struct ImageViewWrapper: UIViewRepresentable {

    var imageView: UIImageView

    init(_ imageView: UIImageView) {
        self.imageView = imageView
    }

    func makeUIView(context: Context) -> UIImageView {
        let iv = imageView
        iv.contentMode = .scaleAspectFit
        return iv
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {}
}
