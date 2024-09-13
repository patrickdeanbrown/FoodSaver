import SwiftUI

struct LocationPicker: View {
    @Binding var location: String
    let locations: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Location")
                .font(Theme.headlineFont)
                .foregroundColor(Theme.secondaryColor)
            Menu {
                ForEach(locations, id: \.self) { location in
                    Button(action: {
                        self.location = location
                    }) {
                        Text(location)
                    }
                }
            } label: {
                HStack {
                    Text(location.isEmpty ? "Select location" : location)
                        .foregroundColor(location.isEmpty ? .gray : .primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
            }
        }
        .padding(.horizontal)
    }
}
