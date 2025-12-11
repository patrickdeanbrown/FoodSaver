import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var selectedCategory: String
    @FocusState.Binding var isSearchFieldActive: Bool

    var body: some View {
        HStack(spacing: Theme.Spacing.sm) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Theme.textTertiary)
                TextField("Search items", text: $text)
                    .focused($isSearchFieldActive)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .submitLabel(.search)
                    .foregroundColor(Theme.textPrimary)
                    .accessibilityLabel("Search field")
                    .accessibilityHint("Enter text to filter food items")
                    .onSubmit { isSearchFieldActive = false }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(Theme.surface)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Theme.border, lineWidth: 1)
            )
            .cornerRadius(14)

            Picker("Search by", selection: $selectedCategory) {
                Text("Name").tag("Name")
                Text("Category").tag("Category")
                Text("Location").tag("Location")
            }
            .pickerStyle(MenuPickerStyle())
            .tint(Theme.secondaryColor)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Theme.surfaceAlt)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Theme.border, lineWidth: 1)
            )
            .cornerRadius(14)
        }
    }
}
