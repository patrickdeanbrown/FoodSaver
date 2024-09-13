import SwiftUI

struct ItemNameField: View {
    @Binding var name: String
    @FocusState.Binding var isInputActive: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text("Item Name")
                .font(Theme.headlineFont)
                .foregroundColor(Theme.secondaryColor)
            TextField("Enter item name", text: $name)
                .focused($isInputActive)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isInputActive ? Theme.accentColor : Color.gray, lineWidth: 1)
                )
                .autocapitalization(.words)
        }
        .padding(.horizontal)
    }
}
