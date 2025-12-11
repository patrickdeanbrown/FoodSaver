import SwiftUI

struct ItemNameField: View {
    @Binding var name: String
    @FocusState.Binding var isInputActive: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Item Name")
                .font(Theme.headlineFont)
                .foregroundColor(Theme.textSecondary)
            TextField("Enter item name", text: $name)
                .focused($isInputActive)
                .textInputAutocapitalization(.words)
                .textContentType(.name)
                .padding(.vertical, 12)
                .padding(.horizontal, 14)
                .background(Theme.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isInputActive ? Theme.primaryColor : Theme.border, lineWidth: 1)
                )
                .cornerRadius(12)
        }
        .padding(.horizontal, Theme.Spacing.md)
    }
}
