import SwiftUI

@available(iOS 15.0, *)
struct FloatingActionButton: View {
    var action: () -> Void
    var icon: String = "plus"

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .padding(20)
                .background(Color.accentColor)
                .clipShape(Circle())
                .shadow(radius: 4, x: 0, y: 4)
        }
        .padding()
    }
}

#Preview {
    FloatingActionButton(action: {})
}
