import SwiftUI

struct ToolbarButtonImage: ViewModifier {
    @Environment(\.isEnabled) var isEnabled

    let color: Color

    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fit)
            .frame(width: 35, height: 35)
            .foregroundColor(.white)
            .padding(12)
            .background(
                Circle().foregroundColor(isEnabled ? color : .gray)
            )
    }
}

extension View {
    func toolbarButtonImageStyle(color: Color) -> some View {
        modifier(ToolbarButtonImage(color: color))
    }
}
