import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var selectedCategory: String
    @FocusState.Binding var isSearchFieldActive: Bool

    var body: some View {
        HStack {
            TextField("Search items", text: $text)
                .focused($isSearchFieldActive)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .submitLabel(.search)
                .accessibilityLabel("Search field")
                .accessibilityHint("Enter text to filter food items")
                .onSubmit {
                    isSearchFieldActive = false
                }
            Picker("Search by", selection: $selectedCategory) {
                Text("Name").tag("Name")
                Text("Category").tag("Category")
                Text("Location").tag("Location")
            }
            .pickerStyle(MenuPickerStyle())
        }
        .padding()
    }
}
