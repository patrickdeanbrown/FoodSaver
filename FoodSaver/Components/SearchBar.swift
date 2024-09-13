import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var selectedCategory: String
    @FocusState.Binding var isSearchFieldActive: Bool

    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .focused($isSearchFieldActive)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Picker("Search by", selection: $selectedCategory) {
                Text("Name").tag("Name")
                Text("Category").tag("Category")
                Text("Location").tag("Location")
            }
            .pickerStyle(MenuPickerStyle())
        }
        .padding()
        .onTapGesture {
            isSearchFieldActive = false
        }
    }
}
