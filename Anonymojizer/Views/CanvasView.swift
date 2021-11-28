import Photos
import SwiftUI

struct CanvasView: View {
    private let cornerRadius: CGFloat = 20
    private let shadowRadius: CGFloat = 15

    // Rotation animation with matched geometry effect
    @Namespace private var canvasNamespace
    private let mainShapeId = "SHAPE"

    var presentedImage: UIImage?
    var showLoader: Bool
    var onTrashButtonTapped: () -> Void
    var onResetButtonTapped: () -> Void
    var onImagePicked: (UIImage) -> Void

    @State private var showImagePicker = false

    var body: some View {
        VStack {
            if let image = presentedImage {
                imageView(image)
            } else {
                placeholderView
            }
        }
        .animation(.easeInOut(duration: 0.5), value: presentedImage)
        .padding()
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(onImagePicked: onImagePicked)
                .edgesIgnoringSafeArea([.horizontal, .bottom])
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: onTrashButtonTapped) {
                    Label("Move to trash", systemImage: "trash.fill")
                }
                .disabled(presentedImage == nil)
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: onResetButtonTapped) {
                    Label("Reset image", systemImage: "arrow.counterclockwise")
                }
                .disabled(presentedImage == nil)
            }
        }
        .opacity(showLoader ? 0.5 : 1)
        .overlay(Loader(show: showLoader, scale: 2))
    }

    // MARK: Subviews

    private func imageView(_ image: UIImage) -> some View {
        VStack {
            Spacer()

            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                )
                .matchedGeometryEffect(id: mainShapeId, in: canvasNamespace)
                .shadow(radius: shadowRadius)

            Spacer()
        }
    }

    private var placeholderView: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .matchedGeometryEffect(id: mainShapeId, in: canvasNamespace)
            .foregroundColor(.gray.opacity(0.2))
            .shadow(radius: shadowRadius)
            .overlay(
                VStack {
                    cameraButton
                    Divider()
                    imagePickerButton
                }
            )
    }

    private var imagePickerButton: some View {
        Button(action: openImagePicker) {
            VStack {
                Image(systemName: "photo.fill.on.rectangle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                Text("Choose from gallery")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    private var cameraButton: some View {
        Button(action: openImagePicker) {
            VStack {
                Image(systemName: "camera.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                Text("Open camera")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    // MARK: Private methods

    private func openImagePicker() {
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {
                print("Photo library access not allowed by user.")
                return
            }

            showImagePicker = true
        }
    }
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CanvasView(
//                presentedImage: UIImage(named: "vertical"),
//                presentedImage: UIImage(named: "vertical"),
                presentedImage: nil,
                showLoader: false,
                onTrashButtonTapped: {},
                onResetButtonTapped: {},
                onImagePicked: { _ in }
            )

            Text("Other content...")
        }
    }
}
