import Photos
import SwiftUI

struct CanvasView: View {
    @EnvironmentObject var hapticsEngine: HapticsEngine

    private let cornerRadius: CGFloat = 20
    private let shadowRadius: CGFloat = 15

    // Rotation animation with matched geometry effect
    @Namespace private var canvasNamespace
    private let mainShapeId = "SHAPE"

    var originalImage: UIImage?
    var processedImage: UIImage?
    var showLoader: Bool
    var onTrashButtonTapped: () -> Void
    var onResetButtonTapped: () -> Void
    var onImagePicked: (UIImage) -> Void

    @State private var showImagePicker = false
    @State private var showCameraPicker = false
    @State private var showOriginal = false

    private var presentingImage: UIImage? {
        showOriginal ? originalImage : (processedImage ?? originalImage)
    }

    var body: some View {
        VStack {
            if let image = presentingImage {
                imageView(image)
            } else {
                placeholderView
            }
        }
        .animation(.easeInOut(duration: 0.3), value: originalImage)
        .padding()
        .onLongPressGesture(
            minimumDuration: 2,
            maximumDistance: 50,
            perform: {},
            onPressingChanged: { showOriginal = $0 }
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: trashButtonTapped) {
                    Label("Move to trash", systemImage: "trash.fill")
                }
                .disabled(originalImage == nil)
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: resetButtonTapped) {
                    Label("Reset image", systemImage: "arrow.counterclockwise")
                }
                .disabled(originalImage == nil)
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
                        .fullScreenCover(isPresented: $showCameraPicker) {
                            ImagePicker(onImagePicked: onImagePicked, source: .camera)
                                .edgesIgnoringSafeArea(.all)
                        }
                    Divider()
                    imagePickerButton
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(onImagePicked: onImagePicked, source: .photoLibrary)
                                .edgesIgnoringSafeArea([.horizontal, .bottom])
                        }
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
        Button(action: openCameraPicker) {
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

    private func trashButtonTapped() {
        hapticsEngine.notify(.error)
        onTrashButtonTapped()
    }

    private func resetButtonTapped() {
        hapticsEngine.tap()
        onResetButtonTapped()
    }

    private func openCameraPicker() {
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {
                print("Camera access not allowed by user.")
                return
            }

            showCameraPicker = true
        }
    }

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
                originalImage: nil,
                processedImage: nil,
                showLoader: false,
                onTrashButtonTapped: {},
                onResetButtonTapped: {},
                onImagePicked: { _ in }
            )

            Text("Other content...")
        }
    }
}
