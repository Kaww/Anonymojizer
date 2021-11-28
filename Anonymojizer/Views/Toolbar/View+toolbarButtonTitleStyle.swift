import SwiftUI

struct ToolbarButtonTitle: ViewModifier {
    @Environment(\.isEnabled) var isEnabled

    let color: Color

    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .font(.subheadline)
            .foregroundColor(isEnabled ? color : .gray)
    }
}

extension View {
    func toolbarButtonTitleStyle(color: Color) -> some View {
        modifier(ToolbarButtonTitle(color: color))
    }
}
