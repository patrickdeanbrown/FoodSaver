import SwiftUI

struct ActionButtons: View {
    var onCancel: () -> Void
    var onSave: () -> Void

    var body: some View {
        HStack(spacing: Theme.Spacing.md) {
            Button(action: { onCancel() }) {
                HStack(spacing: 8) {
                    Image(systemName: "xmark.circle")
                        .font(.headline)
                    Text("Cancel")
                        .font(Theme.bodyFont.weight(.semibold))
                }
                .foregroundColor(Theme.textPrimary)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(Theme.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Theme.border, lineWidth: 1)
                )
                .cornerRadius(12)
            }
            .accessibilityLabel("Cancel")

            Spacer()

            Button(action: { onSave() }) {
                HStack(spacing: 8) {
                    Image(systemName: "tray.and.arrow.down.fill")
                        .font(.headline)
                    Text("Save")
                        .font(Theme.bodyFont.weight(.semibold))
                }
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal, 18)
                .background(Theme.primaryColor)
                .cornerRadius(12)
                .shadow(color: Theme.cardShadow.opacity(0.6), radius: 8, x: 0, y: 4)
            }
            .accessibilityLabel("Save")
        }
    }
}
