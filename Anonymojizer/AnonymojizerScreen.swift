import SwiftUI

struct AnonymojizerScreen: View {

    @Environment(\.verticalSizeClass) var vertical: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontal: UserInterfaceSizeClass?

    @ObservedObject var viewModel: AnonymojizerViewModel

    var body: some View {
        NavigationView {
            VStack() {
                if horizontal == .compact && vertical == .regular {
                    VStack { content } // Portrait
                } else if (horizontal == .regular && vertical == .compact) || (horizontal == .compact && vertical == .compact) {
                    HStack { content } // Landscape
                } else if horizontal == .regular && vertical == .regular {
                    VStack { content } // Ipad default
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Anonymojizer")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.blue)
                }
            }
        }
    }

    private var content: some View {
        Group {
            CanvasView(
                presentedImage: viewModel.processedImage ?? viewModel.image,
                showLoader: viewModel.isLoading,
                onTrashButtonTapped: viewModel.clear,
                onResetButtonTapped: viewModel.resetImage,
                onImagePicked: viewModel.accept
            )

            ToolbarView(
                method: $viewModel.method,
                isMethodButtonEnabled: viewModel.image != nil,
                isProcessButtonEnabled: viewModel.image != nil,
                isExportButtonEnabled: viewModel.processedImage != nil,
                onProcessTapped: viewModel.processImage,
                onExportButtonTapped: viewModel.saveProcessedImage
            )
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
}

struct AnonymojizerScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnonymojizerScreen(viewModel: AnonymojizerViewModel.preview)
    }
}
