import SwiftUI

struct Loader: View {
    let show: Bool
    let scale: CGFloat

    init(
        show: Bool = true,
        scale: CGFloat = 1
    ) {
        self.show = show
        self.scale = scale
    }

    var body: some View {
        if show {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .tint(.white)
                .scaleEffect(scale)
        }
    }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}
