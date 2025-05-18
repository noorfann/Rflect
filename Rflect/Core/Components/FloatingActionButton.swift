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
                .font(.title3.bold())
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(Circle().fill(Color.theme.accent))
                .shadow(color: Color.theme.accent.opacity(0.3), radius: 10, x: 0, y: 5)
        }
        .padding()
    }
}

#Preview {
    FloatingActionButton(action: {})
}
