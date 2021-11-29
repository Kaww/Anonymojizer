import SwiftUI

struct ToolbarView: View {

    @Environment(\.verticalSizeClass) var vertical: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontal: UserInterfaceSizeClass?

    @EnvironmentObject var hapticsEngine: HapticsEngine

    // Rotation animation with matched geometry effect
    @Namespace private var toolbarNamespace
    private let methodButtonId = "METHOD_BTN"
    private let processButtonId = "PROCESS_BTN"
    private let exportButtonId = "EXPORT_BTN"

    @Binding var method: Anonymizer.Method
    var isMethodButtonEnabled: Bool
    var isProcessButtonEnabled: Bool
    var isExportButtonEnabled: Bool
    var onProcessTapped: () -> Void
    var onExportButtonTapped: () -> Void

    var body: some View {
        if horizontal == .compact && vertical == .regular {
            HStack { content } // Portrait
        } else if (horizontal == .regular && vertical == .compact) || (horizontal == .compact && vertical == .compact) {
            VStack { content } // Landscape
        } else if horizontal == .regular && vertical == .regular {
            HStack { content } // Ipad default
        }
    }

    private var content: some View {
        Group {
            Spacer()
            anonymizationMethodButton()
            Spacer()
            processButton()
            Spacer()
            exportButton()
            Spacer()
        }
    }

    // MARK: Subviews

    private func anonymizationMethodButton() -> some View {
        Button(action: anonymizationMethodButtonTapped) {
            VStack {
                Image(systemName: "face.smiling")
                    .resizable()
                    .toolbarButtonImageStyle(color: .orange)

                Text("Emoji")
                    .toolbarButtonTitleStyle(color: .orange)
            }
            .frame(maxWidth: 100)
        }
        .buttonStyle(.plain)
        .disabled(!isMethodButtonEnabled)
        .matchedGeometryEffect(id: methodButtonId, in: toolbarNamespace)
    }

    private func processButton() -> some View {
        Button(action: processButtonTapped) {
            VStack {
                Image(systemName: "wand.and.stars")
                    .resizable()
                    .toolbarButtonImageStyle(color: .blue)

                Text("Process")
                    .toolbarButtonTitleStyle(color: .blue)
            }
            .frame(maxWidth: 100)
        }
        .buttonStyle(.plain)
        .disabled(!isProcessButtonEnabled)
        .matchedGeometryEffect(id: processButtonId, in: toolbarNamespace)
    }

    private func exportButton() -> some View {
        Button(action: exportButtonTapped) {
            VStack {
                Image(systemName: "square.and.arrow.up.fill")
                    .resizable()
                    .toolbarButtonImageStyle(color: .green)

                Text("Export")
                    .toolbarButtonTitleStyle(color: .green)
            }
            .frame(maxWidth: 100)
        }
        .buttonStyle(.plain)
        .disabled(!isExportButtonEnabled)
        .matchedGeometryEffect(id: exportButtonId, in: toolbarNamespace)
    }

    // MARK: Private methods

    private func anonymizationMethodButtonTapped() {
        hapticsEngine.tap()
        // TODO: handle tap
    }

    private func processButtonTapped() {
        hapticsEngine.tap()
        onProcessTapped()
    }

    private func exportButtonTapped() {
        hapticsEngine.tap()
        onExportButtonTapped()
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView(
            method: .constant(.emoji("😀")),
            isMethodButtonEnabled: true,
            isProcessButtonEnabled: true,
            isExportButtonEnabled: true,
            onProcessTapped: {},
            onExportButtonTapped: {}
        )
    }
}
