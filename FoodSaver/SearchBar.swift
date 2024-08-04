import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var selectedCategory: String

    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Picker("Search by", selection: $selectedCategory) {
                Text("Name").tag("Name")
                Text("Category").tag("Category")
                Text("Location").tag("Location")
                Text("Status").tag("Status")
            }
            .pickerStyle(MenuPickerStyle())
        }
        .padding()
    }
}
