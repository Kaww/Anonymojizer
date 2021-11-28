import SwiftUI
import Photos

struct AnonymojizerView: View {

    @ObservedObject var viewModel: AnonymojizerViewModel

    @State private var showImagePicker = false

    var body: some View {
        NavigationView {
            VStack {
                presentedImage
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker { image in
                    viewModel.accept(image)
                }
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

                    Button(action: viewModel.processImage) {
                        Text("Anonymize")
                    }

                    Button(action: viewModel.saveProcessedImage) {
                        Text("Save Photo")
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var presentedImage: some View {
        if let processedImage = viewModel.processedImage {
            Image(uiImage: processedImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else if let pickedImage = viewModel.image {
            Image(uiImage: pickedImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }

    private func pickImage() {
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {
                print("Photo library access not allowed by user.")
                return
            }

            showImagePicker = true
        }
    }
}

struct AnonymojizerView_Previews: PreviewProvider {
    static var previews: some View {
        AnonymojizerView(viewModel: AnonymojizerViewModel.preview)
    }
}
