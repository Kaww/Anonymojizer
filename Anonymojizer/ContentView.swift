import SwiftUI

struct ContentView: View {

    let anonymizer: Anonymizer

    @State private var imageView: UIImageView?
    @State private var imageViewWrapper: ImageViewWrapper?

    @State private var showImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        VStack {
            if let wrapper = imageViewWrapper {
                wrapper

            } else {
                chooseImageButton
            }

            HStack {
                processImageButton
                clearButton
            }
        }
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else {
            // Error
            imageView = nil
            return
        }

        self.imageView = UIImageView(image: inputImage)
    }

    func processImage() {
        guard
            let image = imageView?.image,
            let frame = imageView?.frame
        else { return }

        anonymizer.anonymize(image, using: "😄", imageViewFrame: frame) { newImageView in
            if let newImageView = newImageView {
                self.imageView = newImageView
                self.imageView = nil
                self.imageViewWrapper = ImageViewWrapper(newImageView)
            } else {
                self.imageView = nil
            }
        }
    }

    private var chooseImageButton: some View {
        Button(action: { showImagePicker = true }) {
            VStack {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .foregroundColor(.gray)

                Text("Pick an image")
            }
        }
    }

    private var processImageButton: some View {
        Button(action: processImage) {
            Text("Process")
        }
    }

    private var clearButton: some View {
        Button(action: {
            self.imageView = nil
            self.imageViewWrapper = nil
        }) {
            Image(systemName: "multiply.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25)
                .foregroundColor(.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(anonymizer: .preview)
    }
}
