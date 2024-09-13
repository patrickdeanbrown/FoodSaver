import SwiftUI

struct ActionButtons: View {
    var onCancel: () -> Void
    var onSave: () -> Void

    var body: some View {
        HStack(spacing: 20) {
            // Cancel Button
            Button(action: {
                onCancel()
            }) {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .padding()
                    .background(Theme.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .accessibilityLabel("Cancel")

            Spacer()

            // Save Button
            Button(action: {
                onSave()
            }) {
                Image(systemName: "tray.and.arrow.down.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .padding()
                    .background(Theme.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .accessibilityLabel("Save")
        }
    }
}
