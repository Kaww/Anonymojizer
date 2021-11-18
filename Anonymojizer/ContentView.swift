import SwiftUI

struct ContentView: View {

    let anonymizer: Anonymizer
    let imageProcessor: ImageProcessor
    let imageSaver: ImageSaver

    @State private var pickedImage: UIImage?
    @State private var showImagePicker = false
    @State private var processedImage: UIImage?

    var body: some View {
        VStack {
            if let processedImage = processedImage {
                Image(uiImage: processedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if let pickedImage = pickedImage {
                Image(uiImage: pickedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

            HStack {
                Button("Pick") {
                    showImagePicker = true
                }

                Button("Process") {
                    if let pickedImage = pickedImage {
                        processedImage = imageProcessor.textToImage(
                            drawText: "QERQWERQWERQWE",
                            inImage: pickedImage,
                            atPoint: CGPoint(x: pickedImage.size.width / 2, y: pickedImage.size.height / 2)
                        )
                    } else {
                        print("Nothing to process.")
                    }
                }

                Button("Save") {
                    if let processedImage = processedImage {
                        imageSaver.save(processedImage)
                    } else {
                        print("No processed image to save.")
                    }
                }
            }
        }
        .sheet(isPresented: $showImagePicker, onDismiss: clearAfterSelection) {
            ImagePicker(image: $pickedImage)
        }
    }

    private func clearAfterSelection() {
        processedImage = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            anonymizer: Anonymojizer.preview,
            imageProcessor: ImageProcessor(),
            imageSaver: ImageSaver()
        )
    }
}
