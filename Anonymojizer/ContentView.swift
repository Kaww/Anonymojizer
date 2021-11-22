import SwiftUI

struct ContentView: View {

    let anonymizer: Anonymizer
    let imageSaver: ImageSaver

    @State private var pickedImage: UIImage?
    @State private var showImagePicker = false
    @State private var processedImage: UIImage?

    var body: some View {
        NavigationView {
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
            }
            .sheet(isPresented: $showImagePicker, onDismiss: clearAfterSelection) {
                ImagePicker(image: $pickedImage)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Anonymojizer")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.blue)
                }

                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: pickImage) {
                        Text("Choose a Photo")
                    }

                    Button(action: processImage) {
                        Text("Anonymize")
                    }

                    Button(action: saveProcessedImage) {
                        Text("Save Photo")
                    }
                }
            }
        }
    }

    private func clearAfterSelection() {
        processedImage = nil
    }

    private func pickImage() {
        showImagePicker = true
    }

    private func processImage() {
        if let pickedImage = pickedImage {
            anonymizer.anonymize(pickedImage, with: .emoji("😀")) { anonymizedImage in
                guard let anonymizedImage = anonymizedImage else { return }
                self.processedImage = anonymizedImage
            }
        }
    }

    private func saveProcessedImage() {
        if let processedImage = processedImage {
            imageSaver.save(processedImage)
        } else {
            print("No processed image to save.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            anonymizer: Anonymizer.preview,
            imageSaver: ImageSaver()
        )
    }
}
